@echo off
setlocal
cd /d "%~dp0\.."

echo Translating localization JSON (en -> pt_br)...

set TRANSLATE_JSON=true

where py >nul 2>&1
if %errorlevel%==0 (
    py -3 tools/ss13_translator/translate_ss13.py
) else (
    python tools/ss13_translator/translate_ss13.py
)

if errorlevel 1 (
    echo.
    echo Translation failed.
    pause
    exit /b 1
)

echo.
echo Localization translated successfully.
pause
