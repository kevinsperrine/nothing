#!/bin/sh
GRADLE_BUILD="$1"

if [ -z ${CIRCLE_BUILD_NUM+x} ]; then
    awk '{sub(/versionCode [[:digit:]]+$/, "versionCode "$2+1)}1' $GRADLE_BUILD > gradle.tmp
else
    VERSION=$(( $CIRCLE_BUILD_NUM + 52 ));
    awk -v version=$VERSION '{sub(/versionCode [[:digit:]]+$/, "versionCode "version)}1' $GRADLE_BUILD > gradle.tmp
fi

mv -f gradle.tmp $GRADLE_BUILD