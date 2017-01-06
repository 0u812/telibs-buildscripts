#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
OSX_VER=10.9
SRCNAME=sbml2matlab
if [[ -z "${PYTHON+x}" ]]; then
  INSTNAME=$SRCNAME-osx-$OSX_VER
else
  INSTNAME=$SRCNAME-osx-$OSX_VER-$CP
fi
ROOT=~/devel
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_VER.sdk

CMAKE_GEN="-GXcode"
CMAKE_PLATFORM_FLAGS=( "-DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VER" )
CMAKE_BUILD_CMD="xcodebuild -configuration Release build install -target install"

LIBSBML_PREFIX=$ROOT/install/libsbml-experimental-osx-10.9-cp34m

source sbml2matlab-build.sh
