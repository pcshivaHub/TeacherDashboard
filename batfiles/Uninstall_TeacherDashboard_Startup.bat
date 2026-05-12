@echo off
:: Uninstall Teacher Dashboard startup launcher
SET STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
SET SCRIPT_NAME=TeacherDashboard.vbs

IF EXIST "%STARTUP_FOLDER%\%SCRIPT_NAME%" (
    DEL "%STARTUP_FOLDER%\%SCRIPT_NAME%"
    echo Teacher Dashboard startup launcher removed successfully.
) ELSE (
    echo Teacher Dashboard startup launcher was not found. Nothing to remove.
)
pause
