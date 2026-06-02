#!/usr/bin/env pwsh
# Debug script to test git diff parsing

Write-Host "Testing git diff capture..."
Write-Host ""

$lines = git diff --stat -- '*.dm' 2>&1 | Where-Object {$_ -match '\|'}

Write-Host "Captured $($lines.Count) lines with pipes"
Write-Host ""

$lines | Select-Object -First 5 | ForEach-Object {
    Write-Host "Line: $_"

    if ($_ -match '(.+?)\s+\|\s+\d+\s+(.+)$') {
        $filepath = $matches[1].Trim()
        $changes = $matches[2].Trim()

        Write-Host "  File: $filepath"
        Write-Host "  Changes: $changes"

        $adds = ($changes -replace '[^+]', '').Length
        $dels = ($changes -replace '[^-]', '').Length

        Write-Host "  Adds: $adds, Dels: $dels"
    }
    Write-Host ""
}
