@echo off
chcp 65001 >nul
echo ==========================================
echo   ServerIPDisplay Mod - Auto Builder
echo ==========================================
echo.

java -version 2>&1 | findstr /i "version" >nul
if errorlevel 1 (
    echo ERROR: Java not found! Please install JDK 17+
    echo    Download: https://adoptium.net/temurin/releases/?version=17
    pause
    exit /b 1
)

java -version 2>&1
echo.

if not exist "gradle-8.5\bin\gradle.bat" (
    echo Downloading Gradle 8.5...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://services.gradle.org/distributions/gradle-8.5-bin.zip', 'gradle-8.5.zip')"
    if errorlevel 1 (
        echo ERROR: Failed to download Gradle.
        pause
        exit /b 1
    )
    echo Extracting...
    powershell -Command "Expand-Archive -Path 'gradle-8.5.zip' -DestinationPath '.' -Force"
    del gradle-8.5.zip
    echo Gradle ready
    echo.
)

echo Building mod...
call gradle-8.5\bin\gradle.bat build --no-daemon

if exist "build\libs\serveripdisplay-1.0.0.jar" (
    echo.
    echo ==========================================
    echo   BUILD SUCCESS!
    echo ==========================================
    echo.
    echo Output: build\libs\serveripdisplay-1.0.0.jar
    echo.
    echo Next steps:
    echo   1. Copy JAR to your Minecraft mods\ folder
    echo   2. Launch Minecraft with Forge 1.20.1
    echo   3. Open Multiplayer screen - IP banner appears!
    echo.
) else (
    echo BUILD FAILED! Check errors above.
    pause
    exit /b 1
)

pause
