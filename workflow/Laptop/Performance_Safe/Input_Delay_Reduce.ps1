# Input Delay Reduce Script (Laptop)
Write-Host "[INPUT-DELAY-REDUCE] - Reducing input delay (Laptop)..."
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile' -Name 'SystemResponsiveness' -Value 0 -Type DWord
Write-Host "Input delay reduced."
