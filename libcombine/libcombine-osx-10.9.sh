#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
SRCNAME=libcombine
OSX_VER=10.9
if [[ -z "${PYTHON+x}" ]]; then
  INSTNAME=$SRCNAME-osx-$OSX_VER
else
  INSTNAME=$SRCNAME-osx-$OSX_VER-$CP
fi
ROOT=/Users/phantom/devel
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_VER.sdk

CMAKE_GEN="-GXcode"
CMAKE_PLATFORM_FLAGS=( "-DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VER" )
CMAKE_BUILD_CMD="xcodebuild -configuration Release build install -target install"

LIBSBML_INSTNAME=libsbml-experimental-osx-$OSX_VER
LIBSBML_INSTALL_DIR=$ROOT/install/$LIBSBML_INSTNAME
LIBSBML=$LIBSBML_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_INSTALL_DIR/include

LIBNUML_INSTALL_DIR=$ROOT/install/libnuml-osx-10.9
NUML=$LIBNUML_INSTALL_DIR/lib/libnuml-static.a
NUML_INCLUDE=$LIBNUML_INSTALL_DIR/include

LIBSEDML_INSTNAME=libsedml-osx-$OSX_VER
LIBSEDML_INSTALL_DIR=$ROOT/install/$LIBSEDML_INSTNAME
LIBSEDML=$LIBSEDML_INSTALL_DIR/lib/libsedml-static.a
LIBSEDML_INCLUDE=$LIBSEDML_INSTALL_DIR/include

ZIPPER_INSTNAME=zipper-osx-$OSX_VER
ZIPPER_INSTALL_DIR=$ROOT/install/$ZIPPER_INSTNAME
ZIPPER=$ZIPPER_INSTALL_DIR/lib/libZipper-static.a
ZIPPER_INCLUDE_DIR=$ZIPPER_INSTALL_DIR/include

export CMAKE_PREFIX_PATH="$LIBSBML_INSTALL_DIR/lib/cmake:$LIBNUML_INSTALL_DIR/lib/cmake"
echo "CMAKE_PREFIX_PATH = $CMAKE_PREFIX_PATH"

source libcombine-build.sh
