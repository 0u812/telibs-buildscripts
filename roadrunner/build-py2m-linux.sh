#/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/whlbldr
LLVM_CONFIG=/whlbldr/install/llvm-3.3/bin/llvm-config
PYTHON_INTERP=/opt/python/cp27-cp27m/bin/python2
PIP=/opt/python/cp27-cp27m/bin/pip2
PYTHON_INCLUDE=/opt/python/cp27-cp27m/include/python2.7

# check out latest roadrunner
cd $ROOT/src/roadrunner
git pull
cd $ROOT/src/rrplugins
git pull

$PIP install numpy

# Build roadrunner
mkdir -p $ROOT/build/roadrunner-py2m
cd $_
pwd
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/roadrunner-py2m -DLLVM_CONFIG_EXECUTABLE=$LLVM_CONFIG -DTHIRD_PARTY_INSTALL_FOLDER=$ROOT/install/roadrunner-py2m -DBUILD_PYTHON=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON -DRR_USE_CXX11=FALSE -DUSE_TR1_CXX_NS=TRUE -DPYTHON_EXECUTABLE=$PYTHON_INTERP -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DWITH_CONDA_BUILDER=OFF -DZLIB_LIBRARY_RELEASE=/usr/lib64/libz.so -DZLIB_LIBRARY=/usr/lib64/libz.so $ROOT/src/roadrunner

make -j4 && make install


# Build rrplugins
mkdir -p $ROOT/build/rrplugins-py2m && cd $_
cmake -DCMAKE_INSTALL_PREFIX=$ROOT/install/roadrunner-py2m -DCMAKE_BUILD_TYPE=Release  -DTLP_DEPENDENCIES_PATH=$ROOT/install/roadrunner-py2m $ROOT/src/rrplugins

make -j4 && make install


# Build pip package
cd $ROOT/install/roadrunner-py2m
$PYTHON_INTERP setup.py bdist_wheel --python-tag=cp27 --plat-name=manylinux1-x86_64
# Fix ABI tag
# http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'libroadrunner*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp27m}" ' -- \{\} \;
cd ..

# copy over setup for rrplugins
cp $THIS_DIR/rrplugins-setup.py $ROOT/install/roadrunner-py2m
$PYTHON_INTERP rrplugins-setup.py bdist_wheel --universal

echo "Now do something like twine upload $ROOT/install/roadrunner-py2m/dist/*"
