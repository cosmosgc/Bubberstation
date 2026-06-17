@echo off
title Bubberstation Server (Dev Mode - Auto Restart)

setlocal enabledelayedexpansion

:: Find DreamDaemon
set "DD_EXE="

if exist "C:\Program Files\BYOND\bin\dreamdaemon.exe" set "DD_EXE=C:\Program Files\BYOND\bin\dreamdaemon.exe"
if exist "C:\Program Files (x86)\BYOND\bin\dreamdaemon.exe" set "DD_EXE=C:\Program Files (x86)\BYOND\bin\dreamdaemon.exe"

if not defined DD_EXE (
    for /f "skip=1 tokens=3*" %%a in ('reg query "HKLM\Software\Dantom\BYOND" /v installpath 2^>nul') do (
        if "%%b"=="" (if exist "%%a\bin\dreamdaemon.exe" set "DD_EXE=%%a\bin\dreamdaemon.exe") else (if exist "%%a %%b\bin\dreamdaemon.exe" set "DD_EXE=%%a %%b\bin\dreamdaemon.exe")
    )
)

if not defined DD_EXE (
    for /f "skip=1 tokens=3*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\Dantom\BYOND" /v installpath 2^>nul') do (
        if "%%b"=="" (if exist "%%a\bin\dreamdaemon.exe" set "DD_EXE=%%a\bin\dreamdaemon.exe") else (if exist "%%a %%b\bin\dreamdaemon.exe" set "DD_EXE=%%a %%b\bin\dreamdaemon.exe")
    )
)

if not defined DD_EXE (
    if defined DM_EXE (
        for %%a in ("%DM_EXE%") do set "DD_BIN=%%~dpa"
        if exist "!DD_BIN!dreamdaemon.exe" set "DD_EXE=!DD_BIN!dreamdaemon.exe"
    )
)

if not defined DD_EXE (
    echo Error: Could not find dreamdaemon.exe.
    echo Make sure BYOND is installed, or set DM_EXE to the path of dm.exe.
    pause
    exit /b 1
)

echo Found DreamDaemon: %DD_EXE%
echo.
echo Skipping build - using existing tgstation.dmb
echo Server will auto-restart if it crashes.
echo Close this window to stop (DreamDaemon will close with it).
echo.

:: Launch via .NET Process (keeps DD in same job object, captures stdout without stealing it from DD window)
:: Closing this window kills both processes together
powershell -NoProfile -ExecutionPolicy Bypass -Command "& { $dd='%DD_EXE%'; $dmb='%~dp0tgstation.dmb'; $log='%~dp0data\server_output.log'; while ($true) { if (Test-Path $log) { Remove-Item $log -Force }; Write-Host ('[{0}] Starting server...' -f (Get-Date)); $psi = New-Object System.Diagnostics.ProcessStartInfo; $psi.FileName = $dd; $psi.Arguments = '"""' + $dmb + '""" 1337 -trusted -close -verbose'; $psi.UseShellExecute = $false; $psi.RedirectStandardOutput = $true; $psi.RedirectStandardError = $true; $proc = [System.Diagnostics.Process]::Start($psi); $out = $proc.StandardOutput.ReadToEnd(); $err = $proc.StandardError.ReadToEnd(); $proc.WaitForExit(); ($out + $err) | Out-File -FilePath $log -Encoding UTF8; Write-Host ('[{0}] Server stopped.' -f (Get-Date)); if (Test-Path $log) { Write-Host '=== Last run output ==='; Get-Content $log | Write-Host; Write-Host '=== End of log ===' }; Write-Host 'Restarting in 5 seconds...'; Start-Sleep -Seconds 5 } }"

pause
