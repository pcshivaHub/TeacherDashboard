@echo off
title Uninstall Teacher Dashboard
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Uninstall.ps1"
if errorlevel 1 (
  echo.
  echo  Uninstall did not complete. Press any key to close.
  pause >nul
)
