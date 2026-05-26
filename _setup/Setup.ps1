# ============================================================
#  Teacher Daily Dashboard  -  Setup Wizard  (multi-step)
#  Pages:  Welcome > Install Location > Options > Installing > Done
# ============================================================
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$here    = $PSScriptRoot
$payload = Join-Path $here 'payload'

if (-not (Test-Path (Join-Path $payload 'index.html'))) {
    [System.Windows.Forms.MessageBox]::Show(
        "Setup files are missing.`r`n`r`nPlease extract the zip completely before running Setup.bat.",
        "Teacher Dashboard - Setup", 'OK', 'Error') | Out-Null
    exit 1
}

# ============================================================
#  FORM
# ============================================================
$form = New-Object System.Windows.Forms.Form
$form.Text            = "Teacher Dashboard - Setup"
$form.Size            = New-Object System.Drawing.Size(570, 475)
$form.StartPosition   = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox     = $false
$form.MinimizeBox     = $false
$form.BackColor       = [System.Drawing.Color]::White
$form.Font            = New-Object System.Drawing.Font("Segoe UI", 10)

# ---- Header (purple strip) ----
$pnlHeader           = New-Object System.Windows.Forms.Panel
$pnlHeader.BackColor = [System.Drawing.Color]::FromArgb(79, 70, 229)
$pnlHeader.Location  = New-Object System.Drawing.Point(0, 0)
$pnlHeader.Size      = New-Object System.Drawing.Size(570, 80)
$form.Controls.Add($pnlHeader)

$lblApp           = New-Object System.Windows.Forms.Label
$lblApp.Text      = "Teacher Dashboard"
$lblApp.ForeColor = [System.Drawing.Color]::White
$lblApp.Font      = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$lblApp.Location  = New-Object System.Drawing.Point(22, 12)
$lblApp.Size      = New-Object System.Drawing.Size(450, 32)
$pnlHeader.Controls.Add($lblApp)

$lblStep           = New-Object System.Windows.Forms.Label
$lblStep.ForeColor = [System.Drawing.Color]::FromArgb(200, 200, 255)
$lblStep.Font      = New-Object System.Drawing.Font("Segoe UI", 9)
$lblStep.Location  = New-Object System.Drawing.Point(24, 50)
$lblStep.Size      = New-Object System.Drawing.Size(530, 20)
$pnlHeader.Controls.Add($lblStep)

# ---- Footer separator + buttons ----
$sepLine             = New-Object System.Windows.Forms.Label
$sepLine.BorderStyle = 'Fixed3D'
$sepLine.AutoSize    = $false
$sepLine.Location    = New-Object System.Drawing.Point(0, 390)
$sepLine.Size        = New-Object System.Drawing.Size(570, 2)
$form.Controls.Add($sepLine)

$btnBack          = New-Object System.Windows.Forms.Button
$btnBack.Text     = "Back"
$btnBack.Location = New-Object System.Drawing.Point(268, 402)
$btnBack.Size     = New-Object System.Drawing.Size(88, 32)
$btnBack.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($btnBack)

$btnNext           = New-Object System.Windows.Forms.Button
$btnNext.Text      = "Next"
$btnNext.Location  = New-Object System.Drawing.Point(364, 402)
$btnNext.Size      = New-Object System.Drawing.Size(95, 32)
$btnNext.Font      = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnNext.BackColor = [System.Drawing.Color]::FromArgb(79, 70, 229)
$btnNext.ForeColor = [System.Drawing.Color]::White
$btnNext.FlatStyle = 'Flat'
$form.AcceptButton = $btnNext
$form.Controls.Add($btnNext)

$btnCancel          = New-Object System.Windows.Forms.Button
$btnCancel.Text     = "Cancel"
$btnCancel.Location = New-Object System.Drawing.Point(467, 402)
$btnCancel.Size     = New-Object System.Drawing.Size(85, 32)
$btnCancel.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($btnCancel)

