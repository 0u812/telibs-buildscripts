#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/whlbldr

LIBSBML_PREFIX=$ROOT/install/libsbml-experimental
LIBSBML_LIB_DIR=$LIBSBML_PREFIX/lib
LIBSBML=$LIBSBML_LIB_DIR/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_PREFIX/include

LIBNUML_PREFIX=$ROOT/install/libnuml
LIBNUML_LIB_DIR=$LIBNUML_PREFIX/lib
NUML=$LIBNUML_LIB_DIR/libnuml-static.a
NUML_INCLUDE=$LIBNUML_PREFIX/include

export CMAKE_PREFIX_PATH=$LIBSBML_LIB_DIR/cmake:$LIBNUML_LIB_DIR/cmake:$CMAKE_PREFIX_PATH

mkdir -p $ROOT/build/libsedml
cd $_
pwd
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/libsedml-xcode -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DWITH_PYTHON=ON -DPYTHON_USE_DYNAMIC_LOOKUP=ON -DLIBNUML_LIBRARY=$NUML -DLIBNUML_INCLUDE_DIR=$NUML_INCLUDE $ROOT/src/libsedml
make -j4 && make install
