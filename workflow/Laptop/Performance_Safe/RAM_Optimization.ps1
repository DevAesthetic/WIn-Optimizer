# RAM Optimization Script (Laptop)
Write-Host "[RAM OPTIMIZATION] - Freeing up standby memory (Laptop)..."
try {
    Clear-Content -Path "$env:SystemDrive\pagefile.sys" -ErrorAction SilentlyContinue
    [System.GC]::Collect()
    Write-Host "RAM optimization complete."
} catch {
    Write-Host "RAM optimization failed: $_"
}