# ---- Helper: create a page panel ----
function New-Page {
    $p           = New-Object System.Windows.Forms.Panel
    $p.Location  = New-Object System.Drawing.Point(0, 82)
    $p.Size      = New-Object System.Drawing.Size(570, 306)
    $p.BackColor = [System.Drawing.Color]::White
    $p.Visible   = $false
    $form.Controls.Add($p)
    return $p
}

# ============================================================
#  PAGE 1 - WELCOME
# ============================================================
$pg1 = New-Page

$l          = New-Object System.Windows.Forms.Label
$l.Text     = "Welcome"
$l.Font     = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$l.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 60)
$l.Location = New-Object System.Drawing.Point(24, 16)
$l.Size     = New-Object System.Drawing.Size(520, 32)
$pg1.Controls.Add($l)

$l          = New-Object System.Windows.Forms.Label
$l.Text     = "This wizard will install Teacher Dashboard on your computer." + [Environment]::NewLine + [Environment]::NewLine + "Teacher Dashboard is a private daily task planner that runs in your web browser - no accounts, no servers, and no internet required for day-to-day use."
$l.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$l.Location = New-Object System.Drawing.Point(24, 58)
$l.Size     = New-Object System.Drawing.Size(525, 80)
$pg1.Controls.Add($l)

$features = @(
    "  [+]  Add tasks organised by grade, subject, priority and board",
    "  [+]  Filter by Today, Upcoming, Overdue and Completed",
    "  [+]  Desktop and Start Menu shortcuts created automatically",
    "  [+]  Works fully offline - your data never leaves this PC",
    "  [+]  Light and dark theme with customisable settings"
)
$fy = 148
foreach ($f in $features) {
    $lf           = New-Object System.Windows.Forms.Label
    $lf.Text      = $f
    $lf.Font      = New-Object System.Drawing.Font("Segoe UI", 10)
    $lf.ForeColor = [System.Drawing.Color]::FromArgb(55, 55, 90)
    $lf.Location  = New-Object System.Drawing.Point(24, $fy)
    $lf.Size      = New-Object System.Drawing.Size(525, 24)
    $pg1.Controls.Add($lf)
    $fy += 26
}

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "Click  Next  to choose the install location."
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Italic)
$l.ForeColor = [System.Drawing.Color]::FromArgb(130, 130, 160)
$l.Location  = New-Object System.Drawing.Point(24, 282)
$l.Size      = New-Object System.Drawing.Size(525, 20)
$pg1.Controls.Add($l)

# ============================================================
#  PAGE 2 - INSTALL LOCATION
# ============================================================
$pg2 = New-Page

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "Install Location"
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$l.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 60)
$l.Location  = New-Object System.Drawing.Point(24, 16)
$l.Size      = New-Object System.Drawing.Size(525, 32)
$pg2.Controls.Add($l)

$l          = New-Object System.Windows.Forms.Label
$l.Text     = "Where would you like Teacher Dashboard to be installed?"
$l.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$l.Location = New-Object System.Drawing.Point(24, 58)
$l.Size     = New-Object System.Drawing.Size(525, 22)
$pg2.Controls.Add($l)

$txtPath          = New-Object System.Windows.Forms.TextBox
$txtPath.Text     = Join-Path $env:USERPROFILE "Documents\TeacherDashboard"
$txtPath.Location = New-Object System.Drawing.Point(24, 86)
$txtPath.Size     = New-Object System.Drawing.Size(400, 28)
$txtPath.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$pg2.Controls.Add($txtPath)

$btnBrowse          = New-Object System.Windows.Forms.Button
$btnBrowse.Text     = "Browse..."
$btnBrowse.Location = New-Object System.Drawing.Point(433, 85)
$btnBrowse.Size     = New-Object System.Drawing.Size(100, 30)
$btnBrowse.Font     = New-Object System.Drawing.Font("Segoe UI", 9)
$btnBrowse.Add_Click({
    $dlg              = New-Object System.Windows.Forms.FolderBrowserDialog
    $dlg.Description  = "Choose a parent folder. A TeacherDashboard subfolder will be created inside it."
    $dlg.SelectedPath = (Join-Path $env:USERPROFILE 'Documents')
    if ($dlg.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $txtPath.Text = Join-Path $dlg.SelectedPath 'TeacherDashboard'
    }
})
$pg2.Controls.Add($btnBrowse)

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "The folder will be created if it does not already exist."
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Italic)
$l.ForeColor = [System.Drawing.Color]::FromArgb(130, 130, 160)
$l.Location  = New-Object System.Drawing.Point(24, 120)
$l.Size      = New-Object System.Drawing.Size(525, 20)
$pg2.Controls.Add($l)

