#!/bin/bash
set -e

echo "=========================================="
echo "  ServerIPDisplay Mod - Auto Builder"
echo "=========================================="
echo ""

if ! command -v java &> /dev/null; then
    echo "ERROR: Java not found! Please install JDK 17+"
    echo "   Download: https://adoptium.net/temurin/releases/?version=17"
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | head -1 | cut -d'"' -f2 | cut -d'.' -f1)
echo "Java version: $JAVA_VERSION"

if [ "$JAVA_VERSION" -lt "17" ]; then
    echo "ERROR: Java 17+ required! Current: $JAVA_VERSION"
    exit 1
fi

if [ ! -f "gradle-8.5/bin/gradle" ]; then
    echo ""
    echo "Downloading Gradle 8.5..."
    curl -L -o gradle-8.5.zip "https://services.gradle.org/distributions/gradle-8.5-bin.zip" || \
    wget -O gradle-8.5.zip "https://services.gradle.org/distributions/gradle-8.5-bin.zip"
    unzip -q gradle-8.5.zip
    rm gradle-8.5.zip
    echo "Gradle downloaded"
fi

echo ""
echo "Building mod..."
./gradle-8.5/bin/gradle build --no-daemon

if [ -f "build/libs/serveripdisplay-1.0.0.jar" ]; then
    echo ""
    echo "=========================================="
    echo "  BUILD SUCCESS!"
    echo "=========================================="
    echo ""
    echo "Output: build/libs/serveripdisplay-1.0.0.jar"
    echo ""
    echo "Next steps:"
    echo "  1. Copy JAR to your Minecraft mods/ folder"
    echo "  2. Launch Minecraft with Forge 1.20.1"
    echo "  3. Open Multiplayer screen - IP banner appears!"
    echo ""
else
    echo "BUILD FAILED! Check errors above."
    exit 1
fi
