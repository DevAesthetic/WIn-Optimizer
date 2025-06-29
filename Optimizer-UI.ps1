# Windows Optimizer UI Menu
# Select your device and optimization type, then choose an action.

function Show-Description($desc) {
    Write-Host "[INFO] $desc" -ForegroundColor Cyan
}

function Show-Result($result) {
    Write-Host "[RESULT] $result" -ForegroundColor Green
}

function Show-AsciiArt {
    $art = @'
  ____        _   _                 _             
 / __ \      | | (_)               | |            
| |  | |_   _| |_ _  ___  _ __  ___| |_ ___  _ __ 
| |  | | | | | __| |/ _ \| '_ \/ __| __/ _ \| '__|
| |__| | |_| | |_| | (_) | | | \__ \ || (_) | |   
 \___\_\\__,_|\__|_|\___/|_| |_|___/\__\___/|_|   
'@
    Write-Host $art -ForegroundColor Yellow
}

function Show-MenuHeader {
    Write-Host "=====================================" -ForegroundColor DarkCyan
    Write-Host "         WINDOWS OPTIMIZER           " -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor DarkCyan
}

function Run-Optimizer {
    Clear-Host
    Show-AsciiArt
    Show-MenuHeader
    Write-Host "Select Device:" -ForegroundColor Magenta
    Write-Host "  1) PC" -ForegroundColor Green
    Write-Host "  2) Laptop" -ForegroundColor Green
    $device = Read-Host "Enter option (1-2)"
    Write-Host "\nSelect Mode:" -ForegroundColor Magenta
    Write-Host "  1) Performance (Safe)" -ForegroundColor Yellow
    Write-Host "  2) Performance (Own Risk)" -ForegroundColor Red
    if ($device -eq '2') {
        Write-Host "  3) Long Life Battery" -ForegroundColor Blue
    }
    $mode = Read-Host "Enter option (1-3)"
    $actions = @(
        @{Name='RAM Optimization'; Script='RAM_Optimization.ps1'; Desc='Frees up standby memory and optimizes RAM usage.'},
        @{Name='Registry Tweaks'; Script='Reg_Tweak.ps1'; Desc='Applies registry tweaks for performance.'},
        @{Name='Services Disable'; Script='Services_Disable.ps1'; Desc='Disables unnecessary Windows services.'},
        @{Name='Debloater'; Script='Debloater.ps1'; Desc='Removes pre-installed bloatware apps.'},
        @{Name='Space-Up'; Script='Space_Up.ps1'; Desc='Cleans temp and cache files.'},
        @{Name='Game Optimization'; Script='Game_Optimization.ps1'; Desc='Applies system tweaks for gaming.'},
        @{Name='Input Delay Reduce'; Script='Input_Delay_Reduce.ps1'; Desc='Reduces input lag for better responsiveness.'},
        @{Name='Power Usage'; Script='Power_Usage.ps1'; Desc='Sets power plan to high performance.'}
    )
    if ($device -eq '2' -and $mode -eq '3') {
        $actions = @(
            @{Name='Power Saver'; Script='Power_Saver.ps1'; Desc='Sets power plan to Power Saver for battery life.'},
            @{Name='Debloater'; Script='Debloater.ps1'; Desc='Removes bloatware for battery life.'},
            @{Name='Space-Up'; Script='Space_Up.ps1'; Desc='Cleans temp/cache for battery life.'}
        )
    }
    # User-friendly, clean menu
    Write-Host "\n==== Select Action ====" -ForegroundColor Magenta
    for ($i=0; $i -lt $actions.Count; $i++) {
        $color = switch ($actions[$i].Name) {
            {$_ -match 'Debloater|Space-Up'} { 'Cyan' }
            {$_ -match 'Power Usage|Power Saver|Battery'} { 'Blue' }
            {$_ -match 'Game Optimization|Input Delay'} { 'Yellow' }
            default { 'Green' }
        }
        Write-Host ("  [$($i+1)] $($actions[$i].Name)".PadRight(30) + "- $($actions[$i].Desc)") -ForegroundColor $color
    }
    Write-Host ("\n==== Apply All Optimizations ====") -ForegroundColor Magenta
    Write-Host ("  [$($actions.Count+1)] Apply Full Ultimate Performance") -ForegroundColor Yellow
    Write-Host ("  [$($actions.Count+2)] Apply Full High Performance") -ForegroundColor Green
    $choice = Read-Host "\nEnter your choice (1-$($actions.Count+2))"
    if ($choice -eq ($actions.Count+1).ToString()) {
        Write-Host "\n[Ultimate Performance] Applying all optimizations..." -ForegroundColor DarkYellow
        $powercfgList = powercfg -l | ForEach-Object { $_.Trim() }
        $ultimateGuid = $null
        foreach ($line in $powercfgList) {
            if ($line -match '([A-F0-9\-]{36})' -and $line -match 'Ultimate Performance') {
                $ultimateGuid = $matches[1]
                break
            }
        }
        if (-not $ultimateGuid) {
            Write-Host "Ultimate Performance plan not found. Creating it..." -ForegroundColor Yellow
            powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
            $powercfgList = powercfg -l | ForEach-Object { $_.Trim() }
            foreach ($line in $powercfgList) {
                if ($line -match '([A-F0-9\-]{36})' -and $line -match 'Ultimate Performance') {
                    $ultimateGuid = $matches[1]
                    break
                }
            }
        }
        if ($ultimateGuid) {
            Write-Host "Setting power plan: Ultimate Performance" -ForegroundColor Yellow
            powercfg -setactive $ultimateGuid
        } else {
            Write-Host "Failed to create Ultimate Performance plan." -ForegroundColor Red
        }
        foreach ($action in $actions) {
            Write-Host ("Executing: {0}" -f $action.Name) -ForegroundColor Cyan
            $scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "workflow\$base\$perf\$($action.Script)"
            if (Test-Path $scriptPath) {
                $output = & $scriptPath
                Show-Result $output
            }
        }
    } elseif ($choice -eq ($actions.Count+2).ToString()) {
        Write-Host "\n[High Performance] Applying all optimizations..." -ForegroundColor DarkYellow
        $powercfgList = powercfg -l | ForEach-Object { $_.Trim() }
        $highGuid = $null
        foreach ($line in $powercfgList) {
            if ($line -match '([A-F0-9\-]{36})' -and $line -match 'High performance') {
                $highGuid = $matches[1]
                break
            }
        }
        if (-not $highGuid) {
            Write-Host "High Performance plan not found. Creating it..." -ForegroundColor Green
            powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c | Out-Null
            $powercfgList = powercfg -l | ForEach-Object { $_.Trim() }
            foreach ($line in $powercfgList) {
                if ($line -match '([A-F0-9\-]{36})' -and $line -match 'High performance') {
                    $highGuid = $matches[1]
                    break
                }
            }
        }
        if ($highGuid) {
            Write-Host "Setting power plan: High Performance" -ForegroundColor Green
            powercfg -setactive $highGuid
        } else {
            Write-Host "Failed to create High Performance plan." -ForegroundColor Red
        }
        foreach ($action in $actions) {
            Write-Host ("Executing: {0}" -f $action.Name) -ForegroundColor Cyan
            $scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "workflow\$base\$perf\$($action.Script)"
            if (Test-Path $scriptPath) {
                $output = & $scriptPath
                Show-Result $output
            }
        }
    } elseif ($choice -eq '8') {
        # Power Usage - Manage Power Plans
        Write-Host "\n==== Power Plans ==== " -ForegroundColor Magenta
        $powerOptions = @(
            @{Name='Ultimate Performance'; Guid=''; Color='Yellow'},
            @{Name='Balanced'; Guid=''; Color='Gray'},
            @{Name='High performance'; Guid='Green'; Color='Green'},
            @{Name='Power saver'; Guid=''; Color='Blue'}
        )
        $powercfgList = powercfg -l | ForEach-Object { $_.Trim() }
        foreach ($line in $powercfgList) {
            if ($line -match '([A-F0-9\-]{36})') {
                $guid = $matches[1]
                $name = ($line -split '\s{2,}',2)[1] -replace '\s*\*?\s*$', ''
                if ($name -match 'Ultimate Performance') { $powerOptions[0].Guid = $guid }
                elseif ($name -match 'Balanced') { $powerOptions[1].Guid = $guid }
                elseif ($name -match 'High performance') { $powerOptions[2].Guid = $guid }
                elseif ($name -match 'Power saver') { $powerOptions[3].Guid = $guid }
            }
        }
        # Create missing plans if needed
        if (-not $powerOptions[0].Guid) {
            Write-Host "Ultimate Performance plan not found. Creating it..." -ForegroundColor Yellow
            powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
            $powercfgList = powercfg -l | ForEach-Object { $_.Trim() }
            foreach ($line in $powercfgList) {
                if ($line -match '([A-F0-9\-]{36})' -and $line -match 'Ultimate Performance') {
                    $powerOptions[0].Guid = $matches[1]
                    break
                }
            }
        }
        if (-not $powerOptions[2].Guid) {
            Write-Host "High Performance plan not found. Creating it..." -ForegroundColor Green
            powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c | Out-Null
            $powercfgList = powercfg -l | ForEach-Object { $_.Trim() }
            foreach ($line in $powercfgList) {
                if ($line -match '([A-F0-9\-]{36})' -and $line -match 'High performance') {
                    $powerOptions[2].Guid = $matches[1]
                    break
                }
            }
        }
        for ($i=0; $i -lt $powerOptions.Count; $i++) {
            Write-Host ("  [$($i+1)] $($powerOptions[$i].Name)") -ForegroundColor $powerOptions[$i].Color
        }
        $ppChoice = Read-Host "\nSelect a power plan to apply (1-4)"
        if ($ppChoice -in 1..4) {
            $selectedPlan = $powerOptions[$ppChoice-1]
            if ($selectedPlan.Guid -ne '') {
                Write-Host ("\nSetting power plan: {0}" -f $selectedPlan.Name) -ForegroundColor DarkYellow
                powercfg -setactive $selectedPlan.Guid
                Show-Result "Power plan set to $($selectedPlan.Name)"
            } else {
                Write-Host "\nThis power plan is not available on your system." -ForegroundColor Red
            }
        }
    } else {
        $selected = $actions[$choice-1]
        Show-Description $selected.Desc
        Write-Host ("\n[Executing] $($selected.Name)...") -ForegroundColor Cyan
        $base = if ($device -eq '1') { 'PC' } else { 'Laptop' }
        $perf = if ($mode -eq '1') { 'Performance_Safe' } elseif ($mode -eq '2') { 'Performance_Own_Risk' } else { 'Long_Life_Battery' }
        $scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "workflow\$base\$perf\$($selected.Script)"
        if (Test-Path $scriptPath) {
            $output = & $scriptPath
            Show-Result $output
        } else {
            Write-Host "Script not found: $scriptPath" -ForegroundColor Red
        }
    }
}

