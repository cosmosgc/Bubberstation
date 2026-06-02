#!/usr/bin/env pwsh
<#
.SYNOPSIS
Find and revert corrupted files using git diff.

.PARAMETER Threshold
Minimum number of +/- lines to flag a file as suspicious (default 100)

.PARAMETER Run
Actually revert files instead of dry run

.EXAMPLE
.\find_and_fix_corrupted.ps1                    # Dry run, threshold 100
.\find_and_fix_corrupted.ps1 -Threshold 50      # Dry run, threshold 50
.\find_and_fix_corrupted.ps1 -Threshold 100 -Run # Actually revert
#>

param(
    [int]$Threshold = 100,
    [switch]$Run
)

Write-Host "Searching for corrupted files with threshold: $Threshold+"
Write-Host "Mode: $(if ($Run) { 'REVERT' } else { 'DRY RUN' })"
Write-Host ""

# Get git diff stats for working directory changes
$diff = git diff --stat -- '*.dm', '*.tsx', '*.ts' 2>$null

if (-not $diff) {
    Write-Host "No changes found"
    exit 0
}

$corrupted = @()

# Process each line from git diff output
$diff | ForEach-Object {
    if ($_ -match '^\s*(.+?)\s+\|\s+(\d+)\s+(.+)') {
        $deletions = ($changes -replace '[^-]', '').Length

        # Flag files with both significant additions AND deletions
        if ($additions -ge $Threshold -and $deletions -ge $Threshold) {
            $corrupted += @{
                File = $filepath
                Add  = $additions
                Del  = $deletions
            }

            Write-Host "SUSPICIOUS: $filepath" -ForegroundColor Yellow
            Write-Host "  Additions: $additions, Deletions: $deletions" -ForegroundColor Yellow
        }
    }
}

Write-Host ""

if ($corrupted.Count -eq 0) {
    Write-Host "No suspicious files found." -ForegroundColor Green
    exit 0
}

Write-Host "Found $($corrupted.Count) suspicious file(s)" -ForegroundColor Cyan
Write-Host ""

if ($Run) {
    Write-Host "Reverting files..." -ForegroundColor Cyan
    foreach ($item in $corrupted) {
        Write-Host "  Reverting: $($item.File)"
        & git checkout HEAD -- $item.File
        if ($LASTEXITCODE -eq 0) {
            Write-Host "    ✓ Reverted" -ForegroundColor Green
        } else {
            Write-Host "    ✗ Failed" -ForegroundColor Red
        }
    }
    Write-Host ""
    Write-Host "Revert complete." -ForegroundColor Green
} else {
    Write-Host "Files to revert:"
    foreach ($item in $corrupted) {
        Write-Host "  - $($item.File)"
    }
    Write-Host ""
    Write-Host "To actually revert these files, run:" -ForegroundColor Cyan
    Write-Host "  .\find_and_fix_corrupted.ps1 -Threshold $Threshold -Run"
}

exit $corrupted.Count
