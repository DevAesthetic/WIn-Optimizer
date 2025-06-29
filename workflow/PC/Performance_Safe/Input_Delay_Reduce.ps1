# Input Delay Reduce Script
# Reduces input lag for better responsiveness
Write-Host "[INPUT-DELAY-REDUCE] - Reducing input delay..."
# Example: Set registry for low input lag
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile' -Name 'SystemResponsiveness' -Value 0 -Type DWord
Write-Host "Input delay reduced."