# EXE UI Mode: Use Windows Forms for a native GUI if running as EXE
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Show-ExeUI {
    $form = New-Object Windows.Forms.Form
    $form.Text = "Windows Optimizer Suite"
    $form.Size = New-Object Drawing.Size(500, 600)
    $form.StartPosition = "CenterScreen"
    $form.BackColor = [Drawing.Color]::FromArgb(30,30,30)

    $label = New-Object Windows.Forms.Label
    $label.Text = "Select Optimization Mode:"
    $label.ForeColor = 'Cyan'
    $label.Font = New-Object Drawing.Font('Segoe UI', 12, [Drawing.FontStyle]::Bold)
    $label.Location = New-Object Drawing.Point(20, 20)
    $label.AutoSize = $true
    $form.Controls.Add($label)

    $combo = New-Object Windows.Forms.ComboBox
    $combo.Items.AddRange(@('PC - Performance (Safe)', 'PC - Performance (Own Risk)', 'Laptop - Performance (Safe)', 'Laptop - Performance (Own Risk)', 'Laptop - Long Life Battery'))
    $combo.Location = New-Object Drawing.Point(20, 60)
    $combo.Size = New-Object Drawing.Size(440, 30)
    $combo.DropDownStyle = 'DropDownList'
    $form.Controls.Add($combo)

    $list = New-Object Windows.Forms.ListBox
    $list.Location = New-Object Drawing.Point(20, 110)
    $list.Size = New-Object Drawing.Size(440, 250)
    $list.Font = New-Object Drawing.Font('Consolas', 10)
    $form.Controls.Add($list)

    $actions = @(
        'RAM Optimization',
        'Registry Tweaks',
        'Services Disable',
        'Debloater',
        'Space-Up',
        'Game Optimization',
        'Input Delay Reduce',
        'Power Usage - Manage Power Plans',
        'Apply Full Ultimate Performance',
        'Apply Full High Performance'
    )
    $list.Items.AddRange($actions)

    $runBtn = New-Object Windows.Forms.Button
    $runBtn.Text = "Run Selected Optimization"
    $runBtn.Location = New-Object Drawing.Point(20, 380)
    $runBtn.Size = New-Object Drawing.Size(440, 40)
    $runBtn.BackColor = [Drawing.Color]::FromArgb(0,120,215)
    $runBtn.ForeColor = 'White'
    $runBtn.Font = New-Object Drawing.Font('Segoe UI', 11, [Drawing.FontStyle]::Bold)
    $form.Controls.Add($runBtn)

    $output = New-Object Windows.Forms.TextBox
    $output.Location = New-Object Drawing.Point(20, 440)
    $output.Size = New-Object Drawing.Size(440, 100)
    $output.Multiline = $true
    $output.ScrollBars = 'Vertical'
    $output.ReadOnly = $true
    $output.BackColor = [Drawing.Color]::FromArgb(20,20,20)
    $output.ForeColor = 'Lime'
    $form.Controls.Add($output)

    $runBtn.Add_Click({
        $mode = $combo.SelectedIndex
        $action = $list.SelectedIndex
        if ($mode -lt 0 -or $action -lt 0) {
            $output.Text = "Please select a mode and an action."
            return
        }
        $base = if ($mode -in 0,1) { 'PC' } else { 'Laptop' }
        $perf = switch ($mode) {
            0 { 'Performance_Safe' }
            1 { 'Performance_Own_Risk' }
            2 { 'Performance_Safe' }
            3 { 'Performance_Own_Risk' }
            4 { 'Long_Life_Battery' }
        }
        $script = switch ($action) {
            0 { 'RAM_Optimization.ps1' }
            1 { 'Reg_Tweak.ps1' }
            2 { 'Services_Disable.ps1' }
            3 { 'Debloater.ps1' }
            4 { 'Space_Up.ps1' }
            5 { 'Game_Optimization.ps1' }
            6 { 'Input_Delay_Reduce.ps1' }
            7 { 'Power_Usage.ps1' }
            8 { 'ApplyAllUltimate' }
            9 { 'ApplyAllHigh' }
        }
        if ($action -in 8,9) {
            $output.Text = "Running full optimization..."
            $exe = $MyInvocation.MyCommand.Definition
            Start-Process powershell -Verb runAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$exe`" -fullopt $action -mode $mode"
            $form.Close()
            return
        }
        $scriptPath = Join-Path $PSScriptRoot "workflow\$base\$perf\$script"
        if (Test-Path $scriptPath) {
            $output.Text = "Running $($actions[$action])..."
            $result = powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath
            $output.Text += "`r`n$result"
        } else {
            $output.Text = "Script not found: $scriptPath"
        }
    })
    $form.ShowDialog()
}

# Detect if running as EXE
if ($MyInvocation.MyCommand.Path -like '*.exe') {
    Show-ExeUI
    exit
}

while ($true) {
    Run-Optimizer
    if ((Read-Host "Run another optimization? (y/n)") -ne 'y') { break }
}
