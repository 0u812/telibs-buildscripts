#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

export CPVER=cp34
export CP=cp34m
PYTHON_DIR=/Users/phantom/.pyenv/versions/3.4.5
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python3.4m

# build the project
source "$( dirname "${BASH_SOURCE[0]}" )"/../../$OS_NAME.sh
# copy over setup.py
cp $THIS_DIR/setup.py $ROOT/install/$INSTNAME/lib/python3.4/site-packages
# copy over __init__.py
cp $THIS_DIR/__init__.py $ROOT/install/$INSTNAME/lib/python3.4/site-packages/libsedml

cd $ROOT/install/$INSTNAME/lib/python3.4/site-packages
$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=macosx-10.9-x86_64

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
