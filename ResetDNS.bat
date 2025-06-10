@echo off
title reset-DNS
chcp 65001 > nul
color 2

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ==========================================
    echo     ADMINISTRATOR PRIVILEGES REQUIRED  
    echo ==========================================
    echo.
    echo Please run this tool as "Run as Administrator"!
    pause
    exit /b 1
)

echo List of available network cards:
echo ==============================
netsh interface show interface
echo ==============================
echo.
echo Please enter the exact name of the network card you want the DNS to reset from the list above.
echo (Usually the name in question is in the "Interface Name" column)
echo.

set /p adapterName="Enter the name of the network card and press Enter: "

if "%adapterName%"=="" (
    echo.
    echo You didn't enter a name! Operation cancelled..
    goto :End
)

echo.
echo Resetting the DNS settings for the network card: "%adapterName%"
ipconfig/flushdns
netsh interface ip set dns name="%adapterName%" source=dhcp
netsh interface ip set wins name="%adapterName%" source=dhcp >nul 2>&1

echo.
echo DNS settings for the network card "%adapterName%" Reset to automatic mode (DHCP).
echo.

:End
echo Press a key to close this window...
pause > nul
exit