#!/bin/sh

if [ -n "$JAVA_HOME" ] ; then
    JAVACMD="$JAVA_HOME/bin/java"
else
    JAVACMD="$(which java)"
fi

if [ ! -x "$JAVACMD" ] ; then
    echo "ERROR: JAVA_HOME is not set and no 'java' command could be found."
    echo "Please install JDK 17+ from https://adoptium.net/temurin/releases/?version=17"
    exit 1
fi

JAVA_VER=$("$JAVACMD" -version 2>&1 | head -1 | sed 's/.*"\([0-9]*\).*"/\1/')
if [ "$JAVA_VER" -lt "17" ]; then
    echo "ERROR: Java 17+ required. Found version $JAVA_VER"
    exit 1
fi

echo "Using Java: $JAVACMD (version $JAVA_VER)"

GRADLE_DIR="gradle-8.5"
GRADLE_ZIP="gradle-8.5-bin.zip"
GRADLE_URL="https://services.gradle.org/distributions/gradle-8.5-bin.zip"

if [ ! -f "$GRADLE_DIR/bin/gradle" ]; then
    echo "Downloading Gradle 8.5..."
    if command -v curl >/dev/null 2>&1; then
        curl -L -o "$GRADLE_ZIP" "$GRADLE_URL"
    elif command -v wget >/dev/null 2>&1; then
        wget -O "$GRADLE_ZIP" "$GRADLE_URL"
    else
        echo "ERROR: Neither curl nor wget found."
        exit 1
    fi

    echo "Extracting Gradle..."
    unzip -q "$GRADLE_ZIP"
    rm -f "$GRADLE_ZIP"
fi

"$GRADLE_DIR/bin/gradle" "$@"
