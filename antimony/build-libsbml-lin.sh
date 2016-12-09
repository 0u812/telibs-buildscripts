#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

ROOT=/whlbldr
export LD_LIBRARY_PATH=/whlbldr/install/gcc-5.4.0/lib:$LD_LIBRARY_PATH
export PATH=/whlbldr/install/gcc-5.4.0/bin:$PATH
export PATH=/whlbldr/tools/bin:$PATH
export PATH=/whlbldr/install/swig/bin:$PATH
export CC=`which gcc`
export CXX=`which g++`

mkdir -p $ROOT/build/libsbml-experimental
cd $_
pwd
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/libsbml-experimental -DENABLE_DISTRIB=ON -DENABLE_COMP=ON -DENABLE_LAYOUT=ON -DENABLE_RENDER=ON -DENABLE_FBC=ON -DWITH_PYTHON=OFF -DCMAKE_CXX_FLAGS="-std=c++11" $ROOT/src/libsbml-experimental
make -j4 && make install
