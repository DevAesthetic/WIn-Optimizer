# Power Saver Script (Laptop - Long Life Battery)
Write-Host "[LONG LIFE BATTERY] - Setting power plan to Power Saver..."
$powerSaver = powercfg -l | Select-String -Pattern "Power saver" | ForEach-Object { $_.ToString().Split()[3] }
powercfg -setactive $powerSaver
Write-Host "Power plan set to Power Saver."
