#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
SRCNAME=zipper
OSX_VER=10.9
INSTNAME=$SRCNAME-osx-$OSX_VER
ROOT=~/devel
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk

mkdir -p $ROOT/build/$INSTNAME
cd $_
rm -rf *
cmake -G"Xcode" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME  $ROOT/src/$SRCNAME
xcodebuild -configuration Release build install -target install
