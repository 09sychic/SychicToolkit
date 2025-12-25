@echo off
setlocal EnableDelayedExpansion
:: ============================================================================
:: SYCHIC SYSTEM TOOLKIT v2.0
:: Author: @09sychic
:: A powerful all-in-one Windows system utility toolkit
:: No external scripts. No downloads. Pure batch power.
:: ============================================================================

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

:: Set console properties
mode con: cols=120 lines=50
title Sychic System Toolkit v2.0 - @09sychic

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
echo   ^|         S Y S T E M   T O O L K I T   v 2 . 0   -   @09sychic             ^|
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
echo    [LAUNCHERS]                              [SYSTEM INFO]
echo    ------------------------------------     ------------------------------------
echo     60. Open Device Manager                  66. Show System Information
echo     61. Open Control Panel                   67. Show Installed Programs
echo     62. Open Services                        68. Show Running Processes
echo     63. Open Task Manager                    69. Show Disk Usage
echo     64. Open Registry Editor                 70. Show Startup Programs
echo     65. Open Windows Terminal                71. Export Full System Report
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
if "%choice%"=="60" goto DEVICE_MANAGER
if "%choice%"=="61" goto CONTROL_PANEL
if "%choice%"=="62" goto SERVICES
if "%choice%"=="63" goto TASK_MANAGER
if "%choice%"=="64" goto REGEDIT
if "%choice%"=="65" goto TERMINAL
if "%choice%"=="66" goto SYSTEM_INFO
if "%choice%"=="67" goto INSTALLED_PROGRAMS
if "%choice%"=="68" goto RUNNING_PROCESSES
if "%choice%"=="69" goto DISK_USAGE
if "%choice%"=="70" goto STARTUP_PROGRAMS
if "%choice%"=="71" goto EXPORT_REPORT
if "%choice%"=="99" goto RUN_ALL_SAFE

echo.
echo    [!] Invalid choice. Please try again.
timeout /t 2 >nul
goto MENU

:: ============================================================================
:: APPEARANCE TWEAKS
:: ============================================================================

:DARK_MODE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DARK MODE                                                               ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Dark Mode...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] Dark Mode enabled successfully!
echo.
pause
goto MENU

:LIGHT_MODE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   LIGHT MODE                                                              ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Enabling Light Mode...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] Light Mode enabled successfully!
echo.
pause
goto MENU

