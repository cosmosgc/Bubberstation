#!/usr/bin/env pwsh
<#
.SYNOPSIS
Iteratively fix compiler errors by reverting problematic lines one at a time.

.DESCRIPTION
1. Runs BUILD.bat
2. Parses DM compiler errors (file:line format)
3. Reverts each problematic line using git
4. Re-runs BUILD.bat
5. Stops after 3 consecutive failures on the same error

.PARAMETER MaxRetries
Maximum retry count per error (default 3)

.PARAMETER BuildScript
Path to build script (default ./BUILD.bat)

.EXAMPLE
.\fix_errors_incremental.ps1
.\fix_errors_incremental.ps1 -MaxRetries 5
#>

param(
    [int]$MaxRetries = 3,
    [string]$BuildScript = ".\BUILD.bat"
)

$ErrorActionPreference = "Continue"

Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "Incremental Error Fixer" -ForegroundColor Cyan
Write-Host "=" * 60

# Track errors we've already tried to fix
$errorHistory = @{}
$totalFixed = 0
$iterationCount = 0
$maxIterations = 50

function Parse-CompilerErrors {
    param([string]$buildOutput)

    $errors = @()

    # Match pattern: path/to/file.dm:LINE:error: message
    $pattern = '([^\s:]+\.dm):(\d+):error:\s*(.+?)(?:\n|$)'

    $matches = [regex]::Matches($buildOutput, $pattern)

    foreach ($match in $matches) {
        $file = $match.Groups[1].Value
        $line = [int]$match.Groups[2].Value
        $message = $match.Groups[3].Value

        $errors += @{
            File = $file
            Line = $line
            Message = $message
            Key = "$file`:$line"
        }
    }

    return $errors
}

function Get-FileLineContent {
    param(
        [string]$File,
        [int]$LineNum
    )

    if (-not (Test-Path $File)) {
        return $null
    }

    try {
        $content = Get-Content $File -Raw
        $lines = $content -split "`n"
        if ($LineNum -gt 0 -and $LineNum -le $lines.Count) {
            return $lines[$LineNum - 1]
        }
    }
    catch {
        Write-Host "Error reading file: $_" -ForegroundColor Red
    }

    return $null
}

function Revert-FileLine {
    param(
        [string]$File,
        [int]$LineNum
    )

    Write-Host "Reverting $File line $LineNum..." -ForegroundColor Yellow

    # Get the original line from git
    try {
        $originalContent = & git show "HEAD:$File" 2>$null

        if ($null -eq $originalContent) {
            Write-Host "  ✗ File not in HEAD" -ForegroundColor Red
            return $false
        }

        $originalLines = $originalContent -split "`n"

        if ($LineNum -le 0 -or $LineNum -gt $originalLines.Count) {
            Write-Host "  ✗ Line number out of range" -ForegroundColor Red
            return $false
        }

        $originalLine = $originalLines[$LineNum - 1]

        # Read current file
        $currentContent = Get-Content $File -Raw
        $currentLines = $currentContent -split "`n"

        # Replace the line
        if ($LineNum -le $currentLines.Count) {
            $currentLines[$LineNum - 1] = $originalLine

            # Write back
            $newContent = $currentLines -join "`n"
            Set-Content $File -Value $newContent -NoNewline

            Write-Host "  ✓ Reverted" -ForegroundColor Green
            Write-Host "    Original: $originalLine" -ForegroundColor DarkGray
            return $true
        }
        else {
            Write-Host "  ✗ Current file has fewer lines" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "  ✗ Error: $_" -ForegroundColor Red
        return $false
    }
}

function Run-Build {
    Write-Host "`nRunning build..." -ForegroundColor Cyan

    try {
        $buildPath = Resolve-Path $BuildScript -ErrorAction Stop
        $output = & cmd /c $buildPath 2>&1
        return $output
    }
    catch {
        Write-Host "Build failed to run: $_" -ForegroundColor Red
        return $null
    }
}

# Main loop
while ($iterationCount -lt $maxIterations) {
    $iterationCount++
    Write-Host "`n" + ("=" * 60) -ForegroundColor Cyan
    Write-Host "Iteration $iterationCount" -ForegroundColor Cyan
    Write-Host ("=" * 60) -ForegroundColor Cyan

    # Run build
    $buildOutput = Run-Build

    if ($null -eq $buildOutput) {
        break
    }

    # Check if build succeeded
    if ($buildOutput -match "0 errors") {
        Write-Host "`n✓ BUILD SUCCESSFUL!" -ForegroundColor Green
        Write-Host "Fixed $totalFixed error(s) total" -ForegroundColor Green
        break
    }

    # Parse errors
    $errors = Parse-CompilerErrors $buildOutput

    if ($errors.Count -eq 0) {
        Write-Host "`nNo errors found in output, but build failed." -ForegroundColor Yellow
        Write-Host "Last lines of output:" -ForegroundColor Yellow
        $buildOutput -split "`n" | Select-Object -Last 5 | ForEach-Object {
            Write-Host "  $_" -ForegroundColor DarkGray
        }
        break
    }

    Write-Host "Found $($errors.Count) error(s)" -ForegroundColor Yellow
    Write-Host ""

    # Process first unresolved error
    $fixed = $false

    foreach ($error in $errors) {
        $key = $error.Key

        if ($null -eq $errorHistory[$key]) {
            $errorHistory[$key] = @{
                Count = 0
                Message = $error.Message
            }
        }

        $retryCount = $errorHistory[$key].Count

        Write-Host "  [$($retryCount + 1)/$MaxRetries] $key" -ForegroundColor Yellow
        Write-Host "    Error: $($error.Message)" -ForegroundColor DarkGray

        if ($retryCount -ge $MaxRetries) {
            Write-Host "    ✗ Max retries reached, skipping" -ForegroundColor Red
            continue
        }

        # Try to revert this line
        if (Revert-FileLine -File $error.File -Line $error.Line) {
            $errorHistory[$key].Count++
            $totalFixed++
            $fixed = $true
            break  # Fix one error at a time, then rebuild
        }
        else {
            $errorHistory[$key].Count++
            $fixed = $true  # Try next error
            break
        }
    }

    # Check if all errors have been maxed out
    $allMaxedOut = $true
    foreach ($key in $errorHistory.Keys) {
        if ($errorHistory[$key].Count -lt $MaxRetries) {
            $allMaxedOut = $false
            break
        }
    }

    if ($allMaxedOut -and -not $fixed) {
        Write-Host "`n✗ All errors have exceeded max retries" -ForegroundColor Red
        Write-Host "Unable to automatically fix:" -ForegroundColor Red
        foreach ($key in $errorHistory.Keys) {
            $err = $errorHistory[$key]
            Write-Host "  - $key : $($err.Message)" -ForegroundColor DarkRed
        }
        break
    }

    if (-not $fixed) {
        Write-Host "`nNo more errors to process" -ForegroundColor Cyan
        break
    }
}

Write-Host "`n" + ("=" * 60) -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Iterations: $iterationCount" -ForegroundColor White
Write-Host "Lines reverted: $totalFixed" -ForegroundColor White
Write-Host "Error attempts:" -ForegroundColor White

foreach ($key in $errorHistory.Keys | Sort-Object) {
    $err = $errorHistory[$key]
    $status = if ($err.Count -ge $MaxRetries) { "✗ FAILED" } else { "✓ OK" }
    Write-Host "  $status $key ($($err.Count)/$MaxRetries)" -ForegroundColor White
}

Write-Host ""
