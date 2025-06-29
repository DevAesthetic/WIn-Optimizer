# Power Usage Script
# Sets power plan to high performance
Write-Host "[POWER-USAGE] - Setting power plan to High Performance..."
$highPerf = powercfg -l | Select-String -Pattern "High performance" | ForEach-Object { $_.ToString().Split()[3] }
powercfg -setactive $highPerf
Write-Host "Power plan set to High Performance."
