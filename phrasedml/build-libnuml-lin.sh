#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/whlbldr

mkdir -p $ROOT/build/libnuml
cd $_
pwd
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/whlbldr/install/libnuml -DLIBSBML_LIBRARY=/whlbldr/install/libsbml-experimental/lib/libsbml-static.a -DLIBSBML_STATIC=ON -DLIBSBML_INCLUDE_DIR=/whlbldr/install/libsbml-experimental/include /whlbldr/src/NuML/libnuml
make -j4 && make install
