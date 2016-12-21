#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/whlbldr

PYTHON=/opt/python/cp27-cp27mu/bin/python2
PIP=/opt/python/cp27-cp27mu/bin/pip2
PYINCLUDE=/opt/python/cp27-cp27mu/include/python2.7

LIBSBML_PREFIX=$ROOT/install/libsbml-experimental-cpp03
LIBSBML_LIB_DIR=$LIBSBML_PREFIX/lib
LIBSBML=$LIBSBML_LIB_DIR/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_PREFIX/include

LIBNUML_PREFIX=$ROOT/install/libnuml
LIBNUML=$LIBNUML_PREFIX/lib/libnuml-static.a
LIBNUML_INCLUDE=$LIBNUML_PREFIX/include

LIBSEDML_PREFIX=$ROOT/install/libsedml
LIBSEDML=$LIBSEDML_PREFIX/lib/libsedml-static.a
LIBSEDML_INCLUDE=$LIBSEDML_PREFIX/include

SWIG=/whlbldr/install/swig/bin/swig

INSTALL_PREFIX=$ROOT/install
INSTALL_DIR=$INSTALL_PREFIX/phrasedml-py2m

mkdir -p $ROOT/build/phrasedml-py2m
cd $_
pwd
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release -DLIBSEDML_LIBRARY=$LIBSEDML -DLIBSEDML_INCLUDE_DIR=$LIBSEDML_INCLUDE -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBNUML_LIBRARY=$LIBNUML -DLIBNUML_INCLUDE_DIR=$LIBNUML_INCLUDE -DWITH_PYTHON=ON -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_LIBRARY=$PYLIB -DPYTHON_INCLUDE_DIR=$PYINCLUDE -DSWIG_EXECUTABLE=$SWIG -DEXTRA_LIBS="z;bz2" $ROOT/src/phrasedml

make -j4 && make install

cd $INSTALL_DIR/bindings/python
$PYTHON setup.py bdist_wheel --python-tag=cp27 --plat-name=manylinux1-x86_64

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'phrasedml*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp27mu}" ' -- \{\} \;
cd ..

echo "Now do something like /opt/python/cp27-cp27mu/bin/twine upload -s --sign-with gpg2 -i 9BE0E97B $INSTALL_DIR/bindings/python/dist/ ..."
