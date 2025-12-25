@echo off
setlocal EnableDelayedExpansion
:: ============================================================================
:: SYCHIC SYSTEM TOOLKIT v3.0
:: Author: @09sychic
:: A powerful all-in-one Windows system utility toolkit
:: No external scripts. No downloads. Pure batch power.
:: ============================================================================

set VERSION=3.0.0
set "GITHUB_RAW=https://raw.githubusercontent.com/09sychic/SychicToolkit/main/SychicToolkit.bat"
set "BACKUP_DIR=%USERPROFILE%\SychicToolkitBackups"
set "SCRIPT_PATH=%~f0"

:: Create backup directory if not exists
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: Check for admin rights and self-elevate if needed
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting Administrator privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

:: Detect Windows version
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION_NUM=%%i.%%j
if "%VERSION_NUM%"=="10.0" (
    for /f "tokens=6 delims=[]. " %%i in ('ver') do set BUILD_NUM=%%i
    if !BUILD_NUM! GEQ 22000 (
        set "WIN_VER=11"
    ) else (
        set "WIN_VER=10"
    )
) else (
    set "WIN_VER=10"
)

:: Check for updates
call :CHECK_UPDATE

:: Set console properties
mode con: cols=120 lines=50
title Sychic System Toolkit v3.0 - @09sychic

:MENU
cls
color 0B

echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|      ____    _  _    ___   _   _   ___    ___                              ^|
echo   ^|     / ___^|  ^| ^|^| ^|  / __^| ^| ^| ^| ^| ^|_ _^|  / __^|                             ^|
echo   ^|     \___ \   \  /  ^| (__  ^| ^|_^| ^|  ^| ^|  ^| (__                              ^|
echo   ^|      ___) ^|  ^|  ^|   \___^| ^|  _  ^|  ^| ^|   \___^|                             ^|
echo   ^|     ^|____/   ^|_^|         ^|_^| ^|_^| ^|___^|                                    ^|
echo   ^|                                                                           ^|
echo   ^|       S Y S T E M   T O O L K I T   v 3 . 0  [Win!WIN_VER!]  @09sychic       ^|
echo   ^|___________________________________________________________________________^|
echo.

color 0F
echo    [APPEARANCE]                             [CLEANUP]
echo    ------------------------------------     ------------------------------------
echo     01. Enable Dark Mode                     16. Clean Temp Files
echo     02. Enable Light Mode                    17. Clean Windows Update Cache
echo     03. Toggle Transparency                  18. Empty Recycle Bin
echo     04. Change Context Menu Style            19. Run Disk Cleanup
echo     05. Change Taskbar Size                  20. Clear DNS Cache
echo     06. Change Taskbar Position              21. Clear Browser Cache
echo     07. Change Explorer Style                22. Clean Explorer Folders
echo     08. Clean Taskbar Bloat                  23. Clear Spotlight/Lockscreen Ads
echo     09. Disable Wallpaper Change             24. Remove Bloatware Apps
echo     10. Enable Wallpaper Change              25. Remove PC Health Check
echo.
echo    [SERVICES]                               [NETWORK]
echo    ------------------------------------     ------------------------------------
echo     26. Disable Windows Update               36. Flush DNS
echo     27. Enable Windows Update                37. Reset Network Stack
echo     28. Disable Telemetry                    38. Release/Renew IP Address
echo     29. Disable Cortana                      39. Show Network Info
echo     30. Disable Background Apps              40. Ping Test (Google DNS)
echo     31. Disable Store Auto-Install           41. Traceroute to Google
echo     32. Disable Windows Defender             42. Show WiFi Passwords
echo     33. Enable Windows Defender              43. Reset Hosts File
echo     34. Disable Edge Auto-Updates
echo     35. Disable Driver Auto-Install
echo.
echo    [PERFORMANCE]                            [REPAIR]
echo    ------------------------------------     ------------------------------------
echo     44. Change Power Plan                    52. Run System File Checker (SFC)
echo     45. Disable Visual Effects               53. Run DISM Health Restore
echo     46. Enable Visual Effects                54. Check Disk for Errors
echo     47. Disable Game Bar/DVR                 55. Restart Explorer
echo     48. Disable Search Indexing              56. Restart Audio Service
echo     49. Enable Search Indexing               57. Restart Print Spooler
echo     50. Disable Hibernation                  58. Fix Start Menu
echo     51. Enable Hibernation                   59. Repair Windows Store
echo.
echo    [ADVANCED TOOLS]                         [SYSTEM INFO]
echo    ------------------------------------     ------------------------------------
echo     60. Windows Auto Repair Suite            66. Show System Information
echo     61. One Click PC Tune Up                 67. Show Installed Programs
echo     62. Network Doctor                       68. Show Running Processes
echo     63. Startup Bloat Manager                69. Show Disk Usage
echo     64. Basic Windows Hardening              70. Show Startup Programs
echo     65. Defender Control Panel               71. Export Full System Report
echo.
echo    [SECURITY ^& MORE]
echo    ------------------------------------
echo     72. User Account Auditor                 76. EXTENDED CLEANING
echo     73. Windows Feature Toggle               77. APPX BLOAT CONTROL
echo     74. STARTUP APPS NUKER                   78. SERVICE MANAGER
echo     75. INTERACTIVE DEBLOATER                79. DISABLE ADS ^& SUGGESTIONS
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   [99] RUN ALL SAFE TWEAKS                              [0] EXIT          ^|
echo   ^|___________________________________________________________________________^|
echo.
set /p choice="   Enter your choice [0-99]: "

:: Input validation
if "%choice%"=="" goto MENU
if "%choice%"=="0" goto EXIT
if "%choice%"=="1" goto DARK_MODE
if "%choice%"=="01" goto DARK_MODE
if "%choice%"=="2" goto LIGHT_MODE
if "%choice%"=="02" goto LIGHT_MODE
if "%choice%"=="3" goto TOGGLE_TRANSPARENCY
if "%choice%"=="03" goto TOGGLE_TRANSPARENCY
if "%choice%"=="4" goto CONTEXT_MENU
if "%choice%"=="04" goto CONTEXT_MENU
if "%choice%"=="5" goto TASKBAR_SIZE
if "%choice%"=="05" goto TASKBAR_SIZE
if "%choice%"=="6" goto TASKBAR_POSITION
if "%choice%"=="06" goto TASKBAR_POSITION
if "%choice%"=="7" goto EXPLORER_STYLE
if "%choice%"=="07" goto EXPLORER_STYLE
if "%choice%"=="8" goto CLEAN_TASKBAR
if "%choice%"=="08" goto CLEAN_TASKBAR
if "%choice%"=="9" goto DISABLE_WALLPAPER
if "%choice%"=="09" goto DISABLE_WALLPAPER
if "%choice%"=="10" goto ENABLE_WALLPAPER
if "%choice%"=="16" goto CLEAN_TEMP
if "%choice%"=="17" goto CLEAN_UPDATE_CACHE
if "%choice%"=="18" goto EMPTY_RECYCLE
if "%choice%"=="19" goto DISK_CLEANUP
if "%choice%"=="20" goto CLEAR_DNS
if "%choice%"=="21" goto CLEAR_BROWSER
if "%choice%"=="22" goto CLEAN_EXPLORER
if "%choice%"=="23" goto CLEAR_SPOTLIGHT
if "%choice%"=="24" goto REMOVE_BLOATWARE
if "%choice%"=="25" goto REMOVE_PCHEALTHCHECK
if "%choice%"=="26" goto DISABLE_UPDATE
if "%choice%"=="27" goto ENABLE_UPDATE
if "%choice%"=="28" goto DISABLE_TELEMETRY
if "%choice%"=="29" goto DISABLE_CORTANA
if "%choice%"=="30" goto DISABLE_BACKGROUND
if "%choice%"=="31" goto DISABLE_STORE_AUTO
if "%choice%"=="32" goto DISABLE_DEFENDER
if "%choice%"=="33" goto ENABLE_DEFENDER
if "%choice%"=="34" goto DISABLE_EDGE_UPDATE
if "%choice%"=="35" goto DISABLE_DRIVER_AUTO
if "%choice%"=="36" goto FLUSH_DNS
if "%choice%"=="37" goto RESET_NETWORK
if "%choice%"=="38" goto RENEW_IP
if "%choice%"=="39" goto NETWORK_INFO
if "%choice%"=="40" goto PING_TEST
if "%choice%"=="41" goto TRACEROUTE
if "%choice%"=="42" goto WIFI_PASSWORDS
if "%choice%"=="43" goto RESET_HOSTS
if "%choice%"=="44" goto POWER_PLAN
if "%choice%"=="45" goto DISABLE_VISUAL
if "%choice%"=="46" goto ENABLE_VISUAL
if "%choice%"=="47" goto DISABLE_GAMEBAR
if "%choice%"=="48" goto DISABLE_INDEXING
if "%choice%"=="49" goto ENABLE_INDEXING
if "%choice%"=="50" goto DISABLE_HIBERNATE
if "%choice%"=="51" goto ENABLE_HIBERNATE
if "%choice%"=="52" goto RUN_SFC
if "%choice%"=="53" goto RUN_DISM
if "%choice%"=="54" goto CHECK_DISK
if "%choice%"=="55" goto RESTART_EXPLORER
if "%choice%"=="56" goto RESTART_AUDIO
if "%choice%"=="57" goto RESTART_PRINT
if "%choice%"=="58" goto FIX_STARTMENU
if "%choice%"=="59" goto REPAIR_STORE
if "%choice%"=="60" goto AUTO_REPAIR_SUITE
if "%choice%"=="61" goto ONE_CLICK_TUNEUP
if "%choice%"=="62" goto NETWORK_DOCTOR
if "%choice%"=="63" goto STARTUP_BLOAT_MANAGER
if "%choice%"=="64" goto WINDOWS_HARDENING
if "%choice%"=="65" goto DEFENDER_CONTROL
if "%choice%"=="66" goto SYSTEM_INFO
if "%choice%"=="67" goto INSTALLED_PROGRAMS
if "%choice%"=="68" goto RUNNING_PROCESSES
if "%choice%"=="69" goto DISK_USAGE
if "%choice%"=="70" goto STARTUP_PROGRAMS
if "%choice%"=="71" goto EXPORT_REPORT
if "%choice%"=="72" goto USER_ACCOUNT_AUDITOR
if "%choice%"=="73" goto WINDOWS_FEATURE_TOGGLE
if "%choice%"=="74" goto STARTUP_NUKER
if "%choice%"=="75" goto INTERACTIVE_DEBLOATER
if "%choice%"=="76" goto EXTENDED_CLEANING
if "%choice%"=="77" goto APPX_CONTROL
if "%choice%"=="78" goto SERVICE_MANAGER
if "%choice%"=="79" goto DISABLE_ADS
if "%choice%"=="99" goto RUN_ALL_SAFE

echo.
echo    [!] Invalid choice. Please try again.
timeout /t 2 >nul
goto MENU

:: ============================================================================
:: SELF-UPDATE SYSTEM (FIXED)
:: ============================================================================

:CHECK_UPDATE
set "TEMP_BAT=%TEMP%\SychicToolkit_temp.bat"

:: Download the remote file
powershell -Command "(New-Object Net.WebClient).DownloadFile('%GITHUB_RAW%', '%TEMP_BAT%')" >nul 2>&1
if not exist "%TEMP_BAT%" exit /b

:: Extract remote version - fixed parsing
set "REMOTE_VER="
for /f "tokens=*" %%a in ('findstr /B /C:"set VERSION=" "%TEMP_BAT%" 2^>nul') do (
    set "line=%%a"
)
if defined line (
    for /f "tokens=2 delims==" %%b in ("!line!") do set "REMOTE_VER=%%b"
)

:: Remove any spaces
set "REMOTE_VER=!REMOTE_VER: =!"
set "LOCAL_VER=%VERSION%"

:: Skip update if versions match OR if remote version is empty/invalid
if "!REMOTE_VER!"=="" (
    del "%TEMP_BAT%" >nul 2>&1
    exit /b
)

if "!LOCAL_VER!"=="!REMOTE_VER!" (
    del "%TEMP_BAT%" >nul 2>&1
    exit /b
)

:: Only prompt if versions are actually different
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   UPDATE AVAILABLE                                                        ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    New version detected on GitHub!
echo.
echo    Current version: %VERSION%
echo    Latest version:  !REMOTE_VER!
echo.
set /p updatechoice="   Update now? (Y/N): "
if /i "!updatechoice!"=="Y" (
    echo.
    echo    [*] Updating...
    copy /Y "%TEMP_BAT%" "%SCRIPT_PATH%" >nul
    echo    [+] Update complete! Relaunching...
    del "%TEMP_BAT%" >nul 2>&1
    start "" "%SCRIPT_PATH%"
    exit
)
del "%TEMP_BAT%" >nul 2>&1
exit /b

:: ============================================================================
:: WINDOWS AUTO REPAIR SUITE (NEW)
:: ============================================================================

:AUTO_REPAIR_SUITE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   WINDOWS AUTO REPAIR SUITE                                               ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    This will run a complete system repair:
echo     - System File Checker (SFC)
echo     - DISM Restore Health
echo     - Reset Windows Update
echo     - Restart Critical Services
echo     - Check Disk
echo     - Generate Status Report
echo.
set /p confirm="   Proceed with full repair? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU

set "REPAIR_LOG=%BACKUP_DIR%\repair_log_%DATE:~-4%%DATE:~-10,2%%DATE:~-7,2%_%TIME:~0,2%%TIME:~3,2%.txt"
set "REPAIR_LOG=!REPAIR_LOG: =0!"

echo.
echo    ============================================ > "!REPAIR_LOG!"
echo    WINDOWS AUTO REPAIR SUITE - LOG >> "!REPAIR_LOG!"
echo    Date: %DATE% %TIME% >> "!REPAIR_LOG!"
echo    ============================================ >> "!REPAIR_LOG!"
echo.

echo    [1/6] Running System File Checker (SFC)...
echo. >> "!REPAIR_LOG!"
echo    === SFC SCAN === >> "!REPAIR_LOG!"
sfc /scannow >> "!REPAIR_LOG!" 2>&1
echo    [+] SFC complete.

echo    [2/6] Running DISM RestoreHealth...
echo. >> "!REPAIR_LOG!"
echo    === DISM RESTORE HEALTH === >> "!REPAIR_LOG!"
DISM /Online /Cleanup-Image /RestoreHealth >> "!REPAIR_LOG!" 2>&1
echo    [+] DISM complete.

echo    [3/6] Resetting Windows Update...
echo. >> "!REPAIR_LOG!"
echo    === WINDOWS UPDATE RESET === >> "!REPAIR_LOG!"
net stop wuauserv >> "!REPAIR_LOG!" 2>&1
net stop bits >> "!REPAIR_LOG!" 2>&1
net stop cryptSvc >> "!REPAIR_LOG!" 2>&1
rd /s /q "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
mkdir "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
net start cryptSvc >> "!REPAIR_LOG!" 2>&1
net start wuauserv >> "!REPAIR_LOG!" 2>&1
net start bits >> "!REPAIR_LOG!" 2>&1
echo    Windows Update components reset. >> "!REPAIR_LOG!"
echo    [+] Windows Update reset complete.

echo    [4/6] Restarting Critical Services...
echo. >> "!REPAIR_LOG!"
echo    === CRITICAL SERVICES RESTART === >> "!REPAIR_LOG!"
net stop Spooler >nul 2>&1
net start Spooler >> "!REPAIR_LOG!" 2>&1
net stop Audiosrv >nul 2>&1
net start Audiosrv >> "!REPAIR_LOG!" 2>&1
net stop Dnscache >nul 2>&1
net start Dnscache >> "!REPAIR_LOG!" 2>&1
echo    Critical services restarted. >> "!REPAIR_LOG!"
echo    [+] Services restarted.

echo    [5/6] Running Disk Check...
echo. >> "!REPAIR_LOG!"
echo    === DISK CHECK === >> "!REPAIR_LOG!"
chkdsk C: /scan >> "!REPAIR_LOG!" 2>&1
echo    [+] Disk check complete.

echo    [6/6] Generating Status Report...
echo. >> "!REPAIR_LOG!"
echo    === FINAL STATUS === >> "!REPAIR_LOG!"
echo    Repair completed at: %DATE% %TIME% >> "!REPAIR_LOG!"

echo.
echo    ___________________________________________________________________________
echo   ^|                        REPAIR SUMMARY                                     ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [+] SFC Scan: Completed
echo    [+] DISM RestoreHealth: Completed
echo    [+] Windows Update Reset: Completed
echo    [+] Critical Services: Restarted
echo    [+] Disk Check: Completed
echo.
echo    Full log saved to: !REPAIR_LOG!
echo.
echo    [!] A system restart is recommended.
echo.
set /p openlog="   Open log file? (Y/N): "
if /i "!openlog!"=="Y" start notepad "!REPAIR_LOG!"
pause
goto MENU

:: ============================================================================
:: ONE CLICK PC TUNE UP (NEW)
:: ============================================================================

:ONE_CLICK_TUNEUP
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ONE CLICK PC TUNE UP                                                    ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Clear Temp and Cache
echo     [2] Disable Visual Effects
echo     [3] Set High Performance Power Plan
echo     [4] Clean Prefetch
echo     [5] Restart Explorer
echo     [6] RUN ALL TUNE UPS
echo     [7] RUN ALL + REBOOT
echo     [0] Back to Main Menu
echo.
set /p tuneup="   Enter your choice [0-7]: "

if "%tuneup%"=="0" goto MENU
if "%tuneup%"=="1" goto TUNEUP_TEMP
if "%tuneup%"=="2" goto TUNEUP_VISUAL
if "%tuneup%"=="3" goto TUNEUP_POWER
if "%tuneup%"=="4" goto TUNEUP_PREFETCH
if "%tuneup%"=="5" goto TUNEUP_EXPLORER
if "%tuneup%"=="6" goto TUNEUP_ALL
if "%tuneup%"=="7" goto TUNEUP_ALL_REBOOT
goto ONE_CLICK_TUNEUP

:TUNEUP_TEMP
echo.
echo    [*] Clearing temp and cache files...
del /q/f/s "%TEMP%\*" >nul 2>&1
del /q/f/s "%WINDIR%\Temp\*" >nul 2>&1
del /q/f/s "%LOCALAPPDATA%\Temp\*" >nul 2>&1
del /q/f/s "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1
echo    [+] Temp and cache cleared!
pause
goto ONE_CLICK_TUNEUP

:TUNEUP_VISUAL
echo.
echo    [*] Disabling visual effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
echo    [+] Visual effects disabled!
pause
goto ONE_CLICK_TUNEUP

:TUNEUP_POWER
echo.
echo    [*] Setting High Performance power plan...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
if errorlevel 1 (
    powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
)
echo    [+] High Performance power plan activated!
pause
goto ONE_CLICK_TUNEUP

:TUNEUP_PREFETCH
echo.
echo    [*] Cleaning prefetch...
del /q/f/s "%WINDIR%\Prefetch\*" >nul 2>&1
echo    [+] Prefetch cleaned!
pause
goto ONE_CLICK_TUNEUP

:TUNEUP_EXPLORER
echo.
echo    [*] Restarting Explorer...
taskkill /F /IM explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe
echo    [+] Explorer restarted!
pause
goto ONE_CLICK_TUNEUP

:TUNEUP_ALL
echo.
echo    [*] Running all tune ups...
echo    [1/5] Clearing temp and cache...
del /q/f/s "%TEMP%\*" >nul 2>&1
del /q/f/s "%WINDIR%\Temp\*" >nul 2>&1
del /q/f/s "%LOCALAPPDATA%\Temp\*" >nul 2>&1
echo    [2/5] Disabling visual effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
echo    [3/5] Setting High Performance power plan...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
echo    [4/5] Cleaning prefetch...
del /q/f/s "%WINDIR%\Prefetch\*" >nul 2>&1
echo    [5/5] Restarting Explorer...
taskkill /F /IM explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe
echo.
echo    [+] All tune ups complete!
pause
goto MENU

:TUNEUP_ALL_REBOOT
echo.
echo    [*] Running all tune ups...
echo    [1/5] Clearing temp and cache...
del /q/f/s "%TEMP%\*" >nul 2>&1
del /q/f/s "%WINDIR%\Temp\*" >nul 2>&1
del /q/f/s "%LOCALAPPDATA%\Temp\*" >nul 2>&1
echo    [2/5] Disabling visual effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
echo    [3/5] Setting High Performance power plan...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
echo    [4/5] Cleaning prefetch...
del /q/f/s "%WINDIR%\Prefetch\*" >nul 2>&1
echo    [5/5] All done!
echo.
echo    [+] All tune ups complete!
echo.
echo    [!] System will reboot in 10 seconds...
echo    [!] Press Ctrl+C to cancel.
timeout /t 10
shutdown /r /t 0
goto MENU

:: ============================================================================
:: NETWORK DOCTOR (NEW)
:: ============================================================================

:NETWORK_DOCTOR
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   NETWORK DOCTOR                                                          ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Flush DNS
echo     [2] Reset Winsock
echo     [3] Reset IP Stack
echo     [4] Release/Renew IP
echo     [5] Reset Firewall
echo     [6] Ping Test
echo     [7] Speed Test (PowerShell)
echo     [8] RUN FULL NETWORK REPAIR
echo     [9] Save Results to Log
echo     [0] Back to Main Menu
echo.
set /p netdoc="   Enter your choice [0-9]: "

if "%netdoc%"=="0" goto MENU
if "%netdoc%"=="1" (
    echo.
    echo    [*] Flushing DNS...
    ipconfig /flushdns
    pause
    goto NETWORK_DOCTOR
)
if "%netdoc%"=="2" (
    echo.
    echo    [*] Resetting Winsock...
    netsh winsock reset
    echo    [+] Winsock reset complete. Restart required.
    pause
    goto NETWORK_DOCTOR
)
if "%netdoc%"=="3" (
    echo.
    echo    [*] Resetting IP Stack...
    netsh int ip reset
    echo    [+] IP stack reset. Restart required.
    pause
    goto NETWORK_DOCTOR
)
if "%netdoc%"=="4" (
    echo.
    echo    [*] Releasing IP...
    ipconfig /release
    echo    [*] Renewing IP...
    ipconfig /renew
    pause
    goto NETWORK_DOCTOR
)
if "%netdoc%"=="5" (
    echo.
    echo    [*] Resetting Firewall to defaults...
    netsh advfirewall reset
    echo    [+] Firewall reset!
    pause
    goto NETWORK_DOCTOR
)
if "%netdoc%"=="6" (
    echo.
    echo    [*] Ping Test to 8.8.8.8, 1.1.1.1, google.com...
    echo.
    ping 8.8.8.8 -n 4
    echo.
    ping 1.1.1.1 -n 4
    echo.
    ping google.com -n 4
    pause
    goto NETWORK_DOCTOR
)
if "%netdoc%"=="7" (
    echo.
    echo    [*] Running Speed Test via PowerShell...
    echo    [*] Testing download speed ^(approx^)...
    powershell -Command "$ProgressPreference = 'SilentlyContinue'; $webClient = New-Object System.Net.WebClient; $start = Get-Date; $webClient.DownloadData('http://speedtest.tele2.net/1MB.zip') | Out-Null; $end = Get-Date; $time = ($end - $start).TotalSeconds; $speed = [math]::Round(8 / $time, 2); Write-Host '    Download Speed: ~' $speed 'Mbps (1MB test file)'"
    pause
    goto NETWORK_DOCTOR
)
if "%netdoc%"=="8" (
    echo.
    echo    [*] Running full network repair...
    echo    [1/5] Flushing DNS...
    ipconfig /flushdns
    echo    [2/5] Resetting Winsock...
    netsh winsock reset
    echo    [3/5] Resetting IP Stack...
    netsh int ip reset
    echo    [4/5] Resetting Firewall...
    netsh advfirewall reset
    echo    [5/5] Renewing IP...
    ipconfig /release >nul 2>&1
    ipconfig /renew
    echo.
    echo    [+] Full network repair complete!
    echo    [!] System restart recommended.
    pause
    goto NETWORK_DOCTOR
)
if "%netdoc%"=="9" (
    set "NETLOG=%BACKUP_DIR%\network_log_%DATE:~-4%%DATE:~-10,2%%DATE:~-7,2%.txt"
    echo    === NETWORK DOCTOR LOG === > "!NETLOG!"
    echo    Date: %DATE% %TIME% >> "!NETLOG!"
    echo. >> "!NETLOG!"
    echo    === IPCONFIG /ALL === >> "!NETLOG!"
    ipconfig /all >> "!NETLOG!"
    echo. >> "!NETLOG!"
    echo    === PING TESTS === >> "!NETLOG!"
    ping 8.8.8.8 -n 4 >> "!NETLOG!"
    ping google.com -n 4 >> "!NETLOG!"
    echo. >> "!NETLOG!"
    echo    === ROUTE PRINT === >> "!NETLOG!"
    route print >> "!NETLOG!"
    echo.
    echo    [+] Log saved to: !NETLOG!
    start notepad "!NETLOG!"
    pause
    goto NETWORK_DOCTOR
)
goto NETWORK_DOCTOR

:: ============================================================================
:: STARTUP BLOAT MANAGER (NEW)
:: ============================================================================

:STARTUP_BLOAT_MANAGER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   STARTUP BLOAT MANAGER                                                   ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] List All Startup Registry Entries
echo     [2] Disable Selected Startup Entry
echo     [3] Restore Disabled Entry
echo     [4] Backup All Startup Keys
echo     [5] View Backup Files
echo     [0] Back to Main Menu
echo.
set /p sbm="   Enter your choice [0-5]: "

