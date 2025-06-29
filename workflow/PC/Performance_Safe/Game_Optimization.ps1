# Game Optimization Script
# Sets registry and system tweaks for gaming
Write-Host "[GAME-OPTIMIZATION] - Applying game tweaks..."
# (Reuse registry tweaks for gaming, or add more here)
. "$PSScriptRoot\..\..\..\..\Optimizer.ps1"
Apply-RegistryTweaks
Write-Host "Game optimization complete."
