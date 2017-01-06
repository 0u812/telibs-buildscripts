#/usr/bin/env zsh

OSX_VER=10.9
ROOT=~/devel
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_VER.sdk
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR

CMAKE_GEN="-GXcode"
CMAKE_PLATFORM_FLAGS=( "-DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VER" )
CMAKE_BUILD_CMD="xcodebuild -configuration Release build install -target install"

source "$( dirname "${BASH_SOURCE[0]}" )"/build.sh