if "%sbm%"=="0" goto MENU
if "%sbm%"=="1" (
    cls
    echo.
    echo    === HKCU\...\Run ===
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
    echo.
    echo    === HKLM\...\Run ===
    reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
    echo.
    echo    === DISABLED ITEMS ===
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" 2>nul
    echo.
    pause
    goto STARTUP_BLOAT_MANAGER
)
if "%sbm%"=="2" (
    echo.
    echo    Enter the VALUE NAME of the startup entry to disable:
    echo    (Example: OneDrive, Spotify, etc.)
    echo.
    set /p disableentry="   Entry name: "
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "!disableentry!" /f >nul 2>&1
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "!disableentry!" /f >nul 2>&1
    echo    [+] Entry '!disableentry!' disabled (if it existed).
    pause
    goto STARTUP_BLOAT_MANAGER
)
if "%sbm%"=="3" (
    echo.
    echo    [*] Listing available backup files...
    dir "%BACKUP_DIR%\startup_backup_*.reg" /B 2>nul
    echo.
    set /p restorefile="   Enter full filename to restore: "
    if exist "%BACKUP_DIR%\!restorefile!" (
        reg import "%BACKUP_DIR%\!restorefile!"
        echo    [+] Restored from !restorefile!
    ) else (
        echo    [!] File not found.
    )
    pause
    goto STARTUP_BLOAT_MANAGER
)
if "%sbm%"=="4" (
    set "SBM_BACKUP=%BACKUP_DIR%\startup_backup_%DATE:~-4%%DATE:~-10,2%%DATE:~-7,2%"
    echo    [*] Backing up startup registry keys...
    reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" "!SBM_BACKUP!_HKCU.reg" /y >nul 2>&1
    reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" "!SBM_BACKUP!_HKLM.reg" /y >nul 2>&1
    echo    [+] Backup saved to: !SBM_BACKUP!_*.reg
    pause
    goto STARTUP_BLOAT_MANAGER
)
if "%sbm%"=="5" (
    echo.
    dir "%BACKUP_DIR%\startup_backup_*" /B 2>nul
    pause
    goto STARTUP_BLOAT_MANAGER
)
goto STARTUP_BLOAT_MANAGER

:: ============================================================================
:: BASIC WINDOWS HARDENING (NEW)
:: ============================================================================

:WINDOWS_HARDENING
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   BASIC WINDOWS HARDENING                                                 ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Disable SMBv1 (Recommended)
echo     [2] Disable Remote Registry
echo     [3] Disable PowerShell v2
echo     [4] Enable Firewall Rules
echo     [5] Block Risky Services
echo     [6] APPLY ALL HARDENING
echo     [7] RESTORE DEFAULTS
echo     [0] Back to Main Menu
echo.
set /p harden="   Enter your choice [0-7]: "

if "%harden%"=="0" goto MENU
if "%harden%"=="1" (
    echo.
    echo    [*] Disabling SMBv1...
    dism /online /Disable-Feature /FeatureName:SMB1Protocol /NoRestart >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v SMB1 /t REG_DWORD /d 0 /f >nul
    echo    [+] SMBv1 disabled!
    pause
    goto WINDOWS_HARDENING
)
if "%harden%"=="2" (
    echo.
    echo    [*] Disabling Remote Registry...
    sc config RemoteRegistry start= disabled >nul 2>&1
    net stop RemoteRegistry >nul 2>&1
    echo    [+] Remote Registry disabled!
    pause
    goto WINDOWS_HARDENING
)
if "%harden%"=="3" (
    echo.
    echo    [*] Disabling PowerShell v2...
    dism /online /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 /NoRestart >nul 2>&1
    dism /online /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2Root /NoRestart >nul 2>&1
    echo    [+] PowerShell v2 disabled!
    pause
    goto WINDOWS_HARDENING
)
if "%harden%"=="4" (
    echo.
    echo    [*] Enabling Firewall for all profiles...
    netsh advfirewall set allprofiles state on
    echo    [+] Firewall enabled!
    pause
    goto WINDOWS_HARDENING
)
if "%harden%"=="5" (
    echo.
    echo    [*] Blocking risky services...
    sc config RemoteRegistry start= disabled >nul 2>&1
    sc config RemoteAccess start= disabled >nul 2>&1
    sc config Telephony start= disabled >nul 2>&1
    sc config TapiSrv start= disabled >nul 2>&1
    echo    [+] Risky services blocked!
    pause
    goto WINDOWS_HARDENING
)
if "%harden%"=="6" (
    echo.
    echo    [*] Applying all hardening measures...
    echo    [1/5] Disabling SMBv1...
    dism /online /Disable-Feature /FeatureName:SMB1Protocol /NoRestart >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v SMB1 /t REG_DWORD /d 0 /f >nul
    echo    [2/5] Disabling Remote Registry...
    sc config RemoteRegistry start= disabled >nul 2>&1
    echo    [3/5] Disabling PowerShell v2...
    dism /online /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 /NoRestart >nul 2>&1
    echo    [4/5] Enabling Firewall...
    netsh advfirewall set allprofiles state on >nul
    echo    [5/5] Blocking risky services...
    sc config RemoteAccess start= disabled >nul 2>&1
    echo.
    echo    [+] All hardening measures applied!
    pause
    goto WINDOWS_HARDENING
)
if "%harden%"=="7" (
    echo.
    echo    [*] Restoring defaults...
    sc config RemoteRegistry start= demand >nul 2>&1
    sc config RemoteAccess start= demand >nul 2>&1
    dism /online /Enable-Feature /FeatureName:SMB1Protocol /NoRestart >nul 2>&1
    echo    [+] Defaults restored!
    pause
    goto WINDOWS_HARDENING
)
goto WINDOWS_HARDENING

:: ============================================================================
:: DEFENDER CONTROL PANEL (NEW)
:: ============================================================================

:DEFENDER_CONTROL
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DEFENDER CONTROL PANEL                                                  ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Show Defender Status
echo     [2] Toggle Real-Time Protection
echo     [3] Toggle Cloud Protection
echo     [4] Toggle Sample Submission
echo     [5] Open Windows Security App
echo     [0] Back to Main Menu
echo.
set /p defctl="   Enter your choice [0-5]: "

if "%defctl%"=="0" goto MENU
if "%defctl%"=="1" (
    echo.
    echo    === WINDOWS DEFENDER STATUS ===
    echo.
    powershell -Command "Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled, IoavProtectionEnabled, AntispywareEnabled, BehaviorMonitorEnabled | Format-List"
    pause
    goto DEFENDER_CONTROL
)
if "%defctl%"=="2" (
    echo.
    echo    [*] Toggling Real-Time Protection...
    echo    [!] Note: This may be blocked by Tamper Protection.
    powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $(!((Get-MpPreference).DisableRealtimeMonitoring))"
    echo    [+] Real-Time Protection toggled!
    pause
    goto DEFENDER_CONTROL
)
if "%defctl%"=="3" (
    echo.
    echo    [*] Toggling Cloud Protection...
    powershell -Command "Set-MpPreference -MAPSReporting $(if((Get-MpPreference).MAPSReporting -eq 0){2}else{0})"
    echo    [+] Cloud Protection toggled!
    pause
    goto DEFENDER_CONTROL
)
if "%defctl%"=="4" (
    echo.
    echo    [*] Toggling Sample Submission...
    powershell -Command "Set-MpPreference -SubmitSamplesConsent $(if((Get-MpPreference).SubmitSamplesConsent -eq 0){1}else{0})"
    echo    [+] Sample Submission toggled!
    pause
    goto DEFENDER_CONTROL
)
if "%defctl%"=="5" (
    echo    [*] Opening Windows Security...
    start windowsdefender:
    goto DEFENDER_CONTROL
)
goto DEFENDER_CONTROL

:: ============================================================================
:: USER ACCOUNT AUDITOR (NEW)
:: ============================================================================

:USER_ACCOUNT_AUDITOR
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   USER ACCOUNT AUDITOR                                                    ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] List All Local Users
echo     [2] Show Admin Users
echo     [3] Show Last Logon Times
echo     [4] Disable Guest Account
echo     [5] Lock Inactive Accounts
echo     [0] Back to Main Menu
echo.
set /p uaa="   Enter your choice [0-5]: "

if "%uaa%"=="0" goto MENU
if "%uaa%"=="1" (
    echo.
    echo    === ALL LOCAL USERS ===
    net user
    pause
    goto USER_ACCOUNT_AUDITOR
)
if "%uaa%"=="2" (
    echo.
    echo    === ADMINISTRATORS ===
    net localgroup Administrators
    pause
    goto USER_ACCOUNT_AUDITOR
)
if "%uaa%"=="3" (
    echo.
    echo    === LAST LOGON TIMES ===
    for /f "skip=4 tokens=1" %%u in ('net user') do (
        if not "%%u"=="The" (
            echo.
            echo    User: %%u
            net user "%%u" 2>nul | findstr /C:"Last logon"
        )
    )
    pause
    goto USER_ACCOUNT_AUDITOR
)
if "%uaa%"=="4" (
    echo.
    echo    [*] Disabling Guest account...
    net user Guest /active:no >nul 2>&1
    echo    [+] Guest account disabled!
    pause
    goto USER_ACCOUNT_AUDITOR
)
if "%uaa%"=="5" (
    echo.
    echo    [*] This will disable accounts that haven't logged in for 90+ days.
    set /p confirm="   Proceed? (Y/N): "
    if /i "!confirm!"=="Y" (
        echo    [!] Feature requires PowerShell 5.1+ and AD module for full functionality.
        echo    [*] For local accounts, manually review last logon dates above.
    )
    pause
    goto USER_ACCOUNT_AUDITOR
)
goto USER_ACCOUNT_AUDITOR

:: ============================================================================
:: WINDOWS FEATURE TOGGLE (NEW)
:: ============================================================================

:WINDOWS_FEATURE_TOGGLE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   WINDOWS FEATURE TOGGLE                                                  ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Hyper-V (Enable/Disable)
echo     [2] Windows Sandbox (Enable/Disable)
echo     [3] Telnet Client (Enable/Disable)
echo     [4] SMB 1.0 (Enable/Disable)
echo     [5] IIS (Enable/Disable)
echo     [6] .NET Framework 3.5 (Enable)
echo     [7] View All Optional Features
echo     [0] Back to Main Menu
echo.
set /p wft="   Enter your choice [0-7]: "

