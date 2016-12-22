#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/c/Users/phantom/Documents/devel
CMAKE="C:\Users\phantom\Downloads\cmake-3.7.0-win64-x64\bin\cmake.exe"

PYTHON=/c/Python27-64/python.exe
PYTHON_LIB="C:\Python27-64\libs\python27.lib"
PIP=/c/Python27-64/Scripts/pip2.exe
PYINCLUDE=/c/Python27-64/include

LIBSBML_PREFIX=$ROOT/install/libsbml-experimental
LIBSBML_LIB_DIR=$LIBSBML_PREFIX/lib
LIBSBML=$LIBSBML_LIB_DIR/libsbml-static.lib
LIBSBML_INCLUDE=$LIBSBML_PREFIX/include

LIBNUML_PREFIX=$ROOT/install/libnuml
LIBNUML=$LIBNUML_PREFIX/lib/libnuml-static.lib
LIBNUML_INCLUDE=$LIBNUML_PREFIX/include

LIBSEDML_PREFIX=$ROOT/install/libsedml
LIBSEDML=$LIBSEDML_PREFIX/lib/libsedml-static.lib
LIBSEDML_INCLUDE=$LIBSEDML_PREFIX/include

SWIG="C:/Users/phantom/Downloads/swig/swigwin-3.0.5/swig.exe "

BZIP="C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libbz2.lib"
LIBXML="C:\Users\phantom\Documents\devel\src\libroadrunner-deps\third_party\dependencies\libsbml\lib\libxml2.lib"
ICONV="C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libiconv.lib"
ZLIB="C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/zdll.lib"

INSTALL_PREFIX=$ROOT/install
INSTALL_DIR=$INSTALL_PREFIX/phrasedml-cp27m

mkdir -p $ROOT/build/phrasedml-cp27m
cd $_
pwd
#rm -rf *
"$CMAKE" -G"Visual Studio 14 2015 Win64" -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release -DLIBSEDML_LIBRARY=$LIBSEDML -DLIBSEDML_INCLUDE_DIR=$LIBSEDML_INCLUDE -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBNUML_LIBRARY=$LIBNUML -DLIBNUML_INCLUDE_DIR=$LIBNUML_INCLUDE -DWITH_PYTHON=ON -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_LIBRARY=$PYTHON_LIB -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DSWIG_EXECUTABLE=$SWIG -DEXTRA_LIBS="C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libxml2.lib;C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/zdll.lib;C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libiconv.lib;ws2_32.lib" -DICONV_LIBRARY=$ICONV -DLIBXML_LIBRARY=$LIBXML $ROOT/src/phrasedml

"$CMAKE" --build . --target install --config Release

# copy over c++ libs
cp $INSTALL_DIR/bin/{msvcp140.dll,vcruntime140.dll} $INSTALL_DIR/bindings/python/phrasedml

cd $INSTALL_DIR/bindings/python
$PYTHON setup.py bdist_wheel --python-tag=cp27 --plat-name=win_amd64

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'phrasedml*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp27m}" ' -- \{\} \;
cd ..

echo "Now do something like twine upload -s --sign-with gpg2 -i 9BE0E97B $INSTALL_DIR/bindings/python/dist/ ..."
