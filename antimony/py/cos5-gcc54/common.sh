#/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# build the project
source "$( dirname "${BASH_SOURCE[0]}" )"/../../cos5-gcc54.sh
# copy over __init__.py
# cp $THIS_DIR/__init__.py $ROOT/install/$INSTNAME/lib/python${PYVER2}/site-packages/$SRCNAME

cd $ROOT/install/$INSTNAME/bindings/python

$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=$WHEEL_PLATFORM

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