if "%wft%"=="0" goto MENU
if "%wft%"=="1" (
    echo.
    echo    [1] Enable Hyper-V
    echo    [2] Disable Hyper-V
    set /p hvchoice="   Choice: "
    if "!hvchoice!"=="1" (
        dism /online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart
    )
    if "!hvchoice!"=="2" (
        dism /online /Disable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart
    )
    pause
    goto WINDOWS_FEATURE_TOGGLE
)
if "%wft%"=="2" (
    echo.
    echo    [1] Enable Windows Sandbox
    echo    [2] Disable Windows Sandbox
    set /p sbchoice="   Choice: "
    if "!sbchoice!"=="1" (
        dism /online /Enable-Feature /FeatureName:Containers-DisposableClientVM /NoRestart
    )
    if "!sbchoice!"=="2" (
        dism /online /Disable-Feature /FeatureName:Containers-DisposableClientVM /NoRestart
    )
    pause
    goto WINDOWS_FEATURE_TOGGLE
)
if "%wft%"=="3" (
    echo.
    echo    [1] Enable Telnet
    echo    [2] Disable Telnet
    set /p telchoice="   Choice: "
    if "!telchoice!"=="1" (
        dism /online /Enable-Feature /FeatureName:TelnetClient /NoRestart
    )
    if "!telchoice!"=="2" (
        dism /online /Disable-Feature /FeatureName:TelnetClient /NoRestart
    )
    pause
    goto WINDOWS_FEATURE_TOGGLE
)
if "%wft%"=="4" (
    echo.
    echo    [1] Enable SMB 1.0 (Not Recommended)
    echo    [2] Disable SMB 1.0 (Recommended)
    set /p smbchoice="   Choice: "
    if "!smbchoice!"=="1" (
        dism /online /Enable-Feature /FeatureName:SMB1Protocol /NoRestart
    )
    if "!smbchoice!"=="2" (
        dism /online /Disable-Feature /FeatureName:SMB1Protocol /NoRestart
    )
    pause
    goto WINDOWS_FEATURE_TOGGLE
)
if "%wft%"=="5" (
    echo.
    echo    [1] Enable IIS
    echo    [2] Disable IIS
    set /p iischoice="   Choice: "
    if "!iischoice!"=="1" (
        dism /online /Enable-Feature /FeatureName:IIS-WebServerRole /NoRestart
    )
    if "!iischoice!"=="2" (
        dism /online /Disable-Feature /FeatureName:IIS-WebServerRole /NoRestart
    )
    pause
    goto WINDOWS_FEATURE_TOGGLE
)
if "%wft%"=="6" (
    echo.
    echo    [*] Enabling .NET Framework 3.5...
    dism /online /Enable-Feature /FeatureName:NetFx3 /NoRestart
    pause
    goto WINDOWS_FEATURE_TOGGLE
)
if "%wft%"=="7" (
    echo.
    echo    [*] Listing all optional features...
    dism /online /Get-Features | more
    pause
    goto WINDOWS_FEATURE_TOGGLE
)
goto WINDOWS_FEATURE_TOGGLE

:: ============================================================================
:: STARTUP APPS NUKER
:: ============================================================================

:STARTUP_NUKER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   STARTUP APPS NUKER                                                      ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] List ALL Startup Apps
echo     [2] Disable ALL Startup Apps (with backup)
echo     [3] Restore Startup Apps from Backup
echo     [0] Back to Main Menu
echo.
set /p snchoice="   Enter your choice [0-3]: "
if "%snchoice%"=="0" goto MENU
if "%snchoice%"=="1" goto LIST_STARTUP
if "%snchoice%"=="2" goto DISABLE_ALL_STARTUP
if "%snchoice%"=="3" goto RESTORE_STARTUP
goto STARTUP_NUKER

:LIST_STARTUP
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ALL STARTUP APPS                                                        ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    === HKCU\...\Run ===
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul | findstr /V "HKEY_"
echo.
echo    === HKLM\...\Run ===
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul | findstr /V "HKEY_"
echo.
echo    === HKLM\...\Run (Wow6432Node) ===
reg query "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" 2>nul | findstr /V "HKEY_"
echo.
echo    === Startup Folder (Current User) ===
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" /B 2>nul
if errorlevel 1 echo    (empty)
echo.
echo    === Startup Folder (All Users) ===
dir "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup" /B 2>nul
if errorlevel 1 echo    (empty)
echo.
echo    === Scheduled Tasks (Logon Triggers) ===
schtasks /query /fo LIST /v 2>nul | findstr /I "TaskName Logon" | findstr /V "\\Microsoft\\"
echo.
pause
goto STARTUP_NUKER

:DISABLE_ALL_STARTUP
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE ALL STARTUP APPS                                                ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [!] WARNING: This will disable ALL startup applications!
echo    [*] A backup will be created before making changes.
echo.
set /p confirm="   Are you SURE? Type 'YES' to confirm: "
if /i "%confirm%" NEQ "YES" goto STARTUP_NUKER

set "BACKUP_TIME=%DATE:~-4%%DATE:~-10,2%%DATE:~-7,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
set "BACKUP_TIME=!BACKUP_TIME: =0!"
set "STARTUP_BACKUP=%BACKUP_DIR%\startup_backup_!BACKUP_TIME!"
mkdir "!STARTUP_BACKUP!" >nul 2>&1

echo.
echo    [*] Creating backup...
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" "!STARTUP_BACKUP!\HKCU_Run.reg" /y >nul 2>&1
reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" "!STARTUP_BACKUP!\HKLM_Run.reg" /y >nul 2>&1
reg export "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" "!STARTUP_BACKUP!\HKLM_Run_Wow64.reg" /y >nul 2>&1
xcopy "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*" "!STARTUP_BACKUP!\UserStartup\" /E /I /Y >nul 2>&1
xcopy "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*" "!STARTUP_BACKUP!\AllUsersStartup\" /E /I /Y >nul 2>&1
schtasks /query /fo CSV > "!STARTUP_BACKUP!\scheduled_tasks.csv" 2>nul
echo    [+] Backup saved to: !STARTUP_BACKUP!

echo    [*] Disabling HKCU Run entries...
for /f "tokens=1,2,*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| findstr /V "HKEY_"') do (
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%a" /f >nul 2>&1
)

echo    [*] Disabling HKLM Run entries...
for /f "tokens=1,2,*" %%a in ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| findstr /V "HKEY_"') do (
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%a" /f >nul 2>&1
)

echo    [*] Disabling HKLM Wow6432Node Run entries...
for /f "tokens=1,2,*" %%a in ('reg query "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| findstr /V "HKEY_"') do (
    reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "%%a" /f >nul 2>&1
)

echo    [*] Moving startup folder items...
move "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*" "!STARTUP_BACKUP!\UserStartup_moved\" >nul 2>&1
move "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*" "!STARTUP_BACKUP!\AllUsersStartup_moved\" >nul 2>&1

echo    [*] Disabling logon scheduled tasks...
for /f "tokens=1 delims=," %%t in ('schtasks /query /fo CSV ^| findstr /V "TaskName" ^| findstr /V "\\Microsoft\\"') do (
    set "taskname=%%~t"
    schtasks /change /tn "!taskname!" /disable >nul 2>&1
)

echo.
echo    [+] All startup apps disabled!
echo    [+] Backup location: !STARTUP_BACKUP!
echo.
pause
goto STARTUP_NUKER

:RESTORE_STARTUP
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   RESTORE STARTUP APPS                                                    ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Available backups:
echo.
set "count=0"
for /d %%d in ("%BACKUP_DIR%\startup_backup_*") do (
    set /a count+=1
    echo     [!count!] %%~nxd
    set "backup_!count!=%%d"
)

if %count%==0 (
    echo    No backups found!
    echo.
    pause
    goto STARTUP_NUKER
)

echo.
set /p restnum="   Enter backup number to restore [0 to cancel]: "
if "%restnum%"=="0" goto STARTUP_NUKER

set "restore_path=!backup_%restnum%!"
if not defined restore_path (
    echo    [!] Invalid selection.
    pause
    goto STARTUP_NUKER
)

echo.
echo    [*] Restoring from: !restore_path!
if exist "!restore_path!\HKCU_Run.reg" reg import "!restore_path!\HKCU_Run.reg" >nul 2>&1
if exist "!restore_path!\HKLM_Run.reg" reg import "!restore_path!\HKLM_Run.reg" >nul 2>&1
if exist "!restore_path!\HKLM_Run_Wow64.reg" reg import "!restore_path!\HKLM_Run_Wow64.reg" >nul 2>&1
xcopy "!restore_path!\UserStartup\*" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /E /I /Y >nul 2>&1
xcopy "!restore_path!\AllUsersStartup\*" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /E /I /Y >nul 2>&1
echo.
echo    [+] Startup apps restored!
echo.
pause
goto STARTUP_NUKER

:: ============================================================================
:: INTERACTIVE DEBLOATER
:: ============================================================================

:INTERACTIVE_DEBLOATER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   INTERACTIVE DEBLOATER                                                   ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select items to debloat (you can enter multiple numbers):
echo.

if "!WIN_VER!"=="11" (
    echo     [1] Teams Personal
    echo     [2] Widgets
    echo     [3] Chat
    echo     [4] Copilot
    echo     [5] OneDrive
    echo     [6] Xbox Services
    echo     [7] Edge Background Tasks
    echo     [8] Microsoft Store Auto Updates
    echo     [9] Phone Link
    echo     [10] Gaming Services
) else (
    echo     [1] Cortana
    echo     [2] Microsoft Teams
    echo     [3] OneDrive
    echo     [4] Skype
    echo     [5] Xbox Services
    echo     [6] Your Phone
    echo     [7] Edge Background Tasks
    echo     [8] Adobe Updater
    echo     [9] Office ClickToRun
    echo     [10] Spotify AutoStart
)

echo.
echo     [0] Back to Main Menu
echo.
echo    Example input: 1 2 4 or 1,2,4,7
echo.
set /p debloat_input="   Enter your selections: "
if "%debloat_input%"=="0" goto MENU

:: Sanitize input - replace commas with spaces
set "debloat_input=!debloat_input:,= !"

echo.
echo    [*] Creating registry backup...
set "DEBLOAT_BACKUP=%BACKUP_DIR%\debloat_backup_%DATE:~-4%%DATE:~-10,2%%DATE:~-7,2%.reg"
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion" "!DEBLOAT_BACKUP!" /y >nul 2>&1

echo    [!] The following items will be disabled:
for %%n in (!debloat_input!) do (
    if "!WIN_VER!"=="11" (
        if %%n==1 echo        - Teams Personal
        if %%n==2 echo        - Widgets
        if %%n==3 echo        - Chat
        if %%n==4 echo        - Copilot
        if %%n==5 echo        - OneDrive
        if %%n==6 echo        - Xbox Services
        if %%n==7 echo        - Edge Background Tasks
        if %%n==8 echo        - Microsoft Store Auto Updates
        if %%n==9 echo        - Phone Link
        if %%n==10 echo        - Gaming Services
    ) else (
        if %%n==1 echo        - Cortana
        if %%n==2 echo        - Microsoft Teams
        if %%n==3 echo        - OneDrive
        if %%n==4 echo        - Skype
        if %%n==5 echo        - Xbox Services
        if %%n==6 echo        - Your Phone
        if %%n==7 echo        - Edge Background Tasks
        if %%n==8 echo        - Adobe Updater
        if %%n==9 echo        - Office ClickToRun
        if %%n==10 echo        - Spotify AutoStart
    )
)
echo.
set /p confirm="   Proceed with debloating? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU

echo.
for %%n in (!debloat_input!) do (
    if "!WIN_VER!"=="11" (
        if %%n==1 call :DEBLOAT_TEAMS_PERSONAL
        if %%n==2 call :DEBLOAT_WIDGETS
        if %%n==3 call :DEBLOAT_CHAT
        if %%n==4 call :DEBLOAT_COPILOT
        if %%n==5 call :DEBLOAT_ONEDRIVE
        if %%n==6 call :DEBLOAT_XBOX
        if %%n==7 call :DEBLOAT_EDGE_BG
        if %%n==8 call :DEBLOAT_STORE_AUTO
        if %%n==9 call :DEBLOAT_PHONELINK
        if %%n==10 call :DEBLOAT_GAMING_SERVICES
    ) else (
        if %%n==1 call :DEBLOAT_CORTANA
        if %%n==2 call :DEBLOAT_TEAMS
        if %%n==3 call :DEBLOAT_ONEDRIVE
        if %%n==4 call :DEBLOAT_SKYPE
        if %%n==5 call :DEBLOAT_XBOX
        if %%n==6 call :DEBLOAT_YOURPHONE
        if %%n==7 call :DEBLOAT_EDGE_BG
        if %%n==8 call :DEBLOAT_ADOBE
        if %%n==9 call :DEBLOAT_OFFICE_CTR
        if %%n==10 call :DEBLOAT_SPOTIFY
    )
)

echo.
echo    [+] Debloating complete!
echo    [+] Backup saved to: !DEBLOAT_BACKUP!
echo.
pause
goto MENU

:: Debloat subroutines
:DEBLOAT_CORTANA
echo    [*] Disabling Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul 2>&1
exit /b

:DEBLOAT_TEAMS
:DEBLOAT_TEAMS_PERSONAL
echo    [*] Disabling Microsoft Teams...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v ChatIcon /t REG_DWORD /d 3 /f >nul 2>&1
PowerShell -Command "Get-AppxPackage *Teams* | Remove-AppxPackage" >nul 2>&1
exit /b

