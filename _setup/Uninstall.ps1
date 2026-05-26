# ============================================================
#  Teacher Daily Dashboard  -  Uninstaller
#  Place this file in the install folder.
#  It removes shortcuts and then deletes the install folder.
# ============================================================
$ErrorActionPreference = 'SilentlyContinue'
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$installPath = $PSScriptRoot

$answer = [System.Windows.Forms.MessageBox]::Show(
    "This will completely remove Teacher Dashboard from your computer.`r`n`r`nInstall folder:`r`n   $installPath`r`n`r`nThe following will also be removed:`r`n   • Desktop shortcut (if present)`r`n   • Start Menu shortcuts (if present)`r`n   • Windows Startup shortcut (if present)`r`n`r`nYour saved tasks (dashboard.json) will be deleted.`r`nBack up that file first if you want to keep your task history.`r`n`r`nDo you want to continue?",
    "Uninstall Teacher Dashboard",
    [System.Windows.Forms.MessageBoxButtons]::YesNo,
    [System.Windows.Forms.MessageBoxIcon]::Warning)

if ($answer -ne [System.Windows.Forms.DialogResult]::Yes) { exit 0 }

# ---- Remove shortcuts ----
$desktop   = [Environment]::GetFolderPath('Desktop')
$programs  = [Environment]::GetFolderPath('Programs')
$startup   = [Environment]::GetFolderPath('Startup')

$desktopLnk  = Join-Path $desktop  'Teacher Dashboard.lnk'
$startMenuDir = Join-Path $programs 'Teacher Dashboard'
$startupLnk  = Join-Path $startup   'Teacher Dashboard.lnk'

if (Test-Path $desktopLnk)   { Remove-Item -Force $desktopLnk }
if (Test-Path $startMenuDir) { Remove-Item -Force -Recurse $startMenuDir }
if (Test-Path $startupLnk)   { Remove-Item -Force $startupLnk }

# ---- Remove install folder (scheduled, since this script lives inside it) ----
$escapedPath = $installPath -replace "'", "''"
$cmd = "Start-Sleep -Seconds 2; Remove-Item -Recurse -Force '$escapedPath'"
Start-Process powershell -ArgumentList "-NoProfile -WindowStyle Hidden -Command `"$cmd`"" -WindowStyle Hidden

[System.Windows.Forms.MessageBox]::Show(
    "Teacher Dashboard has been removed successfully.`r`n`r`nThe install folder will be deleted in a moment.",
    "Uninstall Complete",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null
