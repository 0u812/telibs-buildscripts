#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

OSX_VER=10.9
OS_STR=osx-$OSX_VER
ROOT=~/devel
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_VER.sdk
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR
WHEEL_PLATFORM=macosx-10.9-x86_64

CMAKE=cmake
CMAKE_GEN="-GXcode"
CMAKE_PLATFORM_FLAGS=( "-DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VER" )
CMAKE_BUILD_CMD="xcodebuild -configuration Release build install -target install"

# libSBML
LIBSBML_INSTNAME=libsbml-experimental-$OS_STR
LIBSBML_INSTALL_DIR=$ROOT/install/$LIBSBML_INSTNAME
LIBSBML=$LIBSBML_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_INSTALL_DIR/include
LIBSBML_EXTRA_LIBS='xml2;bz2;z;iconv'

# libNuML
LIBNUML_INSTALL_DIR=$ROOT/install/libnuml-$OS_STR
NUML=$LIBNUML_INSTALL_DIR/lib/libnuml-static.a
NUML_INCLUDE=$LIBNUML_INSTALL_DIR/include

# CellML
OMNIIDL=/Users/phantom/etc/install/omniorb-4.2.1/bin/omniidl
BISON=/usr/local/Cellar/bison/3.0.4/bin/bison
FLEX=/usr/bin/flex
FLEXINCL=/usr/include
CELL_API_CXX_FLAGS="-std=c++0x -stdlib=libc++"
