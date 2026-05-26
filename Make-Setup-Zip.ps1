# =====================================================
#  Builds  TeacherDashboard-Setup.zip
#
#  Layout produced inside the zip:
#
#  TeacherDashboard-Setup/
#    +- Setup.bat                <- user double-clicks this
#    +- Setup.ps1                <- multi-step GUI wizard
#    +- README.txt               <- "how to install" for end users
#    +- payload/                 <- files copied onto the target PC
#       +- index.html
#       +- data/
#       |   +- dashboard.json    <- empty, ready for a fresh start
#       +- README.md
#       +- INSTALL.txt
#       +- Uninstall.bat         <- uninstaller launcher
#       +- Uninstall.ps1         <- uninstaller wizard
#
#  Run this by double-clicking  Make-Setup-Zip.bat
# =====================================================
$ErrorActionPreference = 'Stop'

$root    = $PSScriptRoot
$setup   = Join-Path $root '_setup'
$stage   = Join-Path $env:TEMP ('TDsetup_' + [guid]::NewGuid().ToString('N'))
$top     = Join-Path $stage 'TeacherDashboard-Setup'
$payload = Join-Path $top   'payload'
$payData = Join-Path $payload 'data'
$out     = Join-Path $root 'TeacherDashboard-Setup.zip'

Write-Host ""
Write-Host " Building TeacherDashboard-Setup.zip ..." -ForegroundColor Cyan

# --- Create folder structure ---
New-Item -ItemType Directory -Force -Path $payData | Out-Null

# --- Installer pieces (run on the target PC to install) ---
Copy-Item (Join-Path $setup 'Setup.bat')   (Join-Path $top 'Setup.bat')
Copy-Item (Join-Path $setup 'Setup.ps1')   (Join-Path $top 'Setup.ps1')
Copy-Item (Join-Path $setup 'README.txt')  (Join-Path $top 'README.txt')

# --- Payload: what gets installed onto the target PC ---
Copy-Item (Join-Path $root  'index.html')          (Join-Path $payload 'index.html')
Copy-Item (Join-Path $root  'data\dashboard.json') (Join-Path $payData 'dashboard.json')
Copy-Item (Join-Path $setup 'README.md')           (Join-Path $payload 'README.md')
Copy-Item (Join-Path $setup 'INSTALL.txt')         (Join-Path $payload 'INSTALL.txt')
Copy-Item (Join-Path $setup 'Uninstall.bat')       (Join-Path $payload 'Uninstall.bat')
Copy-Item (Join-Path $setup 'Uninstall.ps1')       (Join-Path $payload 'Uninstall.ps1')

# --- Verify dashboard.json has no tasks (safety check) ---
$jsonText = Get-Content (Join-Path $payData 'dashboard.json') -Raw
$json     = $jsonText | ConvertFrom-Json
if ($json.tasks.Count -gt 0) {
    Write-Warning "dashboard.json still contains $($json.tasks.Count) task(s). Clearing tasks for clean setup..."
    $json.tasks    = @()
    $json.savedAt  = ""
    $json | ConvertTo-Json -Depth 10 | Set-Content (Join-Path $payData 'dashboard.json') -Encoding UTF8
}

# --- Zip it ---
if (Test-Path $out) { Remove-Item $out -Force }
Compress-Archive -Path $top -DestinationPath $out
Remove-Item -Recurse -Force $stage

Write-Host ""
Write-Host " SUCCESS - created:" -ForegroundColor Green
Write-Host "   $out"
Write-Host ""
Write-Host @'
 Zip contents:
   TeacherDashboard-Setup\
     Setup.bat          (user double-clicks to install)
     Setup.ps1          (multi-step GUI installer)
     README.txt         (instructions)
     payload\
       index.html
       data\dashboard.json   (empty - fresh start)
       README.md
       INSTALL.txt
       Uninstall.bat
       Uninstall.ps1

 Share that single .zip with anyone. They:
   1. Unzip it
   2. Open the TeacherDashboard-Setup folder
   3. Double-click  Setup.bat

'@
