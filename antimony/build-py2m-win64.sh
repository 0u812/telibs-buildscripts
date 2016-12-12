#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/c/Users/phantom/Documents/devel
PYTHON=/c/Python27-64/python.exe
PIP=/c/Python27-64/Scripts/pip2.exe
PYINCLUDE=/c/Python27-64/include
GIT=git
CELLAPI=$ROOT/install/cell-api
LIBSBML=$ROOT/install/libsbml-experimental
ANTIMONY_INSTALL=$ROOT/install/antimony-trunk-py2m
BZIP="C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libbz2.lib"
LIBXML="C:\Users\phantom\Documents\devel\src\libroadrunner-deps\third_party\dependencies\libsbml\lib\libxml2.lib"
ICONV="C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libiconv.lib"
ZLIB="C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/zdll.lib"
SWIG="C:/Users/phantom/Downloads/swig/swigwin-3.0.5/swig.exe "

mkdir -p $ROOT/build/antimony-trunk-py2m
cd $_
pwd
rm -rf *
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ANTIMONY_INSTALL -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI -DBZIP_LIBRARY=$BZIP -DICONV_LIBRARY=$ICONV -DLIBXML_LIBRARY=$LIBXML -DZDLL_LIBRARY=$ZLIB -DSWIG_EXECUTABLE=$SWIG -DEXTRA_LIBS="ws2_32.lib" $ROOT/src/antimony-trunk
cmake --build . --target install --config Release
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ANTIMONY_INSTALL -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI -DBZIP_LIBRARY=$BZIP -DICONV_LIBRARY=$ICONV -DLIBXML_LIBRARY=$LIBXML -DZDLL_LIBRARY=$ZLIB -DSWIG_EXECUTABLE=$SWIG -DEXTRA_LIBS="ws2_32.lib" $ROOT/src/antimony-trunk
cmake --build . --target install --config Release
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ANTIMONY_INSTALL -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI -DBZIP_LIBRARY=$BZIP -DICONV_LIBRARY=$ICONV -DLIBXML_LIBRARY=$LIBXML -DZDLL_LIBRARY=$ZLIB -DSWIG_EXECUTABLE=$SWIG -DEXTRA_LIBS="ws2_32.lib" $ROOT/src/antimony-trunk
cmake --build . --target install --config Release

# copy over cellml libs
cp $CELLAPI/lib/libcellml.dll $ANTIMONY_INSTALL/bindings/python/antimony/libcellml.dll
cp $CELLAPI/lib/libcevas.dll $ANTIMONY_INSTALL/bindings/python/antimony/libcevas.dll
cp $CELLAPI/lib/libannotools.dll $ANTIMONY_INSTALL/bindings/python/antimony/libannotools.dll
cp $CELLAPI/lib/libcuses.dll $ANTIMONY_INSTALL/bindings/python/antimony/libcuses.dll
cp $CELLAPI/lib/libtelicems.dll $ANTIMONY_INSTALL/bindings/python/antimony/libtelicems.dll

# copy over c++ libs
cp ~/msvc_runtimes $ANTIMONY_INSTALL/bindings/python/antimony

# build binary wheel
cd $ANTIMONY_INSTALL/bindings/python
$PIP install wheel twine
$PYTHON setup.py bdist_wheel --python-tag=cp27 --plat-name=manylinux1-x86_64
# fix ABI tag
# http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'antimony*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp27m}" ' -- \{\} \;
cd ..

echo "Now do something like twine upload -s --sign-with gpg -i 9BE0E97B /whlbldr/install/antimony-trunk-py2m/bindings/python/dist/ ..."