:TOGGLE_TRANSPARENCY
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   TRANSPARENCY EFFECTS                                                    ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select an option:
echo.
echo     [1] Enable Transparency
echo     [2] Disable Transparency
echo     [0] Back to Main Menu
echo.
set /p tchoice="   Enter your choice [0-2]: "
if "%tchoice%"=="0" goto MENU
if "%tchoice%"=="1" (
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul
    echo.
    echo    [+] Transparency enabled!
)
if "%tchoice%"=="2" (
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
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
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings /t REG_BINARY /d 30000000feffffff0200000001000000300000002000000000000000c203000080070000e20300006000000001000000 /f >nul
    taskkill /F /IM explorer.exe >nul 2>&1
    start explorer.exe
    echo    [+] Taskbar moved to top!
)
if "%tpchoice%"=="2" (
    echo.
    echo    [*] Moving Taskbar to Bottom...
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings /t REG_BINARY /d 30000000feffffff0200000003000000300000002000000000000000c203000080070000e20300006000000001000000 /f >nul
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
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul
    echo    [+] Explorer will now open to This PC!
)
if "%eschoice%"=="4" (
    echo.
    echo    [*] Setting Explorer to open to Quick Access...
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 2 /f >nul
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
echo.
set /p confirm="   Proceed? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU

echo.
echo    [*] Disabling Meet Now...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul

echo    [*] Disabling People bar...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f >nul

echo    [*] Disabling News and Interests...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul

echo    [*] Hiding Task View button...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul

echo    [*] Minimizing Search box to icon...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul

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
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallPaper /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallPaper /t REG_DWORD /d 1 /f >nul
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
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallPaper /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallPaper /f >nul 2>&1
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
    rd /s /q "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.default-release\cache2" >nul 2>&1
    echo    [+] Firefox cache cleared!
)
if "%bcchoice%"=="4" (
    echo.
    echo    [*] Clearing all browser caches...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.default-release\cache2" >nul 2>&1
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
echo    This will hide the following folders from This PC view:
echo.
echo     - 3D Objects, Videos, Documents, Downloads, Pictures, Music, Desktop
echo.
set /p confirm="   Proceed? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU

echo.
echo    [*] Hiding 3D Objects...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul

echo    [*] Hiding Videos...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul

echo    [*] Hiding Documents...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul

echo    [*] Hiding Downloads...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul

echo    [*] Hiding Pictures...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul

echo    [*] Hiding Music...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul

echo    [*] Hiding Desktop...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f >nul

taskkill /F /IM explorer.exe >nul 2>&1
start explorer.exe
echo.
echo    [+] Explorer folders hidden! Explorer restarted.
echo.
pause
goto MENU

:CLEAR_SPOTLIGHT
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE LOCKSCREEN SPOTLIGHT AND ADS                                    ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [*] Disabling Lockscreen Spotlight and Ads...
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightWindowsWelcomeExperience /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnActionCenter /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnSettings /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableThirdPartySuggestions /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v ConfigureWindowsSpotlight /t REG_DWORD /d 2 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 0 /f >nul
echo.
echo    [+] Lockscreen Spotlight and ads disabled!
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
echo    Select what to remove:
echo.
echo     [1] Remove Your Phone / Phone Link
echo     [2] Remove Widgets / Web Experience
echo     [3] Remove Xbox Apps
echo     [4] Remove Microsoft News
echo     [5] Remove Clipchamp
echo     [6] Remove ALL Bloatware (except Store)
echo     [0] Back to Main Menu
echo.
set /p rbchoice="   Enter your choice [0-6]: "
if "%rbchoice%"=="0" goto MENU
if "%rbchoice%"=="1" (
    echo.
    echo    [*] Removing Your Phone...
    PowerShell -Command "Get-AppxPackage *YourPhone* | Remove-AppxPackage" >nul 2>&1
    PowerShell -Command "Get-AppxPackage -allusers *YourPhone* | Remove-AppxPackage" >nul 2>&1
    echo    [+] Your Phone removed!
)
if "%rbchoice%"=="2" (
    echo.
    echo    [*] Removing Widgets...
    PowerShell -Command "Get-AppxPackage *Windows.Client.WebExperience* | Remove-AppxPackage" >nul 2>&1
    PowerShell -Command "Get-AppxPackage -allusers *Windows.Client.WebExperience* | Remove-AppxPackage" >nul 2>&1
    echo    [+] Widgets removed!
)
if "%rbchoice%"=="3" (
    echo.
    echo    [*] Removing Xbox Apps...
    PowerShell -Command "Get-AppxPackage *Xbox* | Remove-AppxPackage" >nul 2>&1
    echo    [+] Xbox Apps removed!
)
if "%rbchoice%"=="4" (
    echo.
    echo    [*] Removing Microsoft News...
    PowerShell -Command "Get-AppxPackage *BingNews* | Remove-AppxPackage" >nul 2>&1
    echo    [+] Microsoft News removed!
)
if "%rbchoice%"=="5" (
    echo.
    echo    [*] Removing Clipchamp...
    PowerShell -Command "Get-AppxPackage *Clipchamp* | Remove-AppxPackage" >nul 2>&1
    echo    [+] Clipchamp removed!
)
if "%rbchoice%"=="6" (
    echo.
    echo    [!] WARNING: This will remove many pre-installed apps.
    set /p confirm2="   Are you sure? (Y/N): "
    if /i "!confirm2!" NEQ "Y" goto MENU
    echo    [*] Removing all bloatware...
    PowerShell -Command "Get-AppxPackage -AllUsers | where-object {$_.name -notlike '*store*' -and $_.name -notlike '*calculator*' -and $_.name -notlike '*photos*' -and $_.name -notlike '*WindowsTerminal*'} | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
    echo    [+] Bloatware removal attempted!
)
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
echo    [*] Removing/Disabling PC Health Check...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PCHC" /v PreviousUninstall /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PCHealthCheck" /v installed /t REG_DWORD /d 1 /f >nul
echo.
echo    [+] PC Health Check disabled!
echo.
pause
goto MENU

:: ============================================================================
:: WINDOWS SERVICES
:: ============================================================================

:DISABLE_UPDATE
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISABLE WINDOWS UPDATE                                                  ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    [!] WARNING: This will disable automatic Windows updates.
echo.
set /p confirm="   Are you sure? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableOSUpgrade /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v SetDisableUXWUAccess /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
sc config wuauserv start= disabled >nul 2>&1
net stop wuauserv >nul 2>&1
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
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableOSUpgrade /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v SetDisableUXWUAccess /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /f >nul 2>&1
sc config wuauserv start= auto >nul 2>&1
net start wuauserv >nul 2>&1
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
echo    [!] WARNING: This will disable telemetry data collection.
echo.
set /p confirm="   Are you sure? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f >nul
sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
net stop DiagTrack >nul 2>&1
net stop dmwappushservice >nul 2>&1
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
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaAboveLock /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v CanCortanaBeEnabled /t REG_DWORD /d 0 /f >nul
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
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f >nul
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
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f >nul
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
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableSpecialRunningModes /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRoutinelyTakingAction /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v ServiceKeepAlive /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v ConfigureAppInstallControlEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v DisableBlockAtFirstSeen /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SubmitSamplesConsent /t REG_DWORD /d 2 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SpynetReporting /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul
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
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRealtimeMonitoring /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1
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
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v SyncDisabled /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v BrowserSignin /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v ComponentUpdatesEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v MAUEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v AutoUpdateCheckPeriodMinutes /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v UpdateDefault /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v UpdatePolicy /t REG_DWORD /d 0 /f >nul
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
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul
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
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles ^| findstr "Profile"') do (
    set "ssid=%%a"
    call :SHOWPASS
)
echo.
pause
goto MENU