:DEBLOAT_WIDGETS
echo    [*] Disabling Widgets...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f >nul 2>&1
PowerShell -Command "Get-AppxPackage *WebExperience* | Remove-AppxPackage" >nul 2>&1
exit /b

:DEBLOAT_CHAT
echo    [*] Disabling Chat...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v ChatIcon /t REG_DWORD /d 3 /f >nul 2>&1
exit /b

:DEBLOAT_COPILOT
echo    [*] Disabling Copilot...
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >nul 2>&1
exit /b

:DEBLOAT_ONEDRIVE
echo    [*] Disabling OneDrive...
taskkill /F /IM OneDrive.exe >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSync /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1
exit /b

:DEBLOAT_XBOX
echo    [*] Disabling Xbox Services...
sc config XboxGipSvc start= disabled >nul 2>&1
sc config XblAuthManager start= disabled >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
exit /b

:DEBLOAT_YOURPHONE
:DEBLOAT_PHONELINK
echo    [*] Disabling Phone Link/Your Phone...
PowerShell -Command "Get-AppxPackage *YourPhone* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage *PhoneLink* | Remove-AppxPackage" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableMmx /t REG_DWORD /d 0 /f >nul 2>&1
exit /b

:DEBLOAT_EDGE_BG
echo    [*] Disabling Edge Background Tasks...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v AutoUpdateCheckPeriodMinutes /t REG_DWORD /d 0 /f >nul 2>&1
exit /b

:DEBLOAT_STORE_AUTO
echo    [*] Disabling Store Auto Updates...
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v AutoDownload /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
exit /b

:DEBLOAT_GAMING_SERVICES
echo    [*] Disabling Gaming Services...
sc config GamingServices start= disabled >nul 2>&1
sc config GamingServicesNet start= disabled >nul 2>&1
exit /b

:DEBLOAT_SKYPE
echo    [*] Disabling Skype...
PowerShell -Command "Get-AppxPackage *Skype* | Remove-AppxPackage" >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Skype /f >nul 2>&1
exit /b

:DEBLOAT_ADOBE
echo    [*] Disabling Adobe Updater...
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "AdobeAAMUpdater-1.0" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "Adobe Creative Cloud" /f >nul 2>&1
schtasks /change /tn "Adobe Acrobat Update Task" /disable >nul 2>&1
schtasks /change /tn "AdobeGCInvoker-1.0" /disable >nul 2>&1
exit /b

:DEBLOAT_OFFICE_CTR
echo    [*] Disabling Office ClickToRun...
schtasks /change /tn "\Microsoft\Office\Office Automatic Updates 2.0" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Office\Office ClickToRun Service Monitor" /disable >nul 2>&1
exit /b

:DEBLOAT_SPOTIFY
echo    [*] Disabling Spotify AutoStart...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Spotify /f >nul 2>&1
exit /b

:: ============================================================================
:: DISABLE ADS & SUGGESTIONS
:: ============================================================================

:DISABLE_ADS
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE ADS ^& SUGGESTIONS                                               ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    This will disable:
echo     - Windows Consumer Features
echo     - Ads and Suggestions in Settings
echo     - Tips and tricks notifications
echo     - Bing Search in Start Menu
echo     - Feedback requests
echo     - App suggestions in Start Menu
echo.
set /p confirm="   Proceed? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU

echo.
echo    [*] Disabling Windows Consumer Features...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul

echo    [*] Disabling Ads in Settings...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f >nul

echo    [*] Disabling Tips and Suggestions...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul

echo    [*] Disabling Bing Search in Start Menu...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul

echo    [*] Disabling Feedback Requests...
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul

echo    [*] Disabling App Suggestions...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul

echo.
echo    [+] All ads and suggestions disabled!
echo.
pause
goto MENU

:: ============================================================================
:: EXTENDED CLEANING
:: ============================================================================

:EXTENDED_CLEANING
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   EXTENDED CLEANING                                                       ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Clear ALL Temp Files (User + System + Prefetch)
echo     [2] Clear Windows Update Cache
echo     [3] Clear Icon Cache
echo     [4] Clear Thumbnail Cache
echo     [5] Clear Font Cache
echo     [6] Clear Event Logs
echo     [7] Clear ALL Caches (All of the above)
echo     [0] Back to Main Menu
echo.
set /p ecchoice="   Enter your choice [0-7]: "

if "%ecchoice%"=="0" goto MENU
if "%ecchoice%"=="1" goto CLEAN_ALL_TEMP
if "%ecchoice%"=="2" goto CLEAN_UPDATE_CACHE_EXT
if "%ecchoice%"=="3" goto CLEAN_ICON_CACHE
if "%ecchoice%"=="4" goto CLEAN_THUMB_CACHE
if "%ecchoice%"=="5" goto CLEAN_FONT_CACHE
if "%ecchoice%"=="6" goto CLEAN_EVENT_LOGS
if "%ecchoice%"=="7" goto CLEAN_ALL_CACHES
goto EXTENDED_CLEANING

:CLEAN_ALL_TEMP
echo.
echo    [*] Cleaning all temp files...
del /q/f/s "%TEMP%\*" >nul 2>&1
del /q/f/s "%WINDIR%\Temp\*" >nul 2>&1
del /q/f/s "%WINDIR%\Prefetch\*" >nul 2>&1
del /q/f/s "%LOCALAPPDATA%\Temp\*" >nul 2>&1
del /q/f/s "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1
echo    [+] All temp files cleaned!
pause
goto EXTENDED_CLEANING

:CLEAN_UPDATE_CACHE_EXT
echo.
echo    [*] Stopping Windows Update services...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop cryptSvc >nul 2>&1
echo    [*] Cleaning Windows Update cache...
rd /s /q "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
mkdir "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
rd /s /q "%WINDIR%\System32\catroot2" >nul 2>&1
echo    [*] Restarting services...
net start cryptSvc >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo    [+] Windows Update cache cleaned!
pause
goto EXTENDED_CLEANING

:CLEAN_ICON_CACHE
echo.
echo    [*] Clearing icon cache...
taskkill /F /IM explorer.exe >nul 2>&1
del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1
start explorer.exe
echo    [+] Icon cache cleared! Explorer restarted.
pause
goto EXTENDED_CLEANING

:CLEAN_THUMB_CACHE
echo.
echo    [*] Clearing thumbnail cache...
taskkill /F /IM explorer.exe >nul 2>&1
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
start explorer.exe
echo    [+] Thumbnail cache cleared! Explorer restarted.
pause
goto EXTENDED_CLEANING

:CLEAN_FONT_CACHE
echo.
echo    [*] Clearing font cache...
net stop FontCache >nul 2>&1
net stop FontCache3.0.0.0 >nul 2>&1
del /f /q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat" >nul 2>&1
del /f /q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\FontCache-System\*.dat" >nul 2>&1
net start FontCache >nul 2>&1
net start FontCache3.0.0.0 >nul 2>&1
echo    [+] Font cache cleared!
pause
goto EXTENDED_CLEANING

:CLEAN_EVENT_LOGS
echo.
echo    [*] Clearing Windows Event Logs...
for /f "tokens=*" %%l in ('wevtutil el') do (
    wevtutil cl "%%l" >nul 2>&1
)
echo    [+] Event logs cleared!
pause
goto EXTENDED_CLEANING

:CLEAN_ALL_CACHES
echo.
echo    [*] Cleaning ALL caches...

echo    [1/6] Cleaning temp files...
del /q/f/s "%TEMP%\*" >nul 2>&1
del /q/f/s "%WINDIR%\Temp\*" >nul 2>&1
del /q/f/s "%WINDIR%\Prefetch\*" >nul 2>&1
del /q/f/s "%LOCALAPPDATA%\Temp\*" >nul 2>&1

echo    [2/6] Cleaning Windows Update cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
rd /s /q "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
mkdir "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

echo    [3/6] Clearing icon cache...
del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1

echo    [4/6] Clearing thumbnail cache...
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

echo    [5/6] Clearing font cache...
net stop FontCache >nul 2>&1
del /f /q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat" >nul 2>&1
net start FontCache >nul 2>&1

echo    [6/6] Clearing event logs...
for /f "tokens=*" %%l in ('wevtutil el') do (
    wevtutil cl "%%l" >nul 2>&1
)

taskkill /F /IM explorer.exe >nul 2>&1
start explorer.exe
echo.
echo    [+] ALL caches cleared! Explorer restarted.
pause
goto EXTENDED_CLEANING

:: ============================================================================
:: APPX BLOAT CONTROL
:: ============================================================================

:APPX_CONTROL
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   APPX BLOAT CONTROL                                                      ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] List All Installed AppX Packages
echo     [2] Remove Common Bloatware Apps
echo     [3] Remove Specific App by Name
echo     [4] Reinstall All Default Apps
echo     [0] Back to Main Menu
echo.
set /p appxchoice="   Enter your choice [0-4]: "

if "%appxchoice%"=="0" goto MENU
if "%appxchoice%"=="1" (
    echo.
    echo    [*] Listing all AppX packages...
    powershell -Command "Get-AppxPackage | Select-Object Name | Format-Table -AutoSize" | more
    pause
    goto APPX_CONTROL
)
if "%appxchoice%"=="2" (
    echo.
    echo    [*] Removing common bloatware...
    echo    [*] Xbox apps...
    powershell -Command "Get-AppxPackage *xbox* | Remove-AppxPackage" >nul 2>&1
    echo    [*] Solitaire...
    powershell -Command "Get-AppxPackage *Solitaire* | Remove-AppxPackage" >nul 2>&1
    echo    [*] Bing apps...
    powershell -Command "Get-AppxPackage *Bing* | Remove-AppxPackage" >nul 2>&1
    echo    [*] Zune apps...
    powershell -Command "Get-AppxPackage *Zune* | Remove-AppxPackage" >nul 2>&1
    echo    [*] 3D apps...
    powershell -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage" >nul 2>&1
    powershell -Command "Get-AppxPackage *3DViewer* | Remove-AppxPackage" >nul 2>&1
    echo    [*] Tips...
    powershell -Command "Get-AppxPackage *GetStarted* | Remove-AppxPackage" >nul 2>&1
    echo    [*] Feedback Hub...
    powershell -Command "Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage" >nul 2>&1
    echo.
    echo    [+] Common bloatware removed!
    pause
    goto APPX_CONTROL
)
if "%appxchoice%"=="3" (
    echo.
    set /p appname="   Enter app name (partial match): "
    echo    [*] Removing apps matching '!appname!'...
    powershell -Command "Get-AppxPackage *!appname!* | Remove-AppxPackage"
    echo    [+] Done!
    pause
    goto APPX_CONTROL
)
if "%appxchoice%"=="4" (
    echo.
    echo    [*] Reinstalling all default apps...
    echo    [!] This may take several minutes...
    powershell -Command "Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\" -ErrorAction SilentlyContinue}"
    echo    [+] Default apps reinstalled!
    pause
    goto APPX_CONTROL
)
goto APPX_CONTROL

:: ============================================================================
:: SERVICE MANAGER
:: ============================================================================

:SERVICE_MANAGER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   SERVICE MANAGER                                                         ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] List Running Services
echo     [2] List Stopped Services
echo     [3] Stop a Service
echo     [4] Start a Service
echo     [5] Set Service to Manual
echo     [6] Set Service to Disabled
echo     [7] Set Service to Automatic
echo     [0] Back to Main Menu
echo.
set /p srvchoice="   Enter your choice [0-7]: "

if "%srvchoice%"=="0" goto MENU
if "%srvchoice%"=="1" (
    echo.
    sc query state= running | findstr "SERVICE_NAME DISPLAY_NAME" | more
    pause
    goto SERVICE_MANAGER
)
if "%srvchoice%"=="2" (
    echo.
    sc query state= inactive | findstr "SERVICE_NAME DISPLAY_NAME" | more
    pause
    goto SERVICE_MANAGER
)
if "%srvchoice%"=="3" (
    echo.
    set /p srvname="   Enter service name to stop: "
    net stop "!srvname!"
    pause
    goto SERVICE_MANAGER
)
if "%srvchoice%"=="4" (
    echo.
    set /p srvname="   Enter service name to start: "
    net start "!srvname!"
    pause
    goto SERVICE_MANAGER
)
if "%srvchoice%"=="5" (
    echo.
    set /p srvname="   Enter service name to set to manual: "
    sc config "!srvname!" start= demand
    pause
    goto SERVICE_MANAGER
)
if "%srvchoice%"=="6" (
    echo.
    set /p srvname="   Enter service name to disable: "
    sc config "!srvname!" start= disabled
    pause
    goto SERVICE_MANAGER
)
if "%srvchoice%"=="7" (
    echo.
    set /p srvname="   Enter service name to set to automatic: "
    sc config "!srvname!" start= auto
    pause
    goto SERVICE_MANAGER
)
goto SERVICE_MANAGER

