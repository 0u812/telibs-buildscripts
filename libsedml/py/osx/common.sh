#/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# build the project
source "$( dirname "${BASH_SOURCE[0]}" )"/../../osx-10.9.sh
# copy over setup.py
cp $THIS_DIR/setup.py $ROOT/install/$INSTNAME/lib/python${PYVER2}/site-packages
# copy over __init__.py
cp $THIS_DIR/__init__.py $ROOT/install/$INSTNAME/lib/python${PYVER2}/site-packages/libsedml

cd $ROOT/install/$INSTNAME/lib/python${PYVER2}/site-packages
# rename to tesedml
rm -rf tesedml
mv libsedml tesedml

$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=macosx-10.9-x86_64

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
