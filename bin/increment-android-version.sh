#!/bin/sh
GRADLE_BUILD="$1"

awk '{sub(/versionCode [[:digit:]]+$/, "versionCode "$2+1)}1' $GRADLE_BUILD > gradle.tmp
mv -f gradle.tmp $GRADLE_BUILD