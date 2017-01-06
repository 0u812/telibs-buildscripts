#/usr/bin/env zsh

OSX_VER=10.9
OS_STR=osx-$OSX_VER
ROOT=~/devel
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_VER.sdk

CMAKE_GEN="-GXcode"
CMAKE_PLATFORM_FLAGS=( "-DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VER" )
CMAKE_BUILD_CMD="xcodebuild -configuration Release build install -target install"

LIBSBML_EXTRA_LIBS='xml2;bz2;z;iconv'

source "$( dirname "${BASH_SOURCE[0]}" )"/build.sh