:: ============================================================================
:: APPEARANCE - DARK/LIGHT MODE
:: ============================================================================

:DARK_MODE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ENABLE DARK MODE                                                        ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Dark Mode...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul
echo.
echo    [+] Dark Mode enabled!
echo.
pause
goto MENU

:LIGHT_MODE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ENABLE LIGHT MODE                                                       ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Light Mode...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] Light Mode enabled!
echo.
pause
goto MENU

:TOGGLE_TRANSPARENCY
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   TOGGLE TRANSPARENCY                                                     ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select transparency option:
echo.
echo     [1] Enable Transparency Effects
echo     [2] Disable Transparency Effects
echo     [0] Back to Main Menu
echo.
set /p tchoice="   Enter your choice [0-2]: "
if "%tchoice%"=="0" goto MENU
if "%tchoice%"=="1" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul
    echo.
    echo    [+] Transparency enabled!
)
if "%tchoice%"=="2" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
    echo.
    echo    [+] Transparency disabled!
)
echo.
pause
goto MENU

:CONTEXT_MENU
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CONTEXT MENU STYLE                                                      ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select your preferred context menu style:
echo.
echo     [1] Classic Context Menu (Windows 10 style - full options visible)
echo     [2] New Context Menu (Windows 11 style - compact with "Show more options")
echo     [0] Back to Main Menu
echo.
set /p cmchoice="   Enter your choice [0-2]: "
if "%cmchoice%"=="0" goto MENU
if "%cmchoice%"=="1" (
    echo.
    echo    [*] Applying Classic Context Menu...
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] Classic Context Menu applied! Explorer restarted.
)
if "%cmchoice%"=="2" (
    echo.
    echo    [*] Applying New Context Menu...
    reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] New Context Menu applied! Explorer restarted.
)
echo.
pause
goto MENU

:TASKBAR_SIZE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   TASKBAR SIZE                                                            ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select your preferred taskbar size:
echo.
echo     [1] Small Taskbar   (Compact icons, minimal height)
echo     [2] Medium Taskbar  (Default Windows 11 size)
echo     [3] Large Taskbar   (Bigger icons, more height)
echo     [0] Back to Main Menu
echo.
set /p tschoice="   Enter your choice [0-3]: "
if "%tschoice%"=="0" goto MENU
if "%tschoice%"=="1" (
    echo.
    echo    [*] Applying Small Taskbar...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSi /t REG_DWORD /d 0 /f >nul
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] Small Taskbar applied!
)
if "%tschoice%"=="2" (
    echo.
    echo    [*] Applying Medium Taskbar...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSi /t REG_DWORD /d 1 /f >nul
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] Medium Taskbar applied!
)
if "%tschoice%"=="3" (
    echo.
    echo    [*] Applying Large Taskbar...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSi /t REG_DWORD /d 2 /f >nul
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] Large Taskbar applied!
)
echo.
pause
goto MENU

:TASKBAR_POSITION
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   TASKBAR POSITION                                                        ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select your preferred taskbar position:
echo.
echo     [1] Top of Screen
echo     [2] Bottom of Screen (Default)
echo     [0] Back to Main Menu
echo.
echo    NOTE: Left/Right positions may cause issues on Windows 11.
echo.
set /p tpchoice="   Enter your choice [0-2]: "
if "%tpchoice%"=="0" goto MENU
if "%tpchoice%"=="1" (
    echo.
    echo    [*] Moving Taskbar to Top...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings /t REG_BINARY /d 30000000feffffff0200000001000000300000002000000000000000c203000080070000e20300006000000001000000 /f >nul
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] Taskbar moved to top!
)
if "%tpchoice%"=="2" (
    echo.
    echo    [*] Moving Taskbar to Bottom...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings /t REG_BINARY /d 30000000feffffff0200000003000000300000002000000000000000c203000080070000e20300006000000001000000 /f >nul
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] Taskbar moved to bottom!
)
echo.
pause
goto MENU

:EXPLORER_STYLE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   EXPLORER STYLE                                                          ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select your preferred File Explorer style:
echo.
echo     [1] Classic Explorer (Windows 10 style with Ribbon)
echo     [2] New Explorer (Windows 11 style with Command Bar)
echo     [3] Open Explorer to "This PC" instead of Quick Access
echo     [4] Open Explorer to "Quick Access" (Default)
echo     [0] Back to Main Menu
echo.
echo    NOTE: Ribbon option removed in Windows 11 22H2+
echo.
set /p eschoice="   Enter your choice [0-4]: "
if "%eschoice%"=="0" goto MENU
if "%eschoice%"=="1" (
    echo.
    echo    [*] Applying Classic Explorer...
    reg add "HKCU\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32" /f /ve >nul
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] Classic Explorer applied!
)
if "%eschoice%"=="2" (
    echo.
    echo    [*] Applying New Explorer...
    reg delete "HKCU\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}" /f >nul 2>&1
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] New Explorer applied!
)
if "%eschoice%"=="3" (
    echo.
    echo    [*] Setting Explorer to open to This PC...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul
    echo    [+] Explorer will now open to This PC!
)
if "%eschoice%"=="4" (
    echo.
    echo    [*] Setting Explorer to open to Quick Access...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 2 /f >nul
    echo    [+] Explorer will now open to Quick Access!
)
echo.
pause
goto MENU

:CLEAN_TASKBAR
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CLEAN TASKBAR BLOAT                                                     ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    This will remove/hide the following from taskbar:
echo.
echo     - Meet Now icon
echo     - People bar
echo     - News and Interests / Widgets
echo     - Task View button
echo     - Search box (will keep search icon)
if "!WIN_VER!"=="11" (
    echo     - Chat icon
    echo     - Copilot button
)
echo.
set /p confirm="   Proceed? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU

echo.
echo    [*] Disabling Meet Now...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul

echo    [*] Disabling People bar...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f >nul

echo    [*] Disabling News and Interests/Widgets...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul

echo    [*] Hiding Task View button...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul

echo    [*] Minimizing Search box to icon...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul

if "!WIN_VER!"=="11" (
    echo    [*] Disabling Chat icon...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul
    echo    [*] Disabling Copilot button...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >nul
)

taskkill /F /IM explorer.exe >nul 2>&1
start explorer.exe
echo.
echo    [+] Taskbar cleaned! Explorer restarted.
echo.
pause
goto MENU

:DISABLE_WALLPAPER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE WALLPAPER CHANGE                                                ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Wallpaper Change...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallPaper /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallPaper /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] Wallpaper change disabled!
echo.
pause
goto MENU

:ENABLE_WALLPAPER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ENABLE WALLPAPER CHANGE                                                 ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Wallpaper Change...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallPaper /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallPaper /f >nul 2>&1
echo.
echo    [+] Wallpaper change enabled!
echo.
pause
goto MENU

:: ============================================================================
:: SYSTEM CLEANUP
:: ============================================================================

:CLEAN_TEMP
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CLEAN TEMP FILES                                                        ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Cleaning User Temp folder...
del /q/f/s "%TEMP%\*" >nul 2>&1
echo    [*] Cleaning Windows Temp folder...
del /q/f/s "%WINDIR%\Temp\*" >nul 2>&1
echo    [*] Cleaning Prefetch folder...
del /q/f/s "%WINDIR%\Prefetch\*" >nul 2>&1
echo    [*] Cleaning Recent files...
del /q/f/s "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1
echo    [*] Cleaning thumbnail cache...
del /q/f/s "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo.
echo    [+] Temporary files cleaned successfully!
echo.
pause
goto MENU

:CLEAN_UPDATE_CACHE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CLEAN WINDOWS UPDATE CACHE                                              ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [!] WARNING: This will stop Windows Update service temporarily.
echo.
set /p confirm="   Are you sure? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU
echo.
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop cryptSvc >nul 2>&1
echo    [*] Deleting SoftwareDistribution folder contents...
rd /s /q "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
mkdir "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
echo    [*] Deleting catroot2 folder contents...
rd /s /q "%WINDIR%\System32\catroot2" >nul 2>&1
net start cryptSvc >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo.
echo    [+] Windows Update cache cleaned!
echo.
pause
goto MENU

:EMPTY_RECYCLE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   EMPTY RECYCLE BIN                                                       ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Emptying Recycle Bin...
PowerShell.exe -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
echo.
echo    [+] Recycle Bin emptied successfully!
echo.
pause
goto MENU

:DISK_CLEANUP
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISK CLEANUP                                                            ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Quick Disk Cleanup (Standard)
echo     [2] Advanced Disk Cleanup (Admin - includes system files)
echo     [3] Configure Cleanup Settings First
echo     [0] Back to Main Menu
echo.
set /p dcchoice="   Enter your choice [0-3]: "
if "%dcchoice%"=="0" goto MENU
if "%dcchoice%"=="1" (
    echo.
    echo    [*] Running Quick Disk Cleanup...
    cleanmgr /sagerun:1
)
if "%dcchoice%"=="2" (
    echo.
    echo    [*] Running Advanced Disk Cleanup...
    cleanmgr /d C: /VERYLOWDISK
)
if "%dcchoice%"=="3" (
    echo.
    echo    [*] Opening Cleanup Configuration...
    cleanmgr /sageset:1
)
echo.
pause
goto MENU

:CLEAR_DNS
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CLEAR DNS CACHE                                                         ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Clearing DNS Cache...
ipconfig /flushdns
echo.
echo    [+] DNS cache cleared!
echo.
pause
goto MENU

:CLEAR_BROWSER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CLEAR BROWSER CACHE                                                     ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select which browser cache to clear:
echo.
echo     [1] Microsoft Edge
echo     [2] Google Chrome
echo     [3] Mozilla Firefox
echo     [4] All Browsers
echo     [0] Back to Main Menu
echo.
set /p bcchoice="   Enter your choice [0-4]: "
if "%bcchoice%"=="0" goto MENU
if "%bcchoice%"=="1" (
    echo.
    echo    [*] Clearing Microsoft Edge cache...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\GPUCache" >nul 2>&1
    echo    [+] Edge cache cleared!
)
if "%bcchoice%"=="2" (
    echo.
    echo    [*] Clearing Google Chrome cache...
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\GPUCache" >nul 2>&1
    echo    [+] Chrome cache cleared!
)
if "%bcchoice%"=="3" (
    echo.
    echo    [*] Clearing Mozilla Firefox cache...
    for /d %%p in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do (
        rd /s /q "%%p\cache2" >nul 2>&1
    )
    echo    [+] Firefox cache cleared!
)
if "%bcchoice%"=="4" (
    echo.
    echo    [*] Clearing all browser caches...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache" >nul 2>&1
    for /d %%p in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do (
        rd /s /q "%%p\cache2" >nul 2>&1
    )
    echo    [+] All browser caches cleared!
)
echo.
pause
goto MENU

:CLEAN_EXPLORER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CLEAN EXPLORER FOLDERS                                                  ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    This will clean:
echo     - Recent Documents
echo     - Temporary Internet Files
echo     - Downloaded Program Files
echo.
set /p confirm="   Proceed? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU

echo.
echo    [*] Cleaning Recent Documents...
del /q/f "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1
echo    [*] Cleaning Temporary Internet Files...
rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\INetCache" >nul 2>&1
echo    [*] Cleaning Downloaded Program Files...
rd /s /q "%WINDIR%\Downloaded Program Files" >nul 2>&1
echo.
echo    [+] Explorer folders cleaned!
echo.
pause
goto MENU

:CLEAR_SPOTLIGHT
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CLEAR SPOTLIGHT/LOCKSCREEN ADS                                          ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Spotlight and lockscreen ads...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnLockScreen /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] Spotlight and lockscreen ads disabled!
echo.
pause
goto MENU

:REMOVE_BLOATWARE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   REMOVE BLOATWARE APPS                                                   ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    This will remove common bloatware apps:
echo     - Xbox apps (Gaming Bar will remain)
echo     - Solitaire Collection
echo     - Feedback Hub
echo     - Get Help
echo     - Tips
echo     - Mixed Reality
echo     - 3D Viewer
echo.
set /p confirm="   Proceed? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU

