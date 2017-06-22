#!/bin/sh
GRADLE_BUILD="$1"

if [ -z ${CIRCLE_BUILD_NUM+x} ]; then
    awk '{sub(/versionCode [[:digit:]]+$/, "versionCode "$2+1)}1' $GRADLE_BUILD > gradle.tmp
else
    awk -v version=$CIRCLE_BUILD_NUM '{sub(/versionCode [[:digit:]]+$/, "versionCode "version)}1' $GRADLE_BUILD > gradle.tmp
fi

mv -f gradle.tmp $GRADLE_BUILD