$infoBox             = New-Object System.Windows.Forms.Panel
$infoBox.Location    = New-Object System.Drawing.Point(24, 150)
$infoBox.Size        = New-Object System.Drawing.Size(525, 140)
$infoBox.BackColor   = [System.Drawing.Color]::FromArgb(245, 247, 255)
$infoBox.BorderStyle = 'FixedSingle'
$pg2.Controls.Add($infoBox)

$l          = New-Object System.Windows.Forms.Label
$l.Text     = "Files that will be installed:"
$l.Font     = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$l.Location = New-Object System.Drawing.Point(12, 10)
$l.Size     = New-Object System.Drawing.Size(500, 18)
$infoBox.Controls.Add($l)

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "  index.html           - the dashboard application" + [Environment]::NewLine + "  data\dashboard.json  - your saved tasks (starts empty)" + [Environment]::NewLine + "  README.md            - quick-start guide" + [Environment]::NewLine + "  INSTALL.txt          - tips for daily use" + [Environment]::NewLine + "  Uninstall.bat        - to remove the dashboard later"
$l.Font      = New-Object System.Drawing.Font("Consolas", 8.5)
$l.ForeColor = [System.Drawing.Color]::FromArgb(60, 60, 100)
$l.Location  = New-Object System.Drawing.Point(12, 32)
$l.Size      = New-Object System.Drawing.Size(508, 100)
$infoBox.Controls.Add($l)

# ============================================================
#  PAGE 3 - OPTIONS
# ============================================================
$pg3 = New-Page

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "Options"
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$l.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 60)
$l.Location  = New-Object System.Drawing.Point(24, 16)
$l.Size      = New-Object System.Drawing.Size(525, 32)
$pg3.Controls.Add($l)

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "SHORTCUTS"
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$l.ForeColor = [System.Drawing.Color]::FromArgb(110, 110, 160)
$l.Location  = New-Object System.Drawing.Point(24, 60)
$l.Size      = New-Object System.Drawing.Size(525, 18)
$pg3.Controls.Add($l)

$cbDesktop          = New-Object System.Windows.Forms.CheckBox
$cbDesktop.Text     = "Create a shortcut on the Desktop"
$cbDesktop.Checked  = $true
$cbDesktop.Location = New-Object System.Drawing.Point(24, 82)
$cbDesktop.Size     = New-Object System.Drawing.Size(525, 24)
$cbDesktop.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$pg3.Controls.Add($cbDesktop)

$cbStartMenu          = New-Object System.Windows.Forms.CheckBox
$cbStartMenu.Text     = "Add to the Start Menu  (also adds an Uninstall entry)"
$cbStartMenu.Checked  = $true
$cbStartMenu.Location = New-Object System.Drawing.Point(24, 110)
$cbStartMenu.Size     = New-Object System.Drawing.Size(525, 24)
$cbStartMenu.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$pg3.Controls.Add($cbStartMenu)

$div1             = New-Object System.Windows.Forms.Label
$div1.BorderStyle = 'Fixed3D'
$div1.AutoSize    = $false
$div1.Height      = 1
$div1.Location    = New-Object System.Drawing.Point(24, 144)
$div1.Size        = New-Object System.Drawing.Size(525, 1)
$pg3.Controls.Add($div1)

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "AT WINDOWS SIGN-IN"
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$l.ForeColor = [System.Drawing.Color]::FromArgb(110, 110, 160)
$l.Location  = New-Object System.Drawing.Point(24, 156)
$l.Size      = New-Object System.Drawing.Size(525, 18)
$pg3.Controls.Add($l)

