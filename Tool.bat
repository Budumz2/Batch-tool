@echo off

:: GitHub repository information
set "repoOwner=Budumz2"
set "repoName=Batch-tool"
set "latestVersionURL=https://raw.githubusercontent.com/%repoOwner%/%repoName%/main/version.txt"
set "localVersionFile=%~dp0version.txt"

:: Fetch the latest version from GitHub
echo Checking for updates...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%latestVersionURL%', '%temp%\latestVersion.txt')"

:: Compare versions
IF EXIST "%localVersionFile%" (
    for /f %%i in (%localVersionFile%) do set localVersion=%%i
) ELSE (
    set localVersion=0
)

for /f %%i in (%temp%\latestVersion.txt) do set latestVersion=%%i

echo Current version: %localVersion%
echo Latest version: %latestVersion%

:: Check if update is needed
IF "%localVersion%" NEQ "%latestVersion%" (
    echo Update available. Downloading latest version...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/%repoOwner%/%repoName%/main/Tool.bat', '%~dp0Tool.bat')"
    
    :: Update the local version file
    echo %latestVersion% > "%localVersionFile%"
    
    echo Update downloaded. Restarting script...
    start "" "%~dp0Tool.bat"
    exit
) ELSE (
    echo No update available.
)

:: Continue with the rest of your original script
title Tool Installer
color 0A

echo Current user: %USERNAME%


:: Tools- Winrar/ Visualstudo Code/ Background / 

:: Define paths
set "winrarPath=C:\Program Files\WinRAR\WinRAR.exe"
set "vsCodePath=C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\Code.exe"
set "backgroundImagePath=C:\Users\%USERNAME%\Downloads\Bild.jpg"

:: Check if WinRAR is installed
IF EXIST "%winrarPath%" (
    echo WinRAR is already installed.
) ELSE (
    echo WinRAR is not installed.
    
    :: Download WinRAR installer
    echo Downloading WinRAR installer...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.rarlab.com/rar/winrar-x64-621.exe' -OutFile '%temp%\winrar-installer.exe'"
    
    :: Install WinRAR silently
    echo Installing WinRAR...
    start /wait %temp%\winrar-installer.exe /S
    
    :: Check if installation was successful
    IF EXIST "%winrarPath%" (
        echo WinRAR installed successfully.
    ) ELSE (
        echo Installation failed.
    )
)

:: Check if rarreg.key exists
IF EXIST "C:\Program Files\WinRAR\rarreg.key" (
    echo Rarreg key exists.
) ELSE (
    echo Rarreg is not there, creating it now...
    
    echo RAR registration data > "C:\Program Files\WinRAR\rarreg.key"
    (
        echo Hardik
        echo www.Hardik.live
        echo ID=448c4a899c6cdc1039c5
        echo 641221225039c585fc5ef8da12ccf689780883109587752a828ff0
        echo 59ae0579fe68942c97d160f361d16f96c8fe03f1f89c66abc25a37
        echo 7777a27ec82f103b3d8e05dcefeaa45c71675ca822242858a1c897
        echo c57d0b0a3fe7ac36c517b1d2be385dcc726039e5f536439a806c35
        echo 1e180e47e6bf51febac6eaae111343d85015dbd59ba45c71675ca8
        echo 2224285927550547c74c826eade52bbdb578741acc1565af60e326
        echo 6b5e5eaa169647277b533e8c4ac01535547d1dee14411061928023
    ) >> "C:\Program Files\WinRAR\rarreg.key"
)

:: Check if Visual Studio Code is installed
IF EXIST "%vsCodePath%" (
    echo Visual Studio Code is installed.
) ELSE (
    echo Downloading Visual Studio Code installer...
    powershell -Command "Invoke-WebRequest -Uri 'https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user' -OutFile '%temp%\VSCodeUserSetup-x64-1.93.1.exe'"
    start /wait %temp%\VSCodeUserSetup-x64-1.93.1.exe /S
)

:: Check for background image
IF EXIST "%backgroundImagePath%" (
    echo Background is set.
) ELSE (
    echo Downloading background image...
    powershell -Command "Invoke-WebRequest -Uri 'https://images.pexels.com/photos/2312040/pexels-photo-2312040.jpeg' -OutFile '%backgroundImagePath%'"
    
    :: Change the desktop wallpaper
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%backgroundImagePath%" /f
    if %errorlevel%==0 (
        RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
        echo Wallpaper has been changed.
    ) else (
        echo Failed to update wallpaper in registry.
    )
)

pause >nul
