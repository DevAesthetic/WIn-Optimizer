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
 ____   ____   _____   ___   _   _   ___   ____   ___   ____ 
/ __ \ )  _)\ )__ __( )_ _( ) \_/ ( )_ _( )___ ( ) __( /  _ \
))__(( | '__/   | |   _| |_ |  _  | _| |_   / /_ | _)  )  ' /
\____/ )_(      )_(  )_____()_( )_()_____( )____()___( |_()_\
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

while ($true) {
    Run-Optimizer
    if ((Read-Host "Run another optimization? (y/n)") -ne 'y') { break }
}
