# Power Usage Script (Laptop)
Write-Host "[POWER-USAGE] - Setting power plan to High Performance (Laptop)..."
$highPerf = powercfg -l | Select-String -Pattern "High performance" | ForEach-Object { $_.ToString().Split()[3] }
powercfg -setactive $highPerf
Write-Host "Power plan set to High Performance."
