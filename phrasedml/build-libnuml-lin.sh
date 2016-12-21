#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/whlbldr

LIBSBML_PREFIX=$ROOT/install/libsbml-experimental-cpp03
LIBSBML_LIB_DIR=$LIBSBML_PREFIX/lib
LIBSBML=$LIBSBML_LIB_DIR/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_PREFIX/include

mkdir -p $ROOT/build/libnuml
cd $_
pwd
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/whlbldr/install/libnuml -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_STATIC=ON -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE /whlbldr/src/NuML/libnuml
make -j4 && make install
