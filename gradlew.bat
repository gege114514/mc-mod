@rem
@rem ServerIPDisplay - Gradle Wrapper Stub for Windows
@rem

@if "%DEBUG%" == "" @echo off

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%

if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found.
echo Please install JDK 17+ from https://adoptium.net/temurin/releases/?version=17
goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute
echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
goto fail

:execute
echo Using Java: %JAVA_EXE%

set GRADLE_DIR=%DIRNAME%gradle-8.5
set GRADLE_ZIP=%DIRNAME%gradle-8.5-bin.zip
set GRADLE_URL=https://services.gradle.org/distributions/gradle-8.5-bin.zip

if not exist "%GRADLE_DIR%\bin\gradle.bat" (
    echo Downloading Gradle 8.5...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('%GRADLE_URL%', '%GRADLE_ZIP%')"
    echo Extracting...
    powershell -Command "Expand-Archive -Path '%GRADLE_ZIP%' -DestinationPath '%DIRNAME%' -Force"
    del "%GRADLE_ZIP%"
)

"%GRADLE_DIR%\bin\gradle.bat" %*
goto end

:fail
exit /b 1

:end
exit /b 0
