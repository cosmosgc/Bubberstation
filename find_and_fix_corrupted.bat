@echo off
REM Find and revert corrupted files using git diff approach
REM Usage: find_and_fix_corrupted.bat [threshold] [run]
REM Examples:
REM   find_and_fix_corrupted.bat         (default: threshold 100, dry run)
REM   find_and_fix_corrupted.bat 50      (threshold 50, dry run)
REM   find_and_fix_corrupted.bat 100 run (threshold 100, actually revert)

setlocal enabledelayedexpansion

set "threshold=%~1"
if "%threshold%"=="" set "threshold=100"

set "action=%~2"

echo Searching for corrupted files with threshold: %threshold%+
echo Mode: %action%
echo.

REM Create temporary file for results
set "scratch=%TEMP%\corrupted_files.txt"

REM Use PowerShell to run git diff and filter results
powershell -NoProfile -Command "^
  $diff = git diff --stat HEAD -- '*.dm' '*.tsx' '*.ts'; ^
  $corrupted = @(); ^
  foreach ($line in $diff -split [Environment]::NewLine) { ^
    if ($line -match '(.+?)\s+\|\s+(\d+)\s+(.+)') { ^
      $additions = ($matches[3] -replace '[^+]','').length; ^
      $deletions = ($matches[3] -replace '[^-]','').length; ^
      if ($additions -ge $threshold -and $deletions -ge $threshold) { ^
        $corrupted += @{ file = $matches[1]; add = $additions; del = $deletions }; ^
        Write-Host ('SUSPICIOUS: ' + $matches[1]); ^
        Write-Host ('  Additions: ' + $additions + ', Deletions: ' + $deletions); ^
      }; ^
    }; ^
  }; ^
  if ($corrupted.Count -eq 0) { ^
    Write-Host 'No suspicious files found.'; ^
    exit 0; ^
  }; ^
  Write-Host ''; ^
  Write-Host ('Found ' + $corrupted.Count + ' suspicious file(s)'); ^
  Write-Host ''; ^
  foreach ($item in $corrupted) { ^
    $item.file | Out-File -Append -FilePath '%scratch%' -Encoding UTF8; ^
  }; ^
  exit $corrupted.Count ^
"

set "exit_code=%ERRORLEVEL%"

if %exit_code% equ 0 (
    echo.
    echo All files are clean.
    goto cleanup
)

REM Show what would be reverted
echo Files to revert:
for /f "usebackq delims=" %%F in ("%scratch%") do (
    echo   %%F
)

if /i "%action%"=="run" (
    echo.
    echo Reverting files...
    for /f "usebackq delims=" %%F in ("%scratch%") do (
        echo Reverting: %%F
        git checkout HEAD -- "%%F"
    )
    echo Revert complete.
) else (
    echo.
    echo To actually revert, run: %0 %threshold% run
)

:cleanup
if exist "%scratch%" del "%scratch%"
exit /b %exit_code%
