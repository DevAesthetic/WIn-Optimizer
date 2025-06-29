# Debloater Script (Laptop - Long Life Battery)
Write-Host "[DEBLOATER] - Removing bloatware (Long Life Battery)..."
$bloatApps = @(
    'Microsoft.XboxApp',
    'Microsoft.XboxGameOverlay',
    'Microsoft.XboxGamingOverlay',
    'Microsoft.XboxIdentityProvider',
    'Microsoft.XboxSpeechToTextOverlay',
    'Microsoft.YourPhone',
    'Microsoft.MSPaint',
    'Microsoft.Office.OneNote'
)
foreach ($app in $bloatApps) {
    try {
        Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue
        Write-Host "$app removed."
    } catch {
        Write-Host "Could not remove $app: $_"
    }
}
Write-Host "Debloat complete."
