#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
SRCNAME=libsedml
OSX_VER=10.9
INSTNAME=$SRCNAME-osx-$OSX_VER
ROOT=/Users/phantom/devel
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_VER.sdk

LIBSBML_INSTNAME=libsbml-experimental-osx-$OSX_VER
LIBSBML_INSTALL_DIR=$ROOT/install/$LIBSBML_INSTNAME
LIBSBML=$LIBSBML_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_INSTALL_DIR/include

LIBNUML_INSTALL_DIR=$ROOT/install/libnuml-osx-10.9
NUML=$LIBNUML_INSTALL_DIR/lib/libnuml-static.a
NUML_INCLUDE=$LIBNUML_INSTALL_DIR/include

export CMAKE_PREFIX_PATH="$LIBSBML_INSTALL_DIR/lib/cmake:$LIBNUML_INSTALL_DIR/lib/cmake"
echo "CMAKE_PREFIX_PATH = $CMAKE_PREFIX_PATH"

mkdir -p $ROOT/build/$INSTNAME
cd $_
rm -rf *
cmake -G"Xcode" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VER -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DEXTRA_LIBS='xml2;bz2;z;iconv' -DWITH_PYTHON=OFF -DLIBNUML_INCLUDE_DIR=$NUML_INCLUDE $ROOT/src/$SRCNAME
xcodebuild -configuration Release build install -target install