:SHOWPASS
set ssid=%ssid:~1%
for /f "tokens=2 delims=:" %%b in ('netsh wlan show profile name^="%ssid%" key^=clear ^| findstr "Key Content"') do (
    echo    Network: %ssid%
    echo    Password:%%b
    echo.
)
exit /b

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
echo # Copyright (c) 1993-2009 Microsoft Corp. > %WINDIR%\System32\drivers\etc\hosts
echo # >> %WINDIR%\System32\drivers\etc\hosts
echo # This is a sample HOSTS file used by Microsoft TCP/IP for Windows. >> %WINDIR%\System32\drivers\etc\hosts
echo # >> %WINDIR%\System32\drivers\etc\hosts
echo 127.0.0.1       localhost >> %WINDIR%\System32\drivers\etc\hosts
echo ::1             localhost >> %WINDIR%\System32\drivers\etc\hosts
ipconfig /flushdns >nul
echo.
echo    [+] Hosts file reset to default!
echo.
pause
goto MENU

:: ============================================================================
:: PERFORMANCE BOOST
:: ============================================================================

:POWER_PLAN
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   CHANGE POWER PLAN                                                       ^|
echo   ^|___________________________________________________________________________^|
echo.
echo    Select power plan:
echo.
echo     [1] High Performance (Maximum performance, higher power usage)
echo     [2] Balanced (Default - balances performance and power)
echo     [3] Power Saver (Maximum battery life, reduced performance)
echo     [4] Ultimate Performance (Create/Enable hidden plan)
echo     [0] Back to Main Menu
echo.
set /p ppchoice="   Enter your choice [0-4]: "
if "%ppchoice%"=="0" goto MENU
if "%ppchoice%"=="1" (
    echo.
    echo    [*] Activating High Performance plan...
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    echo    [+] High Performance plan activated!
)
if "%ppchoice%"=="2" (
    echo.
    echo    [*] Activating Balanced plan...
    powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
    echo    [+] Balanced plan activated!
)
if "%ppchoice%"=="3" (
    echo.
    echo    [*] Activating Power Saver plan...
    powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a
    echo    [+] Power Saver plan activated!
)
if "%ppchoice%"=="4" (
    echo.
    echo    [*] Creating Ultimate Performance plan...
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
    for /f "tokens=4" %%a in ('powercfg /list ^| findstr "Ultimate"') do set ULTIMATEGUID=%%a
    powercfg /setactive !ULTIMATEGUID! >nul 2>&1
    echo    [+] Ultimate Performance plan activated!
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
echo    [*] Disabling Visual Effects for Performance...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul
echo.
echo    [+] Visual effects disabled! Logout/restart recommended.
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
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f >nul
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
echo    [*] Disabling Xbox Game Bar and DVR...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f >nul
echo.
echo    [+] Xbox Game Bar and DVR disabled!
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
echo    [!] WARNING: This will disable search indexing. Search may be slower.
echo.
set /p confirm="   Are you sure? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MENU
echo.
sc config WSearch start= disabled >nul 2>&1
net stop WSearch >nul 2>&1
echo.
echo    [+] Search indexing disabled!
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
echo    [+] Search indexing enabled!
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
powercfg /h off
echo.
echo    [+] Hibernation disabled! Disk space recovered.
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
powercfg /h on
echo.
echo    [+] Hibernation enabled!
echo.
pause
goto MENU

:: ============================================================================
:: SYSTEM REPAIR
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
echo    [*] This may take several minutes. Please wait...
echo.
sfc /scannow
echo.
echo    [+] System File Checker complete!
echo.
pause
goto MENU

:RUN_DISM
cls
echo.
echo    ___________________________________________________________________________
echo   ^|                                                                           ^|
echo   ^|   DISM HEALTH TOOLS                                                       ^|
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
:: QUICK LAUNCHERS
:: ============================================================================

:DEVICE_MANAGER
cls
echo    [*] Opening Device Manager...
start devmgmt.msc
goto MENU

:CONTROL_PANEL
cls
echo    [*] Opening Control Panel...
start control
goto MENU

:SERVICES
cls
echo    [*] Opening Services...
start services.msc
goto MENU

:TASK_MANAGER
cls
echo    [*] Opening Task Manager...
start taskmgr
goto MENU

:REGEDIT
cls
echo    [*] Opening Registry Editor...
start regedit
goto MENU

:TERMINAL
cls
echo    [*] Opening Windows Terminal...
start wt
if errorlevel 1 start cmd
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
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
echo.
echo    === All Users Registry ===
reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
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
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" >> "!REPORT!" 2>nul
reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" >> "!REPORT!" 2>nul
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
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul

echo    [02/12] Cleaning Temp Files...
del /q/f/s "%TEMP%\*" >nul 2>&1
del /q/f/s "%WINDIR%\Temp\*" >nul 2>&1
del /q/f/s "%WINDIR%\Prefetch\*" >nul 2>&1

echo    [03/12] Flushing DNS...
ipconfig /flushdns >nul

echo    [04/12] Emptying Recycle Bin...
PowerShell.exe -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1

echo    [05/12] Disabling Background Apps...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul

echo    [06/12] Disabling Store Auto-Install...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f >nul

echo    [07/12] Disabling Cortana...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 0 /f >nul

echo    [08/12] Disabling Game Bar...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul

echo    [09/12] Disabling Telemetry...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

echo    [10/12] Cleaning Taskbar...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul

echo    [11/12] Disabling Lockscreen Ads...
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul

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
echo   ^|        Thank you for using Sychic System Toolkit v2.0!                    ^|
echo   ^|                                                                           ^|
echo   ^|                   Created with care by @09sychic                          ^|
echo   ^|                                                                           ^|
echo   ^|              Stay safe and keep your system optimized!                    ^|
echo   ^|                                                                           ^|
echo   ^|___________________________________________________________________________^|
echo.
timeout /t 3 >nul
exit
