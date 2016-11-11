#!/usr/bin/env bash
set -e

PYTHON_DIR=/opt/python/cp27-cp27m
PYTHON_EXE=python2
PYTHON_NAME=python2.7
PIP=/opt/python/cp27-cp27m/bin/pip2

# cd to directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
# cd to the directory containing src, build, install
while [ ! -d .git ]; do
  cd ..
done
cd ../..

ROOT=`pwd`
echo "Using root dir $ROOT"

$PIP install numpy

cd build
mkdir -p roadrunner
cd $_
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/roadrunner -DTHIRD_PARTY_INSTALL_FOLDER=$ROOT/install/roadrunner -DLLVM_CONFIG_EXECUTABLE=$ROOT/install/llvm-3.3/bin/llvm-config -DBUILD_PYTHON=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON -DPYTHON_EXECUTABLE=$PYTHON_DIR/bin/$PYTHON_EXE -DPYTHON_INCLUDE_DIR=$PYTHON_DIR/include/$PYTHON_NAME -DBUILD_JAVA_INTERFACE=OFF -DRR_USE_CXX11=FALSE -DUSE_TR1_CXX_NS=TRUE $ROOT/src/roadrunner
make -j4 install
