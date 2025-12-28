#!/bin/sh
#
# Gradle wrapper for Unix-like systems.
# Downloads and runs the specified version of Gradle.
#

set -e

# Get the script directory and change to the project root
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

GRADLE_USER_HOME="${GRADLE_USER_HOME:-$HOME/.gradle}"

# Read properties
PROPERTIES_FILE="$SCRIPT_DIR/gradle/wrapper/gradle-wrapper.properties"
DISTRIBUTION_URL=$(grep "distributionUrl" "$PROPERTIES_FILE" | cut -d'=' -f2 | tr -d '\r')

# Parse distribution details
GRADLE_VERSION=$(echo "$DISTRIBUTION_URL" | sed 's/.*gradle-\([0-9.]*\)-.*/\1/')
DIST_DIR="$GRADLE_USER_HOME/wrapper/dists"

# Determine the expected Gradle home directory
GRADLE_DIR="$DIST_DIR/gradle-$GRADLE_VERSION"
if [ ! -d "$GRADLE_DIR" ]; then
    GRADLE_DIR="$DIST_DIR/gradle-$GRADLE_VERSION-bin"
fi

# Download if necessary
if [ ! -f "$GRADLE_DIR/bin/gradle" ]; then
    echo "Downloading Gradle $GRADLE_VERSION..."
    mkdir -p "$DIST_DIR"
    cd "$DIST_DIR"
    DIST_FILE="gradle-$GRADLE_VERSION-bin.zip"
    if [ ! -f "$DIST_FILE" ]; then
        curl -L -o "$DIST_FILE" "$DISTRIBUTION_URL"
    fi
    # Extract and rename if necessary
    if [ -f "$DIST_FILE" ]; then
        unzip -q "$DIST_FILE"
        # If extracted as gradle-X.Y.Z-bin, rename to gradle-X.Y.Z
        if [ -d "gradle-$GRADLE_VERSION-bin" ] && [ ! -d "gradle-$GRADLE_VERSION" ]; then
            mv "gradle-$GRADLE_VERSION-bin" "gradle-$GRADLE_VERSION"
        fi
        rm "$DIST_FILE"
    fi
    # Return to project directory
    cd "$SCRIPT_DIR"
    # Update GRADLE_DIR to final location
    GRADLE_DIR="$DIST_DIR/gradle-$GRADLE_VERSION"
fi

# Run Gradle
exec "$GRADLE_DIR/bin/gradle" "$@"