$cbAutoStart          = New-Object System.Windows.Forms.CheckBox
$cbAutoStart.Text     = "Open the dashboard automatically each time Windows starts"
$cbAutoStart.Checked  = $false
$cbAutoStart.Location = New-Object System.Drawing.Point(24, 178)
$cbAutoStart.Size     = New-Object System.Drawing.Size(525, 24)
$cbAutoStart.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$pg3.Controls.Add($cbAutoStart)

$div2             = New-Object System.Windows.Forms.Label
$div2.BorderStyle = 'Fixed3D'
$div2.AutoSize    = $false
$div2.Height      = 1
$div2.Location    = New-Object System.Drawing.Point(24, 212)
$div2.Size        = New-Object System.Drawing.Size(525, 1)
$pg3.Controls.Add($div2)

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "AFTER INSTALL"
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$l.ForeColor = [System.Drawing.Color]::FromArgb(110, 110, 160)
$l.Location  = New-Object System.Drawing.Point(24, 224)
$l.Size      = New-Object System.Drawing.Size(525, 18)
$pg3.Controls.Add($l)

$cbLaunch          = New-Object System.Windows.Forms.CheckBox
$cbLaunch.Text     = "Open Teacher Dashboard in my browser when setup finishes"
$cbLaunch.Checked  = $true
$cbLaunch.Location = New-Object System.Drawing.Point(24, 246)
$cbLaunch.Size     = New-Object System.Drawing.Size(525, 24)
$cbLaunch.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$pg3.Controls.Add($cbLaunch)

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "Click  Install  to begin copying files."
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Italic)
$l.ForeColor = [System.Drawing.Color]::FromArgb(130, 130, 160)
$l.Location  = New-Object System.Drawing.Point(24, 282)
$l.Size      = New-Object System.Drawing.Size(525, 20)
$pg3.Controls.Add($l)

# ============================================================
#  PAGE 4 - INSTALLING
# ============================================================
$pg4 = New-Page

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "Installing..."
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$l.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 60)
$l.Location  = New-Object System.Drawing.Point(24, 16)
$l.Size      = New-Object System.Drawing.Size(525, 32)
$pg4.Controls.Add($l)

$lblStatus           = New-Object System.Windows.Forms.Label
$lblStatus.Text      = "Please wait..."
$lblStatus.Font      = New-Object System.Drawing.Font("Segoe UI", 10)
$lblStatus.ForeColor = [System.Drawing.Color]::FromArgb(70, 70, 120)
$lblStatus.Location  = New-Object System.Drawing.Point(24, 60)
$lblStatus.Size      = New-Object System.Drawing.Size(525, 24)
$pg4.Controls.Add($lblStatus)

$progBar          = New-Object System.Windows.Forms.ProgressBar
$progBar.Location = New-Object System.Drawing.Point(24, 90)
$progBar.Size     = New-Object System.Drawing.Size(525, 22)
$progBar.Minimum  = 0
$progBar.Maximum  = 100
$progBar.Value    = 0
$progBar.Style    = 'Continuous'
$pg4.Controls.Add($progBar)

$lblLog           = New-Object System.Windows.Forms.Label
$lblLog.Font      = New-Object System.Drawing.Font("Consolas", 8.5)
$lblLog.ForeColor = [System.Drawing.Color]::FromArgb(100, 100, 140)
$lblLog.Location  = New-Object System.Drawing.Point(24, 124)
$lblLog.Size      = New-Object System.Drawing.Size(525, 170)
$pg4.Controls.Add($lblLog)

# ============================================================
#  PAGE 5 - DONE
# ============================================================
$pg5 = New-Page

$lDoneIcon           = New-Object System.Windows.Forms.Label
$lDoneIcon.Text      = "OK"
$lDoneIcon.Font      = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$lDoneIcon.ForeColor = [System.Drawing.Color]::White
$lDoneIcon.BackColor = [System.Drawing.Color]::FromArgb(22, 163, 74)
$lDoneIcon.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$lDoneIcon.Location  = New-Object System.Drawing.Point(22, 16)
$lDoneIcon.Size      = New-Object System.Drawing.Size(60, 60)
$pg5.Controls.Add($lDoneIcon)

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "Installation complete!"
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$l.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 60)
$l.Location  = New-Object System.Drawing.Point(96, 28)
$l.Size      = New-Object System.Drawing.Size(450, 32)
$pg5.Controls.Add($l)

