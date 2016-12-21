#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

ROOT=/whlbldr
NAME=libsbml-experimental-cpp03

INSTALL_PREFIX=$ROOT/install
INSTALL_DIR=$INSTALL_PREFIX/$NAME

mkdir -p $ROOT/build/$NAME
cd $_
pwd
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DENABLE_DISTRIB=ON -DENABLE_COMP=ON -DENABLE_LAYOUT=ON -DENABLE_RENDER=ON -DENABLE_FBC=ON -DWITH_PYTHON=OFF $ROOT/src/libsbml-experimental
make -j4 && make install
