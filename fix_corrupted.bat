@echo off
REM Batch wrapper for fix_corrupted.ps1
REM Usage: fix_corrupted.bat [threshold] [run]
REM Examples:
REM   fix_corrupted.bat                 (dry run, threshold 100)
REM   fix_corrupted.bat 50              (dry run, threshold 50)
REM   fix_corrupted.bat 100 run         (revert files, threshold 100)

setlocal enabledelayedexpansion

set "THRESHOLD=%~1"
set "MODE=%~2"

if "%THRESHOLD%"=="" (
    set "THRESHOLD=100"
)

if /i "%MODE%"=="run" (
    powershell -NoProfile -ExecutionPolicy Bypass -File ".\fix_corrupted.ps1" -Threshold %THRESHOLD% -Run
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -File ".\fix_corrupted.ps1" -Threshold %THRESHOLD%
)

pause
