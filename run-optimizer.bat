@echo off
:: Batch file to launch the Windows Optimizer PowerShell UI
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "Optimizer-UI.ps1"
