#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

LIBSBML=/Users/phantom/devel/install/libsbml-experimental-xcode/lib/libsbml-static.a
LIBSBML_INCLUDE=/Users/phantom/devel/install/libsbml-experimental-xcode/include
NUML=/Users/phantom/devel/install/libnuml-xcode/lib/libnuml-static.a
NUML_INCLUDE=/Users/phantom/devel/install/libnuml-xcode/include

mkdir -p ~/devel/build/libsedml-xcode
cd $_
pwd
rm -rf *
cmake -G"Xcode" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_INSTALL_PREFIX=~/devel/install/libsedml-xcode -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DEXTRA_LIBS='xml2;bz2;z;iconv' -DWITH_PYTHON=ON -DPYTHON_USE_DYNAMIC_LOOKUP=ON -DLIBNUML_LIBRARY=$NUML -DLIBNUML_INCLUDE_DIR=$NUML_INCLUDE ~/devel/src/libsedml
xcodebuild -configuration Release build install -target install
