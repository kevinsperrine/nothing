#/bin/sh
set -e
# install the sdk
brew tap caskroom/cask
# ensure sdk binaries are made available
brew cask install android-sdk
# ensure PATH is set correctly
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
# install basic SDK tools
if [ ! -e /usr/local/android-sdk-linux/platforms/android-23 ]; then sdkmanager "platforms;android-23"
if [ ! -e /usr/local/android-sdk-linux/build-tools/23.0.1 ]; then sdkmanager "build-tools;23.0.1"
sdkmanager "tools"
# ensure licenses are already accepted
mkdir -p $ANDROID_HOME/licenses
cp ./android-licenses/* $ANDROID_HOME/licenses