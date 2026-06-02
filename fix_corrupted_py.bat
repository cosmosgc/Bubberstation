@echo off
REM Batch wrapper for fix_corrupted.py
REM Usage: fix_corrupted_py.bat [--threshold N] [--run]
REM Examples:
REM   fix_corrupted_py.bat
REM   fix_corrupted_py.bat --threshold 50
REM   fix_corrupted_py.bat --threshold 100 --run

pushd "%~dp0"
python "%~dp0fix_corrupted.py" %*
set "EXITCODE=%ERRORLEVEL%"
popd
exit /b %EXITCODE%
