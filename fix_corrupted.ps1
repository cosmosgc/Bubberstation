#!/usr/bin/env pwsh
<#
.SYNOPSIS
Find and revert corrupted files using git diff --numstat.
Looks for files with 100+ lines added AND 100+ lines deleted.

.PARAMETER Threshold
Minimum number of +/- lines to flag a file as suspicious (default 100)

.PARAMETER Run
Actually revert files instead of dry run
#>

param(
    [int]$Threshold = 100,
    [switch]$Run
)

Write-Host "Searching for corrupted files (threshold: $Threshold+)"
Write-Host "Mode: $(if ($Run) { 'REVERT' } else { 'DRY RUN' })`n"

# Get git diff numstat: "additions  deletions  filename"
$rawLines = git diff --numstat -- '*.dm' '*.tsx' '*.ts' 2>&1
$lines = @($rawLines | Where-Object {$_ -notmatch 'warning:'})

Write-Host "Checking $($lines.Count) files...`n"

$corrupted = @()

foreach ($line in $lines) {
    if ($line -match '^\s*(\d+)\s+(\d+)\s+(.+)$') {
        $adds = [int]$matches[1]
        $dels = [int]$matches[2]
        $filepath = $matches[3].Trim()

        # Skip files with only 0 lines changed
        if ($adds -eq 0 -and $dels -eq 0) {
            continue
        }

        # Flag files with both significant additions AND deletions
        if ($adds -ge $Threshold -and $dels -ge $Threshold) {
            $corrupted += $filepath
            Write-Host "SUSPICIOUS: $filepath" -ForegroundColor Yellow
            Write-Host "  +$adds, -$dels`n" -ForegroundColor Yellow
        }
    }
}

if ($corrupted.Count -eq 0) {
    Write-Host "✓ No suspicious files found." -ForegroundColor Green
    exit 0
}

Write-Host "Found $($corrupted.Count) file(s) to fix`n"

if ($Run) {
    Write-Host "Reverting files..."
    foreach ($file in $corrupted) {
        git checkout HEAD -- "$file"
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  OK: $file"
        } else {
            Write-Host "  FAILED: $file" -ForegroundColor Red
        }
    }
    Write-Host "`nDone!" -ForegroundColor Green
} else {
    Write-Host "Files to revert:"
    $corrupted | ForEach-Object { Write-Host "  - $_" }
    Write-Host "`nTo actually revert, run:"
    Write-Host "  .\fix_corrupted.ps1 -Threshold $Threshold -Run"
}

exit $corrupted.Count
