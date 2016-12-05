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
ANTIMONY_INSTALL=/Users/phantom/devel/install/antimony-trunk-xcode-py2m

mkdir -p ~/devel/build/antimony-trunk-xcode-py2m
cd $_
pwd
cmake -GXcode -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ANTIMONY_INSTALL -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_LIBRARY=$PYLIB -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI  ~/devel/src/antimony-trunk
xcodebuild -configuration Release build install -target install
xcodebuild -configuration Release build install -target install
#xcodebuild -configuration Release build install -target install

# copy over cellml libs
cp $CELLAPI/lib/libcellml.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libcellml.2.dylib
cp $CELLAPI/lib/libcevas.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libcevas.1.dylib
cp $CELLAPI/lib/libannotools.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libannotools.2.dylib
cp $CELLAPI/lib/libcuses.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libcuses.1.dylib
cp $CELLAPI/lib/libtelicems.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/libtelicems.1.dylib

# fix binary
#install_name_tool -change libcellml.2.dylib libcellml.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
#install_name_tool -change libcevas.1.dylib libcevas.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
#install_name_tool -change libannotools.2.dylib libannotools.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
#install_name_tool -change libcuses.1.dylib libcuses.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so
#install_name_tool -change libtelicems.1.dylib libtelicems.1.13.dylib $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so

install_name_tool -add_rpath "@loader_path/." $ANTIMONY_INSTALL/bindings/python/antimony/_antimony.so

# build binary wheel
cd $ANTIMONY_INSTALL/bindings/python
python2 setup.py bdist_wheel --python-tag=cp27 --plat-name=macosx-10.9-x86_64
# fix ABI tag
# http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'antimony*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp27m}" ' -- \{\} \;
cd ..

echo "Now do something like /Library/Frameworks/Python.framework/Versions/2.7/bin/twine upload --sign 9BE0E97B $ANTIMONY_INSTALL/bindings/python/dist/..."
