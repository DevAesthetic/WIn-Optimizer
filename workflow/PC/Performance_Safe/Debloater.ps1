# Debloater Script
# Removes pre-installed bloatware apps
Write-Host "[DEBLOATER] - Removing bloatware..."
$bloatApps = @(
    'Microsoft.ZuneMusic',
    'Microsoft.ZuneVideo',
    'Microsoft.BingWeather',
    'Microsoft.GetHelp',
    'Microsoft.Getstarted',
    'Microsoft.Microsoft3DViewer',
    'Microsoft.MicrosoftOfficeHub',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.MicrosoftStickyNotes',
    'Microsoft.MixedReality.Portal',
    'Microsoft.OneConnect',
    'Microsoft.People',
    'Microsoft.Print3D',
    'Microsoft.SkypeApp',
    'Microsoft.Wallet',
    'Microsoft.WindowsAlarms',
    'Microsoft.WindowsFeedbackHub',
    'Microsoft.WindowsMaps',
    'Microsoft.WindowsSoundRecorder',
    'Microsoft.Xbox.TCUI',
    'Microsoft.XboxApp',
    'Microsoft.XboxGameOverlay',
    'Microsoft.XboxGamingOverlay',
    'Microsoft.XboxIdentityProvider',
    'Microsoft.XboxSpeechToTextOverlay',
    'Microsoft.YourPhone',
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
