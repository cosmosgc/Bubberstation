@echo off
setlocal
cd /d "%~dp0\.."

echo Building localization template from DM source...

where py >nul 2>&1
if %errorlevel%==0 (
    py -3 tools/ss13_translator/build_items_template.py
) else (
    python tools/ss13_translator/build_items_template.py
)

if errorlevel 1 (
    echo.
    echo Failed to build localization template.
    pause
    exit /b 1
)

echo.
echo Localization template built successfully.
echo.
echo Next step: run bin\translate_localization.cmd to translate en -^> pt_br
pause