echo.
echo    [*] Removing bloatware...
powershell -Command "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.MixedReality* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage" >nul 2>&1
echo.
echo    [+] Bloatware removed!
echo.
pause
goto MENU

:REMOVE_PCHEALTHCHECK
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   REMOVE PC HEALTH CHECK                                                  ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Removing PC Health Check...
wmic product where "name like '%%PC Health Check%%'" call uninstall /nointeractive >nul 2>&1
powershell -Command "Get-AppxPackage *PCHealthCheck* | Remove-AppxPackage" >nul 2>&1
echo.
echo    [+] PC Health Check removed (if it was installed)!
echo.
pause
goto MENU

:: ============================================================================
:: SERVICES CONTROL
:: ============================================================================

:DISABLE_UPDATE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE WINDOWS UPDATE                                                  ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [!] WARNING: This will disable Windows Update service.
echo    [!] Your system will NOT receive security updates!
echo.
set /p confirm="   Are you sure? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU
echo.
echo    [*] Disabling Windows Update...
sc config wuauserv start= disabled >nul 2>&1
net stop wuauserv >nul 2>&1
sc config bits start= disabled >nul 2>&1
net stop bits >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] Windows Update disabled!
echo.
pause
goto MENU

:ENABLE_UPDATE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ENABLE WINDOWS UPDATE                                                   ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Windows Update...
sc config wuauserv start= demand >nul 2>&1
sc config bits start= demand >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /f >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo.
echo    [+] Windows Update enabled!
echo.
pause
goto MENU

:DISABLE_TELEMETRY
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE TELEMETRY                                                       ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Telemetry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
sc config DiagTrack start= disabled >nul 2>&1
net stop DiagTrack >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
net stop dmwappushservice >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
echo.
echo    [+] Telemetry disabled!
echo.
pause
goto MENU

:DISABLE_CORTANA
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE CORTANA                                                         ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaAboveLock /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CanCortanaBeEnabled /t REG_DWORD /d 0 /f >nul
echo.
echo    [+] Cortana disabled!
echo.
pause
goto MENU

:DISABLE_BACKGROUND
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE BACKGROUND APPS                                                 ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Background Apps...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f >nul
echo.
echo    [+] Background apps disabled!
echo.
pause
goto MENU

:DISABLE_STORE_AUTO
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE STORE AUTO-INSTALL                                              ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Store Auto-Install and Suggestions...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f >nul
echo.
echo    [+] Store auto-install and suggestions disabled!
echo.
pause
goto MENU

:DISABLE_DEFENDER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE WINDOWS DEFENDER                                                ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [!] EXTREME WARNING: This will disable Windows Defender protection!
echo    [!] Your PC will be vulnerable to malware and viruses.
echo    [!] Only do this if you have alternative antivirus software.
echo.
set /p confirm="   Type 'DISABLE' to confirm: "
if "%confirm%" NEQ "DISABLE" goto MENU

echo.
echo    [*] Disabling Windows Defender policies...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] Windows Defender policies set to disable!
echo    [!] Note: Full effect may require restart and disabling Tamper Protection manually.
echo.
pause
goto MENU

:ENABLE_DEFENDER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ENABLE WINDOWS DEFENDER                                                 ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Windows Defender...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRealtimeMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1
sc config WinDefend start= auto >nul 2>&1
net start WinDefend >nul 2>&1
echo.
echo    [+] Windows Defender re-enabled! Restart recommended.
echo.
pause
goto MENU

:DISABLE_EDGE_UPDATE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE EDGE AUTO-UPDATES                                               ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Microsoft Edge Auto-Updates...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SyncDisabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BrowserSignin /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ComponentUpdatesEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v AutoUpdateCheckPeriodMinutes /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v UpdateDefault /t REG_DWORD /d 0 /f >nul
echo.
echo    [+] Edge auto-updates disabled!
echo.
pause
goto MENU

:DISABLE_DRIVER_AUTO
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE DRIVER AUTO-INSTALL                                             ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Automatic Driver Installation...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] Automatic driver installation disabled!
echo.
pause
goto MENU

:: ============================================================================
:: NETWORK TOOLS
:: ============================================================================

:FLUSH_DNS
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   FLUSH DNS                                                               ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Flushing DNS Cache...
ipconfig /flushdns
echo.
echo    [+] DNS cache flushed!
echo.
pause
goto MENU

:RESET_NETWORK
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   RESET NETWORK STACK                                                     ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select reset level:
echo.
echo     [1] Quick Reset (Flush DNS + Renew IP)
echo     [2] Full Reset (Winsock + TCP/IP + DNS + Firewall)
echo     [0] Back to Main Menu
echo.
echo    [!] Full reset may disconnect you temporarily.
echo.
set /p rnchoice="   Enter your choice [0-2]: "
if "%rnchoice%"=="0" goto MENU
if "%rnchoice%"=="1" (
    echo.
    echo    [*] Flushing DNS...
    ipconfig /flushdns
    echo    [*] Releasing IP...
    ipconfig /release
    echo    [*] Renewing IP...
    ipconfig /renew
    echo.
    echo    [+] Quick reset complete!
)
if "%rnchoice%"=="2" (
    echo.
    echo    [*] Performing full network reset...
    echo    [*] Flushing DNS...
    ipconfig /flushdns
    echo    [*] Releasing IP...
    ipconfig /release
    echo    [*] Resetting Winsock...
    netsh winsock reset
    echo    [*] Resetting TCP/IP...
    netsh int ip reset
    echo    [*] Resetting Firewall...
    netsh advfirewall reset
    echo    [*] Renewing IP...
    ipconfig /renew
    echo.
    echo    [+] Full reset complete! Restart recommended.
)
echo.
pause
goto MENU

:RENEW_IP
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   RELEASE/RENEW IP ADDRESS                                                ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Releasing IP...
ipconfig /release
echo    [*] Renewing IP...
ipconfig /renew
echo.
echo    [+] IP address renewed!
echo.
pause
goto MENU

:NETWORK_INFO
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   NETWORK INFORMATION                                                     ^|
echo   ^|___________________________________________________________________________^|
echo.
ipconfig /all
echo.
pause
goto MENU

:PING_TEST
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   PING TEST                                                               ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select target:
echo.
echo     [1] Google DNS (8.8.8.8)
echo     [2] Cloudflare DNS (1.1.1.1)
echo     [3] Custom Address
echo     [0] Back to Main Menu
echo.
set /p ptchoice="   Enter your choice [0-3]: "
if "%ptchoice%"=="0" goto MENU
if "%ptchoice%"=="1" (
    echo.
    ping 8.8.8.8 -n 10
)
if "%ptchoice%"=="2" (
    echo.
    ping 1.1.1.1 -n 10
)
if "%ptchoice%"=="3" (
    set /p customip="   Enter IP or hostname: "
    echo.
    ping !customip! -n 10
)
echo.
pause
goto MENU

:TRACEROUTE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   TRACEROUTE                                                              ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Trace to Google
echo     [2] Trace to Cloudflare
echo     [3] Custom Trace
echo     [0] Back to Main Menu
echo.
set /p trchoice="   Enter your choice [0-3]: "
if "%trchoice%"=="0" goto MENU
if "%trchoice%"=="1" tracert google.com
if "%trchoice%"=="2" tracert 1.1.1.1
if "%trchoice%"=="3" (
    set /p customtrace="   Enter IP or hostname: "
    tracert !customtrace!
)
echo.
pause
goto MENU

:WIFI_PASSWORDS
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   SAVED WIFI PASSWORDS                                                    ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Retrieving saved WiFi networks...
echo.

:: Create temp file for profiles
set "TEMP_PROFILES=%TEMP%\wifi_profiles.txt"
netsh wlan show profiles > "%TEMP_PROFILES%" 2>nul

:: Check if WLAN service is available
findstr /C:"is not running" "%TEMP_PROFILES%" >nul 2>&1
if !errorlevel!==0 (
    echo    [!] WLAN AutoConfig service is not running.
    echo    [*] Attempting to start the service...
    net start WlanSvc >nul 2>&1
    timeout /t 2 >nul
    netsh wlan show profiles > "%TEMP_PROFILES%" 2>nul
)

:: Check for no profiles
findstr /C:"There is no wireless interface" "%TEMP_PROFILES%" >nul 2>&1
if !errorlevel!==0 (
    echo    [!] No wireless interface found on this computer.
    del "%TEMP_PROFILES%" >nul 2>&1
    echo.
    pause
    goto MENU
)

:: Extract and show passwords
set "found=0"
for /f "tokens=2 delims=:" %%a in ('findstr /C:"All User Profile" "%TEMP_PROFILES%" 2^>nul') do (
    set "ssid=%%a"
    set "ssid=!ssid:~1!"
    if not "!ssid!"=="" (
        set "found=1"
        echo    --------------------------------------------
        echo    Network: !ssid!
        for /f "tokens=2 delims=:" %%b in ('netsh wlan show profile name^="!ssid!" key^=clear 2^>nul ^| findstr /C:"Key Content"') do (
            echo    Password:%%b
        )
        echo.
    )
)

if "!found!"=="0" (
    echo    [!] No saved WiFi networks found.
)

del "%TEMP_PROFILES%" >nul 2>&1
echo.
pause
goto MENU

:RESET_HOSTS
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   RESET HOSTS FILE                                                        ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [!] WARNING: This will reset your hosts file to Windows default.
echo.
set /p confirm="   Are you sure? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU
echo.
echo    [*] Backing up current hosts file...
copy /Y "%WINDIR%\System32\drivers\etc\hosts" "%BACKUP_DIR%\hosts_backup_%DATE:~-4%%DATE:~-10,2%%DATE:~-7,2%.txt" >nul 2>&1
echo    [*] Resetting hosts file...
echo # Copyright (c) 1993-2009 Microsoft Corp.> "%WINDIR%\System32\drivers\etc\hosts"
echo #>> "%WINDIR%\System32\drivers\etc\hosts"
echo # This is a sample HOSTS file used by Microsoft TCP/IP for Windows.>> "%WINDIR%\System32\drivers\etc\hosts"
echo #>> "%WINDIR%\System32\drivers\etc\hosts"
echo # localhost name resolution is handled within DNS itself.>> "%WINDIR%\System32\drivers\etc\hosts"
echo #    127.0.0.1       localhost>> "%WINDIR%\System32\drivers\etc\hosts"
echo #    ::1             localhost>> "%WINDIR%\System32\drivers\etc\hosts"
echo.
echo    [+] Hosts file reset to default!
echo.
pause
goto MENU

:: ============================================================================
:: PERFORMANCE TWEAKS
:: ============================================================================

:POWER_PLAN
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   POWER PLAN                                                              ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select power plan:
echo.
echo     [1] Power Saver (Maximize battery life)
echo     [2] Balanced (Default - Balance performance and power)
echo     [3] High Performance (Maximize performance)
echo     [4] Ultimate Performance (Windows 10/11 Pro only)
echo     [0] Back to Main Menu
echo.
powercfg /list
echo.
set /p ppchoice="   Enter your choice [0-4]: "
if "%ppchoice%"=="0" goto MENU
if "%ppchoice%"=="1" (
    echo.
    echo    [*] Activating Power Saver plan...
    powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a
    echo    [+] Power Saver activated!
)
if "%ppchoice%"=="2" (
    echo.
    echo    [*] Activating Balanced plan...
    powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
    echo    [+] Balanced plan activated!
)
if "%ppchoice%"=="3" (
    echo.
    echo    [*] Activating High Performance plan...
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    echo    [+] High Performance activated!
)
if "%ppchoice%"=="4" (
    echo.
    echo    [*] Creating and activating Ultimate Performance plan...
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
    for /f "tokens=4" %%a in ('powercfg /list ^| findstr "Ultimate"') do (
        powercfg /setactive %%a
    )
    echo    [+] Ultimate Performance activated (if supported)!
)
echo.
pause
goto MENU

:DISABLE_VISUAL
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE VISUAL EFFECTS                                                  ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Visual Effects for better performance...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul
echo.
echo    [+] Visual effects disabled for better performance!
echo.
pause
goto MENU

:ENABLE_VISUAL
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ENABLE VISUAL EFFECTS                                                   ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Visual Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9E3E078012000000 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] Visual effects enabled!
echo.
pause
goto MENU

:DISABLE_GAMEBAR
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE GAME BAR/DVR                                                    ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Game Bar and DVR...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f >nul
echo.
echo    [+] Game Bar and DVR disabled!
echo.
pause
goto MENU

