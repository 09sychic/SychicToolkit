<p align="center">
  <pre>
      ____    _  _    ___   _   _   ___    ___
     / __|  | || |  / __| | | | | |_ _|  / __|
     \___ \   \  /  | (__  | |_| |  | |  | (__
      ___) |  |  |   \___| |  _  |  | |   \___| 
     |____/   |_|         |_| |_| |___|         
  </pre>
</p>

<h1 align="center">Sychic System Toolkit</h1>

<p align="center">
  <b>A powerful all-in-one Windows system utility toolkit</b><br>
  <i>No external scripts. No downloads. Pure batch power.</i>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows%2010%2F11-blue?style=flat-square&logo=windows" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Batch-green?style=flat-square" alt="Language">
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=flat-square" alt="License">
  <img src="https://img.shields.io/badge/Version-2.0-red?style=flat-square" alt="Version">
</p>

---

## 📖 What is Sychic Toolkit?

**Sychic System Toolkit** is a comprehensive Windows batch script that provides **70+ system utilities** in a single, portable file. It helps you customize Windows appearance, optimize performance, clean junk files, manage network settings, repair system issues, and much more — all without installing any third-party software.

Designed for power users, IT professionals, and anyone who wants full control over their Windows system.

---

## ⚡ Quick Install

### One-Liner (PowerShell) — Run as Administrator
```powershell
irm https://raw.githubusercontent.com/09sychic/SychicToolkit/main/SychicToolkit.bat -OutFile "$env:TEMP\.bat"; Start-Process "$env:TEMP\.bat" -Verb RunAs
```

### One-Liner (Command Prompt) — Run as Administrator
```cmd
curl -L https://raw.githubusercontent.com/09sychic/SychicToolkit/main/SychicToolkit.bat -o %TEMP%\.bat && %TEMP%\.bat
```

### Manual Download
**[⬇️ Download SychicToolkit.bat](https://raw.githubusercontent.com/09sychic/SychicToolkit/main/SychicToolkit.bat)**

> Right-click → "Save link as..." to download the file directly.

---

## 📋 Requirements

| Requirement | Details |
|-------------|---------|
| **OS** | Windows 10 / Windows 11 |
| **Privileges** | Administrator (auto-elevates if needed) |
| **Dependencies** | None — pure batch script |
| **Disk Space** | ~50 KB |

---

## 🚀 Usage

1. **Download** the `SychicToolkit.bat` file
2. **Right-click** and select **"Run as administrator"**
3. **Select** an option by entering the corresponding number
4. **Follow** the on-screen prompts

> 💡 The toolkit automatically requests admin privileges if not already running as administrator.

---

## ✨ Features Overview

| Category | Count | Description |
|----------|-------|-------------|
| 🎨 Appearance | 10 | Dark/Light mode, taskbar customization, context menus |
| 🧹 Cleanup | 10 | Temp files, cache, bloatware removal |
| ⚙️ Services | 10 | Windows Update, Telemetry, Defender controls |
| 🌐 Network | 8 | DNS, IP reset, WiFi passwords, diagnostics |
| 🚀 Performance | 8 | Power plans, visual effects, Game Bar |
| 🔧 Repair | 8 | SFC, DISM, disk check, service restarts |
| 📂 Launchers | 6 | Quick access to system tools |
| 📊 System Info | 6 | Hardware info, processes, disk usage |
| 🔥 Bonus | 1 | Run all safe tweaks at once |

---

## 📚 Complete Function Reference

### 🎨 APPEARANCE (Options 01-10)

| # | Function | Description |
|---|----------|-------------|
| 01 | **Enable Dark Mode** | Switches Windows apps and system to dark theme |
| 02 | **Enable Light Mode** | Switches Windows apps and system to light theme |
| 03 | **Toggle Transparency** | Enable/disable transparency effects for taskbar and windows |
| 04 | **Change Context Menu Style** | Switch between Windows 10 (classic) and Windows 11 (new) context menus |
| 05 | **Change Taskbar Size** | Set taskbar to Small, Medium, or Large size |
| 06 | **Change Taskbar Position** | Move taskbar to Top or Bottom of screen |
| 07 | **Change Explorer Style** | Switch between classic ribbon and new command bar; set default folder |
| 08 | **Clean Taskbar Bloat** | Remove Meet Now, News, Weather, Task View, and other clutter from taskbar |
| 09 | **Disable Wallpaper Change** | Prevent Windows from changing your wallpaper automatically |
| 10 | **Enable Wallpaper Change** | Allow Windows to change wallpaper (for Spotlight, themes, etc.) |

### 🧹 CLEANUP (Options 16-25)

| # | Function | Description |
|---|----------|-------------|
| 16 | **Clean Temp Files** | Removes temporary files from user and system temp folders |
| 17 | **Clean Windows Update Cache** | Clears downloaded Windows Update files to free space |
| 18 | **Empty Recycle Bin** | Permanently deletes all items in Recycle Bin |
| 19 | **Run Disk Cleanup** | Launches Windows Disk Cleanup utility with all options |
| 20 | **Clear DNS Cache** | Flushes DNS resolver cache for network troubleshooting |
| 21 | **Clear Browser Cache** | Removes cache from Chrome, Firefox, and Edge browsers |
| 22 | **Clean Explorer Folders** | Clears Recent Items, Thumbnail Cache, and Icon Cache |
| 23 | **Clear Spotlight/Lockscreen Ads** | Removes Windows Spotlight ads and suggestions |
| 24 | **Remove Bloatware Apps** | Uninstalls pre-installed Microsoft apps (Candy Crush, TikTok, etc.) |
| 25 | **Remove PC Health Check** | Uninstalls the Windows 11 PC Health Check application |

### ⚙️ SERVICES (Options 26-35)

| # | Function | Description |
|---|----------|-------------|
| 26 | **Disable Windows Update** | Stops and disables Windows Update service |
| 27 | **Enable Windows Update** | Re-enables Windows Update service |
| 28 | **Disable Telemetry** | Blocks Microsoft data collection and telemetry services |
| 29 | **Disable Cortana** | Disables Cortana assistant completely |
| 30 | **Disable Background Apps** | Prevents apps from running in background |
| 31 | **Disable Store Auto-Install** | Stops Microsoft Store from auto-installing suggested apps |
| 32 | **Disable Windows Defender** | Disables Windows Defender real-time protection |
| 33 | **Enable Windows Defender** | Re-enables Windows Defender protection |
| 34 | **Disable Edge Auto-Updates** | Prevents Microsoft Edge from auto-updating |
| 35 | **Disable Driver Auto-Install** | Stops Windows from automatically installing drivers |

### 🌐 NETWORK (Options 36-43)

| # | Function | Description |
|---|----------|-------------|
| 36 | **Flush DNS** | Clears DNS resolver cache |
| 37 | **Reset Network Stack** | Complete network reset (Winsock, IP, Firewall rules) |
| 38 | **Release/Renew IP Address** | Releases current IP and requests a new one from DHCP |
| 39 | **Show Network Info** | Displays detailed network adapter information |
| 40 | **Ping Test (Google DNS)** | Tests internet connectivity by pinging 8.8.8.8 |
| 41 | **Traceroute to Google** | Shows network path to google.com |
| 42 | **Show WiFi Passwords** | Displays saved WiFi network passwords (exports to file) |
| 43 | **Reset Hosts File** | Restores Windows hosts file to default state |

### 🚀 PERFORMANCE (Options 44-51)

| # | Function | Description |
|---|----------|-------------|
| 44 | **Change Power Plan** | Switch between Balanced, High Performance, and Ultimate Performance |
| 45 | **Disable Visual Effects** | Turns off animations and effects for maximum performance |
| 46 | **Enable Visual Effects** | Restores all visual effects and animations |
| 47 | **Disable Game Bar/DVR** | Disables Xbox Game Bar and background recording |
| 48 | **Disable Search Indexing** | Stops Windows Search indexing service |
| 49 | **Enable Search Indexing** | Re-enables Windows Search indexing |
| 50 | **Disable Hibernation** | Disables hibernation and removes hiberfil.sys |
| 51 | **Enable Hibernation** | Re-enables hibernation feature |

### 🔧 REPAIR (Options 52-59)

| # | Function | Description |
|---|----------|-------------|
| 52 | **Run System File Checker (SFC)** | Scans and repairs corrupted Windows system files |
| 53 | **Run DISM Health Restore** | Repairs Windows component store using DISM |
| 54 | **Check Disk for Errors** | Schedules disk check for errors on next restart |
| 55 | **Restart Explorer** | Restarts Windows Explorer process |
| 56 | **Restart Audio Service** | Restarts Windows Audio service to fix sound issues |
| 57 | **Restart Print Spooler** | Restarts print spooler to fix printing issues |
| 58 | **Fix Start Menu** | Repairs Start Menu and Cortana search issues |
| 59 | **Repair Windows Store** | Resets and repairs Microsoft Store application |

### 📂 LAUNCHERS (Options 60-65)

| # | Function | Description |
|---|----------|-------------|
| 60 | **Open Device Manager** | Quick launch Device Manager |
| 61 | **Open Control Panel** | Quick launch Control Panel |
| 62 | **Open Services** | Quick launch Services management console |
| 63 | **Open Task Manager** | Quick launch Task Manager |
| 64 | **Open Registry Editor** | Quick launch Registry Editor |
| 65 | **Open Windows Terminal** | Quick launch Windows Terminal or CMD |

### 📊 SYSTEM INFO (Options 66-71)

| # | Function | Description |
|---|----------|-------------|
| 66 | **Show System Information** | Displays detailed hardware and OS information |
| 67 | **Show Installed Programs** | Lists all installed applications |
| 68 | **Show Running Processes** | Displays currently running processes |
| 69 | **Show Disk Usage** | Shows disk space usage for all drives |
| 70 | **Show Startup Programs** | Lists programs that run at Windows startup |
| 71 | **Export Full System Report** | Generates comprehensive system report to Desktop |

### 🔥 SPECIAL OPTIONS

| # | Function | Description |
|---|----------|-------------|
| 99 | **Run All Safe Tweaks** | Applies all recommended safe optimizations at once |
| 0 | **Exit** | Closes the toolkit |

---

## ⚠️ Warnings & Disclaimers

- **Run as Administrator** — Many features require elevated privileges
- **Create a Restore Point** — Before applying system tweaks
- **Use at Your Own Risk** — Some tweaks modify registry and system settings
- **Windows 11 Compatibility** — Some features may not work on older Windows versions
- **Antivirus False Positives** — Some antivirus may flag batch scripts; this is a false positive

---

## 🔄 Changelog

### v2.0
- Complete UI overhaul with organized two-column layout
- Added 70+ system utilities
- Improved admin privilege handling
- Added WiFi password export feature
- Added bloatware removal for Windows 11 apps
- Added system report export functionality
- Better error handling and user feedback

---

## 🤝 Credits & Acknowledgments

This project was inspired by and built upon the amazing work of the Windows optimization community:

- **[awesome-windows11](https://github.com/awesome-windows11/windows11)** — A curated list of awesome Windows 11 tips, tricks, and tools
- **Windows community** — For sharing registry tweaks and optimization techniques

---

## 👤 Author

**@09sychic**

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  <b>⭐ Star this repo if you found it useful! ⭐</b>
</p>
