#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

PYTHON=/opt/python/cp27-cp27mu/bin/python2
PIP=/opt/python/cp27-cp27mu/bin/pip2
PYINCLUDE=/opt/python/cp27-cp27mu/include/python2.7
CELLAPI=/Users/phantom/devel/install/cell-api
LIBSBML=/Users/phantom/devel/install/libsbml-experimental
ANTIMONY_INSTALL=/Users/phantom/devel/install/antimony-trunk-py2m

mkdir -p ~/devel/build/antimony-trunk-py2m
cd $_
pwd
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ANTIMONY_INSTALL -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI  ~/devel/src/antimony-trunk
make -j4 && make install
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ANTIMONY_INSTALL -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI  ~/devel/src/antimony-trunk
make -j4 && make install
make -j4 && make install

# copy over cellml libs
cp $CELLAPI/lib/libcellml.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libcellml.2.dylib
cp $CELLAPI/lib/libcevas.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libcevas.1.dylib
cp $CELLAPI/lib/libannotools.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libannotools.2.dylib
cp $CELLAPI/lib/libcuses.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libcuses.1.dylib
cp $CELLAPI/lib/libtelicems.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libtelicems.1.dylib

# fix cellml libraries
install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libcevas.1.dylib

install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libannotools.2.dylib

install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libcuses.1.dylib
install_name_tool -change libannotools.2.dylib "@rpath/libannotools.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libcuses.1.dylib

install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/libtelicems.1.dylib

# fix ids of libraries
install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
install_name_tool -change libcevas.1.dylib "@rpath/libcevas.1.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
install_name_tool -change libannotools.2.dylib "@rpath/libannotools.2.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
install_name_tool -change libcuses.1.dylib "@rpath/libcuses.1.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
install_name_tool -change libtelicems.1.dylib "@rpath/libtelicems.1.dylib" $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so

install_name_tool -add_rpath "@loader_path/." $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so

# build binary wheel
cd $ANTIMONY_INSTALL/bindings/python
python2 setup.py bdist_wheel --python-tag=cp27 --plat-name=manylinux1-x86_64
# fix ABI tag
# http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'antimony*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp27mu}" ' -- \{\} \;
cd ..

echo "Now do something like /Library/Frameworks/Python.framework/Versions/2.7/bin/twine upload -s --sign-with gpg2 -i 9BE0E97B /Users/phantom/devel/install/antimony-trunk-py2m/bindings/python/dist/ ..."
