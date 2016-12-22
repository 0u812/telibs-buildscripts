#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/c/Users/phantom/Documents/devel
CMAKE="C:\Users\phantom\Downloads\cmake-3.7.0-win64-x64\bin\cmake.exe"

LIBSBML_PREFIX=$ROOT/install/libsbml-experimental
LIBSBML_LIB_DIR=$LIBSBML_PREFIX/lib
LIBSBML=$LIBSBML_LIB_DIR/libsbml-static.lib
LIBSBML_INCLUDE=$LIBSBML_PREFIX/include

LIBNUML_PREFIX=$ROOT/install/libnuml
LIBNUML_LIB_DIR=$LIBNUML_PREFIX/lib
NUML=$LIBNUML_LIB_DIR/libnuml-static.lib
NUML_INCLUDE=$LIBNUML_PREFIX/include

mkdir -p $ROOT/build/libsedml
cd $_
pwd
rm -rf *
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/libsedml -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DWITH_PYTHON=OFF -DLIBNUML_LIBRARY=$NUML -DLIBNUML_INCLUDE_DIR=$NUML_INCLUDE -DLIBNUML_STATIC=ON -DEXTRA_LIBS="C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libxml2.lib;C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/zdll.lib;C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libiconv.lib;ws2_32.lib" $ROOT/src/libsedml
"$CMAKE" --build . --target install --config Release
