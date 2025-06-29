# Services Disable Script
# Disables unnecessary Windows services for performance
Write-Host "[SERVICES-DISABLE] - Disabling unnecessary services..."
$services = @(
    'SysMain',
    'DiagTrack',
    'WSearch',
    'Fax',
    'XblGameSave',
    'MapsBroker',
    'WMPNetworkSvc'
)
foreach ($svc in $services) {
    try {
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled
        Write-Host "$svc disabled."
    } catch {
        Write-Host "Could not disable $svc: $_"
    }
}
Write-Host "Service optimization complete."
