#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

ROOT=/whlbldr

mkdir -p $ROOT/build/libsbml-experimental
cd $_
pwd
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/libsbml-experimental -DENABLE_DISTRIB=ON -DENABLE_COMP=ON -DENABLE_LAYOUT=ON -DENABLE_RENDER=ON -DENABLE_FBC=ON -DWITH_PYTHON=OFF $ROOT/src/libsbml-experimental
make -j4 && make install
