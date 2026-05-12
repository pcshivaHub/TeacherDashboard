@echo off
:: Install Teacher Dashboard as a Windows Startup item
:: Double-click this file to install. No admin rights needed.

SET STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
SET SCRIPT_NAME=TeacherDashboard.vbs
SET SCRIPT_DIR=%~dp0

echo Installing Teacher Dashboard startup launcher...

IF NOT EXIST "%SCRIPT_DIR%%SCRIPT_NAME%" (
    echo ERROR: TeacherDashboard.vbs not found in the same folder as this installer.
    echo Please make sure TeacherDashboard.vbs and this .bat file are in the same folder.
    pause
    exit /b 1
)

COPY /Y "%SCRIPT_DIR%%SCRIPT_NAME%" "%STARTUP_FOLDER%\%SCRIPT_NAME%"

IF EXIST "%STARTUP_FOLDER%\%SCRIPT_NAME%" (
    echo.
    echo SUCCESS! Teacher Dashboard will now open in Chrome every time you log in.
    echo.
    echo Installed to: %STARTUP_FOLDER%\%SCRIPT_NAME%
    echo.
    echo To remove it later, delete that file or run Uninstall_TeacherDashboard_Startup.bat
) ELSE (
    echo.
    echo Something went wrong. Please try again.
)

pause
