#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/whlbldr
export LD_LIBRARY_PATH=/whlbldr/install/gcc-5.4.0/lib:$LD_LIBRARY_PATH
export PATH=/whlbldr/install/gcc-5.4.0/bin:$PATH
export PATH=/whlbldr/tools/bin:$PATH
export PATH=/whlbldr/install/bison-3.0.4/bin:$PATH
export PATH=/whlbldr/install/flex-2.6.2/bin:$PATH
echo "gcc=" `which gcc`
export CC=`which gcc`
export CXX=`which g++`

PYTHON_INTERP=/opt/python/cp27-cp27mu/bin/python2
PIP=/opt/python/cp27-cp27mu/bin/pip2
PYTHON_INCLUDE=/opt/python/cp27-cp27mu/include/python2.7

OMNIIDL=/Users/phantom/etc/install/omniorb-4.2.1/bin/omniidl

# check out latest source
cd $ROOT/src/cellml-api
git pull

mkdir -p $ROOT/build/cellapi
cd $_
rm -rf *
pwd
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/cell-api -DOMNIIDL=$OMNIIDL -DENABLE_CUSES=TRUE -DENABLE_ANNOTOOLS=TRUE -DENABLE_CEVAS=TRUE -DENABLE_TELICEMS=TRUE -DENABLE_CCGS=ON -DENABLE_CELEDS=ON -DENABLE_CELEDS_EXPORTER=ON -DENABLE_MALAES=ON -DENABLE_RDF=ON -DENABLE_VACSS=ON -DCMAKE_CXX_FLAGS="-std=c++11" $ROOT/src/cellml-api
make -j4 && make install
