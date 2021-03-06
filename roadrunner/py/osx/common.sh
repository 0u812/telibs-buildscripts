#/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

NUMPY_INCLUDE=$PYTHON_DIR/lib/python${PYVER2}/site-packages/numpy/core/include

# build the project
source "$( dirname "${BASH_SOURCE[0]}" )"/../../osx-10.9.sh

cd $ROOT/install/$INSTNAME

$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=$WHEEL_PLATFORM

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
