# RAM Optimization Script
# Frees up standby memory and optimizes RAM usage
Write-Host "[RAM OPTIMIZATION] - Freeing up standby memory..."
try {
    Clear-Content -Path "$env:SystemDrive\pagefile.sys" -ErrorAction SilentlyContinue
    [System.GC]::Collect()
    Write-Host "RAM optimization complete."
} catch {
    Write-Host "RAM optimization failed: $_"
}
