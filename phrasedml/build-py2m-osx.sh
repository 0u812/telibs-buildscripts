#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`

PYTHON=/usr/local/bin/python2
PYLIB=/Library/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib
PYINCLUDE=/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7

LIBSBML_PREFIX=~/devel/install/libsbml-experimental-xcode
LIBSBML=$LIBSBML_PREFIX/lib/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_PREFIX/include

LIBNUML_PREFIX=/Users/phantom/devel/install/libnuml-xcode
LIBNUML=$LIBNUML_PREFIX/lib/libnuml-static.a
LIBNUML_INCLUDE=$LIBNUML_PREFIX/include

LIBSEDML_PREFIX=/Users/phantom/devel/install/libsedml-xcode
LIBSEDML=$LIBSEDML_PREFIX/lib/libsedml-static.a
LIBSEDML_INCLUDE=$LIBSEDML_PREFIX/include

INSTALL_PREFIX=/Users/phantom/devel/install
INSTALL_DIR=$INSTALL_PREFIX/phrasedml-xcode-py2m

mkdir -p ~/devel/build/phrasedml-xcode-py2m
cd $_
pwd
cmake -GXcode -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DLIBSEDML_LIBRARY=$LIBSEDML -DLIBSEDML_INCLUDE_DIR=$LIBSEDML_INCLUDE -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBNUML_LIBRARY=$LIBNUML -DLIBNUML_INCLUDE_DIR=$LIBNUML_INCLUDE -DEXTRA_LIBS='xml2;bz2;z;iconv' -DWITH_PYTHON=ON -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_LIBRARY=$PYLIB -DPYTHON_INCLUDE_DIR=$PYINCLUDE ~/devel/src/phrasedml

xcodebuild -target install -configuration Release

cd $INSTALL_DIR/bindings/python
python2 setup.py bdist_wheel --python-tag=cp27 --plat-name=macosx-10.9-x86_64

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'phrasedml*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp27m}" ' -- \{\} \;
cd ..

echo "Now do something like /Library/Frameworks/Python.framework/Versions/2.7/bin/twine upload -s --sign-with gpg2 -i 9BE0E97B $INSTALL_DIR/bindings/python/dist/ ..."