$lblDoneSummary           = New-Object System.Windows.Forms.Label
$lblDoneSummary.Font      = New-Object System.Drawing.Font("Segoe UI", 10)
$lblDoneSummary.ForeColor = [System.Drawing.Color]::FromArgb(55, 55, 90)
$lblDoneSummary.Location  = New-Object System.Drawing.Point(24, 96)
$lblDoneSummary.Size      = New-Object System.Drawing.Size(525, 120)
$pg5.Controls.Add($lblDoneSummary)

$l           = New-Object System.Windows.Forms.Label
$l.Text      = "Tip: Open Settings inside the dashboard to enter your name and customise grades, subjects and boards."
$l.Font      = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Italic)
$l.ForeColor = [System.Drawing.Color]::FromArgb(120, 120, 160)
$l.Location  = New-Object System.Drawing.Point(24, 228)
$l.Size      = New-Object System.Drawing.Size(525, 40)
$pg5.Controls.Add($l)

# ============================================================
#  NAVIGATION
# ============================================================
$pages = @($pg1, $pg2, $pg3, $pg4, $pg5)
$stepTitles = @(
    "Step 1 of 3  -  Welcome",
    "Step 2 of 3  -  Choose install location",
    "Step 3 of 3  -  Set your preferences",
    "Installing - please wait...",
    "Setup complete"
)
$script:page = 0

function Show-Page([int]$i) {
    $script:page = $i
    foreach ($p in $pages) { $p.Visible = $false }
    $pages[$i].Visible = $true
    $lblStep.Text = $stepTitles[$i]
    switch ($i) {
        0 { $btnBack.Enabled = $false; $btnNext.Text = "Next";    $btnNext.Enabled = $true;  $btnCancel.Enabled = $true  }
        1 { $btnBack.Enabled = $true;  $btnNext.Text = "Next";    $btnNext.Enabled = $true;  $btnCancel.Enabled = $true  }
        2 { $btnBack.Enabled = $true;  $btnNext.Text = "Install"; $btnNext.Enabled = $true;  $btnCancel.Enabled = $true  }
        3 { $btnBack.Enabled = $false; $btnNext.Enabled = $false; $btnCancel.Enabled = $false }
        4 { $btnBack.Enabled = $false; $btnNext.Text = "Finish";  $btnNext.Enabled = $true;  $btnCancel.Enabled = $false }
    }
}

