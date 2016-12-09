#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/whlbldr
export LD_LIBRARY_PATH=/whlbldr/install/gcc-5.4.0/lib64:$LD_LIBRARY_PATH
export PATH=/whlbldr/install/gcc-5.4.0/bin:$PATH
PYTHON=/opt/python/cp27-cp27mu/bin/python2
PIP=/opt/python/cp27-cp27mu/bin/pip2
PYINCLUDE=/opt/python/cp27-cp27mu/include/python2.7
CELLAPI=$ROOT/install/cell-api
LIBSBML=$ROOT/install/libsbml-experimental
ANTIMONY_INSTALL=$ROOT/install/antimony-trunk-py2mu
export PATH=/whlbldr/tools/bin:$PATH
export PATH=/whlbldr/install/swig/bin:$PATH
export CC=`which gcc`
export CXX=`which g++`

mkdir -p $ROOT/build/antimony-trunk-py2mu
cd $_
pwd
# rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ANTIMONY_INSTALL -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI -DCMAKE_CXX_FLAGS="-std=c++11" $ROOT/src/antimony-trunk
make -j4 && make install
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ANTIMONY_INSTALL -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI -DCMAKE_CXX_FLAGS="-std=c++11" $ROOT/src/antimony-trunk
make -j4 && make install
make -j4 && make install

# copy over cellml libs
cp $CELLAPI/lib/libcellml.so.1.13 $ANTIMONY_INSTALL/bindings/python/antimony/libcellml.so.2
cp $CELLAPI/lib/libcevas.so.1.13 $ANTIMONY_INSTALL/bindings/python/antimony/libcevas.so.1
cp $CELLAPI/lib/libannotools.so.1.13 $ANTIMONY_INSTALL/bindings/python/antimony/libannotools.so.2
cp $CELLAPI/lib/libcuses.so.1.13 $ANTIMONY_INSTALL/bindings/python/antimony/libcuses.so.1
cp $CELLAPI/lib/libtelicems.so.1.13 $ANTIMONY_INSTALL/bindings/python/antimony/libtelicems.so.1

# fix cellml libraries
# patchelf -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libcevas.1.dylib
#
# install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libannotools.2.dylib
#
# install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libcuses.1.dylib
# install_name_tool -change libannotools.2.dylib "@rpath/libannotools.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libcuses.1.dylib
#
# install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libtelicems.1.dylib

# fix ids of libraries
# install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
# install_name_tool -change libcevas.1.dylib "@rpath/libcevas.1.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
# install_name_tool -change libannotools.2.dylib "@rpath/libannotools.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
# install_name_tool -change libcuses.1.dylib "@rpath/libcuses.1.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
# install_name_tool -change libtelicems.1.dylib "@rpath/libtelicems.1.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so

patchelf --set-rpath '$ORIGIN/.' $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so

# copy over c++ libs
cp /whlbldr/install/gcc-5.4.0/lib64/libstdc++.so.6 $ANTIMONY_INSTALL/bindings/python/antimony
cp /whlbldr/install/gcc-5.4.0/lib64/libgcc_s.so.1 $ANTIMONY_INSTALL/bindings/python/antimony

# build binary wheel
cd $ANTIMONY_INSTALL/bindings/python
$PIP install wheel twine
$PYTHON setup.py bdist_wheel --python-tag=cp27 --plat-name=manylinux1-x86_64
# fix ABI tag
# http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'antimony*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp27mu}" ' -- \{\} \;
cd ..

echo "Now do something like /opt/python/cp27-cp27mu/bin/twine upload -s --sign-with gpg -i 9BE0E97B /whlbldr/install/antimony-trunk-py2mu/bindings/python/dist/ ..."
