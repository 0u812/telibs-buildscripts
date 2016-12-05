#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

PYTHON=/usr/local/bin/python2
PYLIB=/Library/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib
PYINCLUDE=/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7
CELLAPI=/Users/phantom/devel/install/cell-api-xcode
LIBSBML=/Users/phantom/devel/install/libsbml-experimental-xcode

mkdir -p ~/devel/build/antimony-trunk-xcode-py2m
cd $_
pwd
cmake -GXcode -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=~/devel/install/antimony-trunk-xcode-py2m -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_LIBRARY=$PYLIB -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI ~/devel/src/antimony-trunk
xcodebuild -configuration Release build install -target install
