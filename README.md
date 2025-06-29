# Windows Optimizer Suite

A user-friendly PowerShell-based toolkit for optimizing Windows PCs and laptops. Includes registry tweaks, RAM optimization, debloating, service management, power plan management, and more.

## Features
- Clean, interactive PowerShell UI
- Separate optimizations for PC and Laptop
- Game and battery life modes
- Automatic creation of missing power plans (Ultimate/High Performance)
- One-click 'Apply All' for full optimization

## How to Use

### 1. Run the Optimizer
- Right-click `Optimizer-UI.ps1` and select **Run with PowerShell** (recommended, requires admin rights for full effect)
- Or, double-click `run-optimizer.bat` to launch the optimizer in a PowerShell window

### 2. Follow the Menu
- Select your device (PC/Laptop)
- Choose the optimization mode (Performance, Battery, etc.)
- Pick an action or use 'Apply All' for full optimization
- For power plans, you can manage and apply them directly from the menu

### 3. Requirements
- Windows 10/11
- Run as Administrator for best results

## File Structure
- `Optimizer-UI.ps1` — Main interactive menu
- `workflow/` — Contains all optimization scripts, organized by device and mode
- `run-optimizer.bat` — Batch file to launch the optimizer easily

## Disclaimer
Use at your own risk. Some tweaks may affect system behavior. Always back up important data before applying system-wide changes.
