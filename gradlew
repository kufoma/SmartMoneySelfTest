#!/bin/sh
#
# Gradle wrapper for Unix-like systems.
# Downloads and runs the specified version of Gradle.
#

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GRADLE_USER_HOME="${GRADLE_USER_HOME:-$HOME/.gradle}"

# Read properties
PROPERTIES_FILE="$SCRIPT_DIR/gradle/wrapper/gradle-wrapper.properties"
DISTRIBUTION_URL=$(grep "distributionUrl" "$PROPERTIES_FILE" | cut -d'=' -f2 | tr -d '\r')

# Parse distribution details
GRADLE_VERSION=$(echo "$DISTRIBUTION_URL" | sed 's/.*gradle-\([0-9.]*\)-.*/\1/')
DIST_DIR="$GRADLE_USER_HOME/wrapper/dists"

# Download if necessary
DIST_FILE_PREFIX="gradle-$GRADLE_VERSION"
GRADLE_DIR="$DIST_DIR/$DIST_FILE_PREFIX"
if [ ! -d "$GRADLE_DIR/bin" ]; then
    echo "Downloading Gradle $GRADLE_VERSION..."
    mkdir -p "$DIST_DIR"
    cd "$DIST_DIR"
    DIST_FILE="$DIST_FILE_PREFIX-bin.zip"
    if [ ! -f "$DIST_FILE" ]; then
        curl -L -o "$DIST_FILE" "$DISTRIBUTION_URL"
    fi
    # Extract and rename if necessary
    if [ -f "$DIST_FILE" ]; then
        unzip -q "$DIST_FILE"
        # If extracted as gradle-X.Y.Z-bin, rename to gradle-X.Y.Z
        if [ -d "$DIST_FILE_PREFIX-bin" ] && [ ! -d "$DIST_FILE_PREFIX" ]; then
            mv "$DIST_FILE_PREFIX-bin" "$DIST_FILE_PREFIX"
        fi
        rm "$DIST_FILE"
    fi
fi

# Run Gradle
GRADLE_HOME="$GRADLE_DIR"
exec "$GRADLE_HOME/bin/gradle" "$@"
