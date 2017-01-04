#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
OSX_VER=10.9
SRCNAME=libsedml
INSTNAME=$SRCNAME-osx-$OSX_VER
ROOT=~/devel
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_VER.sdk

LIBSBML_INSTNAME=libsbml-experimental-osx-$OSX_VER
LIBSBML=/Users/phantom/devel/install/$LIBSBML_INSTNAME/lib/libsbml-static.a
LIBSBML_INCLUDE=/Users/phantom/devel/install/$LIBSBML_INSTNAME/include
NUML=/Users/phantom/devel/install/libnuml-xcode/lib/libnuml-static.a
NUML_INCLUDE=/Users/phantom/devel/install/libnuml-xcode/include

mkdir -p $ROOT/build/$INSTNAME
cd $_
rm -rf *
cmake -G"Xcode" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VER -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DEXTRA_LIBS='xml2;bz2;z;iconv' -DWITH_PYTHON=OFF-DLIBNUML_LIBRARY=$NUML -DLIBNUML_INCLUDE_DIR=$NUML_INCLUDE $ROOT/src/$SRCNAME
xcodebuild -configuration Release build install -target install