# ============================================================
#  INSTALL
# ============================================================
function Start-Install {
    $installPath = $txtPath.Text.Trim()
    Show-Page 3
    $form.Refresh()

    $logLines = New-Object System.Collections.Generic.List[string]

    function Log([string]$msg, [int]$pct) {
        $lblStatus.Text = $msg
        $progBar.Value  = [Math]::Min($pct, 100)
        $logLines.Add($msg)
        $count = $logLines.Count
        $tail  = if ($count -gt 9) { $logLines.GetRange($count - 9, 9) } else { $logLines }
        $lblLog.Text = [string]::Join([Environment]::NewLine, $tail)
        $form.Refresh()
        Start-Sleep -Milliseconds 80
    }

    try {
        Log "Creating install folder..." 8
        New-Item -ItemType Directory -Force -Path (Join-Path $installPath 'data') | Out-Null

        Log "Copying  index.html..." 20
        Copy-Item -Force (Join-Path $payload 'index.html') (Join-Path $installPath 'index.html')

        Log "Copying  data\dashboard.json..." 34
        Copy-Item -Force (Join-Path $payload 'data\dashboard.json') (Join-Path $installPath 'data\dashboard.json')

        Log "Copying  README.md..." 46
        Copy-Item -Force (Join-Path $payload 'README.md') (Join-Path $installPath 'README.md')

        Log "Copying  INSTALL.txt..." 54
        Copy-Item -Force (Join-Path $payload 'INSTALL.txt') (Join-Path $installPath 'INSTALL.txt')

        Log "Copying  Uninstall.bat..." 62
        Copy-Item -Force (Join-Path $payload 'Uninstall.bat') (Join-Path $installPath 'Uninstall.bat')

        Log "Copying  Uninstall.ps1..." 68
        Copy-Item -Force (Join-Path $payload 'Uninstall.ps1') (Join-Path $installPath 'Uninstall.ps1')

        $target = Join-Path $installPath 'index.html'
        $wsh    = New-Object -ComObject WScript.Shell

        function New-Shortcut([string]$lnk, [string]$tgt, [string]$desc) {
            $s                  = $wsh.CreateShortcut($lnk)
            $s.TargetPath       = $tgt
            $s.WorkingDirectory = (Split-Path $tgt -Parent)
            $s.Description      = $desc
            $s.Save()
        }

        $made = @()

        if ($cbDesktop.Checked) {
            Log "Creating Desktop shortcut..." 76
            New-Shortcut (Join-Path ([Environment]::GetFolderPath('Desktop')) 'Teacher Dashboard.lnk') $target 'Teacher Daily Dashboard'
            $made += "Desktop"
        }

        if ($cbStartMenu.Checked) {
            Log "Creating Start Menu shortcuts..." 83
            $smDir = Join-Path ([Environment]::GetFolderPath('Programs')) 'Teacher Dashboard'
            New-Item -ItemType Directory -Force -Path $smDir | Out-Null
            New-Shortcut (Join-Path $smDir 'Teacher Dashboard.lnk') $target 'Teacher Daily Dashboard'
            $uBat = Join-Path $installPath 'Uninstall.bat'
            $su                  = $wsh.CreateShortcut((Join-Path $smDir 'Uninstall Teacher Dashboard.lnk'))
            $su.TargetPath       = $uBat
            $su.WorkingDirectory = $installPath
            $su.Description      = 'Remove Teacher Dashboard'
            $su.Save()
            $made += "Start Menu"
        }

        if ($cbAutoStart.Checked) {
            Log "Adding to Windows Startup folder..." 90
            New-Shortcut (Join-Path ([Environment]::GetFolderPath('Startup')) 'Teacher Dashboard.lnk') $target 'Teacher Daily Dashboard (auto-start)'
            $made += "Windows Startup"
        }

        Log "Done!" 100

        $shortcutLine = if ($made.Count -gt 0) { "Shortcuts created:  " + ($made -join "  |  ") } else { "No shortcuts created." }
        $lblDoneSummary.Text = "Installed to:" + [Environment]::NewLine + "   $installPath" + [Environment]::NewLine + [Environment]::NewLine + $shortcutLine

        Show-Page 4

        if ($cbLaunch.Checked) { Start-Process $target }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show(
            "Installation failed:" + [Environment]::NewLine + [Environment]::NewLine + "$_",
            "Setup Error", 'OK', 'Error') | Out-Null
        $form.Close()
    }
}

# ============================================================
#  BUTTON HANDLERS
# ============================================================
$btnNext.Add_Click({
    switch ($script:page) {
        0 { Show-Page 1 }
        1 {
            if ([string]::IsNullOrWhiteSpace($txtPath.Text)) {
                [System.Windows.Forms.MessageBox]::Show("Please enter an install location.", "Setup", 'OK', 'Warning') | Out-Null
                return
            }
            Show-Page 2
        }
        2 { Start-Install }
        4 { $form.Close() }
    }
})

$btnBack.Add_Click({
    switch ($script:page) {
        1 { Show-Page 0 }
        2 { Show-Page 1 }
    }
})

$btnCancel.Add_Click({
    $r = [System.Windows.Forms.MessageBox]::Show(
        "Cancel setup and exit?",
        "Teacher Dashboard",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Question)
    if ($r -eq [System.Windows.Forms.DialogResult]::Yes) { $form.Close() }
})

# ---- Start ----
Show-Page 0
$form.ShowDialog() | Out-Null