:DISABLE_INDEXING
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE SEARCH INDEXING                                                 ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Windows Search Indexing...
sc config WSearch start= disabled >nul 2>&1
net stop WSearch >nul 2>&1
echo.
echo    [+] Search Indexing disabled!
echo    [!] Note: This will slow down file searches but improve disk performance.
echo.
pause
goto MENU

:ENABLE_INDEXING
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ENABLE SEARCH INDEXING                                                  ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Windows Search Indexing...
sc config WSearch start= auto >nul 2>&1
net start WSearch >nul 2>&1
echo.
echo    [+] Search Indexing enabled!
echo.
pause
goto MENU

:DISABLE_HIBERNATE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE HIBERNATION                                                     ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Hibernation...
powercfg /hibernate off
echo.
echo    [+] Hibernation disabled! This frees up disk space equal to your RAM.
echo.
pause
goto MENU

:ENABLE_HIBERNATE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   ENABLE HIBERNATION                                                      ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Hibernation...
powercfg /hibernate on
echo.
echo    [+] Hibernation enabled!
echo.
pause
goto MENU

:: ============================================================================
:: REPAIR TOOLS
:: ============================================================================

:RUN_SFC
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   SYSTEM FILE CHECKER (SFC)                                               ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Running System File Checker...
echo    [*] This may take several minutes...
echo.
sfc /scannow
echo.
echo    [+] SFC scan complete!
echo.
pause
goto MENU

:RUN_DISM
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISM HEALTH RESTORE                                                     ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Check Health (Quick scan)
echo     [2] Scan Health (Detailed scan)
echo     [3] Restore Health (Repair - requires internet)
echo     [4] Run All Three (Recommended)
echo     [0] Back to Main Menu
echo.
set /p dismchoice="   Enter your choice [0-4]: "
if "%dismchoice%"=="0" goto MENU
if "%dismchoice%"=="1" (
    echo.
    echo    [*] Checking health...
    DISM /Online /Cleanup-Image /CheckHealth
)
if "%dismchoice%"=="2" (
    echo.
    echo    [*] Scanning health...
    DISM /Online /Cleanup-Image /ScanHealth
)
if "%dismchoice%"=="3" (
    echo.
    echo    [*] Restoring health...
    DISM /Online /Cleanup-Image /RestoreHealth
)
if "%dismchoice%"=="4" (
    echo.
    echo    [*] Running all DISM checks...
    DISM /Online /Cleanup-Image /CheckHealth
    DISM /Online /Cleanup-Image /ScanHealth
    DISM /Online /Cleanup-Image /RestoreHealth
)
echo.
echo    [+] DISM operation complete!
echo.
pause
goto MENU

:CHECK_DISK
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CHECK DISK FOR ERRORS                                                   ^|
echo   ^|___________________________________________________________________________^|
echo.
echo     [1] Quick Scan (No restart required)
echo     [2] Full Check (Requires restart, checks for bad sectors)
echo     [0] Back to Main Menu
echo.
set /p cdchoice="   Enter your choice [0-2]: "
if "%cdchoice%"=="0" goto MENU
if "%cdchoice%"=="1" (
    echo.
    echo    [*] Running quick disk scan...
    chkdsk C: /scan
)
if "%cdchoice%"=="2" (
    echo.
    echo    [*] Scheduling full disk check...
    echo    [!] Your computer will restart to complete the check.
    set /p confirm="   Schedule check and restart? (Y/N): "
    if /i "!confirm!"=="Y" (
        chkdsk C: /F /R /X
    )
)
echo.
pause
goto MENU

:RESTART_EXPLORER
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   RESTART EXPLORER                                                        ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Restarting Windows Explorer...
taskkill /F /IM explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe
echo.
echo    [+] Explorer restarted!
echo.
pause
goto MENU

:RESTART_AUDIO
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   RESTART AUDIO SERVICE                                                   ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Restarting Audio Services...
net stop Audiosrv >nul 2>&1
net stop AudioEndpointBuilder >nul 2>&1
timeout /t 2 >nul
net start AudioEndpointBuilder >nul 2>&1
net start Audiosrv >nul 2>&1
echo.
echo    [+] Audio services restarted!
echo.
pause
goto MENU

:RESTART_PRINT
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   RESTART PRINT SPOOLER                                                   ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Restarting Print Spooler Service...
net stop spooler >nul 2>&1
del /Q /F /S "%systemroot%\System32\spool\PRINTERS\*.*" >nul 2>&1
net start spooler >nul 2>&1
echo.
echo    [+] Print Spooler restarted and queue cleared!
echo.
pause
goto MENU

:FIX_STARTMENU
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   FIX START MENU                                                          ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Re-registering Start Menu components...
PowerShell -Command "Get-AppxPackage Microsoft.Windows.ShellExperienceHost | foreach {Add-AppxPackage -register \"$($_.InstallLocation)\appxmanifest.xml\" -DisableDevelopmentMode}" >nul 2>&1
PowerShell -Command "Get-AppxPackage Microsoft.Windows.StartMenuExperienceHost | foreach {Add-AppxPackage -register \"$($_.InstallLocation)\appxmanifest.xml\" -DisableDevelopmentMode}" >nul 2>&1
taskkill /F /IM explorer.exe >nul 2>&1
start explorer.exe
echo.
echo    [+] Start Menu repair attempted! Explorer restarted.
echo.
pause
goto MENU

:REPAIR_STORE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   REPAIR WINDOWS STORE                                                    ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Resetting Windows Store cache...
wsreset.exe
echo    [*] Re-registering Windows Store...
PowerShell -Command "Get-AppxPackage *WindowsStore* -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\"}" >nul 2>&1
echo.
echo    [+] Windows Store repair attempted!
echo.
pause
goto MENU

:: ============================================================================
:: SYSTEM INFO
:: ============================================================================

:SYSTEM_INFO
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   SYSTEM INFORMATION                                                      ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    COMPUTER NAME: %COMPUTERNAME%
echo    USERNAME: %USERNAME%
echo    DOMAIN: %USERDOMAIN%
echo    WINDOWS VERSION: !WIN_VER!
echo.
echo    OS:
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"
echo.
echo    PROCESSOR:
wmic cpu get name | more +1
echo.
echo    MEMORY:
wmic computersystem get totalphysicalmemory | more +1
echo.
echo    GPU:
wmic path win32_videocontroller get name | more +1
echo.
echo    UPTIME:
for /f "tokens=2 delims==" %%a in ('wmic os get lastbootuptime /value') do set boottime=%%a
echo    Last Boot: !boottime:~0,4!-!boottime:~4,2!-!boottime:~6,2! !boottime:~8,2!:!boottime:~10,2!
echo.
pause
goto MENU

:INSTALLED_PROGRAMS
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   INSTALLED PROGRAMS                                                      ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Loading installed programs (This may take a moment)...
echo.
wmic product get name,version | more
pause
goto MENU

:RUNNING_PROCESSES
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   RUNNING PROCESSES                                                       ^|
echo   ^|___________________________________________________________________________^|
echo.
tasklist /FO TABLE | more
pause
goto MENU

:DISK_USAGE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISK USAGE                                                              ^|
echo   ^|___________________________________________________________________________^|
echo.
wmic logicaldisk get deviceid, volumename, filesystem, size, freespace
echo.
pause
goto MENU

:STARTUP_PROGRAMS
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   STARTUP PROGRAMS                                                        ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    === Current User Registry ===
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
echo.
echo    === All Users Registry ===
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
echo.
echo    === Startup Folder (Current User) ===
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" /B 2>nul
echo.
echo    === Startup Folder (All Users) ===
dir "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup" /B 2>nul
echo.
pause
goto MENU

:EXPORT_REPORT
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   EXPORT FULL SYSTEM REPORT                                               ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Exporting Full System Report...
echo    [*] This will take a few minutes...
echo.
set "REPORT=%USERPROFILE%\Desktop\SystemReport_%DATE:~-4,4%%DATE:~-10,2%%DATE:~-7,2%_%TIME:~0,2%%TIME:~3,2%.txt"
set "REPORT=!REPORT: =0!"
echo ============================================================================ > "!REPORT!"
echo  SYCHIC SYSTEM TOOLKIT - FULL SYSTEM REPORT >> "!REPORT!"
echo  Generated by @09sychic >> "!REPORT!"
echo  Date: %DATE% %TIME% >> "!REPORT!"
echo ============================================================================ >> "!REPORT!"
echo. >> "!REPORT!"
echo ============================================ >> "!REPORT!"
echo SYSTEM INFORMATION >> "!REPORT!"
echo ============================================ >> "!REPORT!"
systeminfo >> "!REPORT!"
echo. >> "!REPORT!"
echo ============================================ >> "!REPORT!"
echo NETWORK CONFIGURATION >> "!REPORT!"
echo ============================================ >> "!REPORT!"
ipconfig /all >> "!REPORT!"
echo. >> "!REPORT!"
echo ============================================ >> "!REPORT!"
echo DISK INFORMATION >> "!REPORT!"
echo ============================================ >> "!REPORT!"
wmic logicaldisk get deviceid, volumename, filesystem, size, freespace >> "!REPORT!"
echo. >> "!REPORT!"
echo ============================================ >> "!REPORT!"
echo RUNNING PROCESSES >> "!REPORT!"
echo ============================================ >> "!REPORT!"
tasklist >> "!REPORT!"
echo. >> "!REPORT!"
echo ============================================ >> "!REPORT!"
echo INSTALLED PROGRAMS >> "!REPORT!"
echo ============================================ >> "!REPORT!"
wmic product get name,version >> "!REPORT!" 2>nul
echo. >> "!REPORT!"
echo ============================================ >> "!REPORT!"
echo STARTUP PROGRAMS >> "!REPORT!"
echo ============================================ >> "!REPORT!"
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" >> "!REPORT!" 2>nul
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" >> "!REPORT!" 2>nul
echo.
echo    [+] Report saved to: !REPORT!
start notepad "!REPORT!"
pause
goto MENU

:: ============================================================================
:: RUN ALL SAFE TWEAKS
:: ============================================================================

:RUN_ALL_SAFE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   RUN ALL SAFE TWEAKS                                                     ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    This will apply the following SAFE optimizations:
echo.
echo     - Enable Dark Mode
echo     - Clean Temp Files  
echo     - Clear DNS Cache
echo     - Empty Recycle Bin
echo     - Disable Background Apps
echo     - Disable Store Auto-Install
echo     - Disable Cortana
echo     - Disable Xbox Game Bar
echo     - Disable Telemetry
echo     - Clean Taskbar Bloat
echo     - Disable Lockscreen Ads
echo     - Enable High Performance Power Plan
echo.
set /p confirm="   Proceed with all safe tweaks? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU

echo.
echo    [01/12] Enabling Dark Mode...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul

echo    [02/12] Cleaning Temp Files...
del /q/f/s "%TEMP%\*" >nul 2>&1
del /q/f/s "%WINDIR%\Temp\*" >nul 2>&1
del /q/f/s "%WINDIR%\Prefetch\*" >nul 2>&1

echo    [03/12] Flushing DNS...
ipconfig /flushdns >nul

echo    [04/12] Emptying Recycle Bin...
PowerShell.exe -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1

echo    [05/12] Disabling Background Apps...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul

echo    [06/12] Disabling Store Auto-Install...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f >nul

echo    [07/12] Disabling Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 0 /f >nul

echo    [08/12] Disabling Game Bar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul

echo    [09/12] Disabling Telemetry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

echo    [10/12] Cleaning Taskbar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul

echo    [11/12] Disabling Lockscreen Ads...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul

echo    [12/12] Enabling High Performance Power Plan...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1

echo.
echo    [+] All safe tweaks applied successfully!
echo    [*] Restarting Explorer to apply changes...
taskkill /F /IM explorer.exe >nul 2>&1
start explorer.exe
echo.
echo    [+] Done! Some changes may require a full restart.
echo.
pause
goto MENU

:: ============================================================================
:: EXIT
:: ============================================================================

:EXIT
cls
color 0A
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|                                                                           ^|
echo   ^|        Thank you for using Sychic System Toolkit v3.0!                    ^|
echo   ^|                                                                           ^|
echo   ^|                   Created with care by @09sychic                          ^|
echo   ^|                                                                           ^|
echo   ^|              Stay safe and keep your system optimized!                    ^|
echo   ^|                                                                           ^|
echo   ^|___________________________________________________________________________^|
echo.
timeout /t 3 >nul
exit
