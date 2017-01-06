#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=~/devel

export CPVER=cp35
export CP=cp35m
PYTHON_DIR=/Users/phantom/.pyenv/versions/3.5.2
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python3.5m
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR

# build the project
source $THIS_DIR/../../sbml2matlab-osx-10.9.sh
# copy over setup.py
cp $THIS_DIR/setup.py $ROOT/install/$INSTNAME/lib/python3.5/site-packages
# rename libcombine.py to __init__.py per Frank
mv $ROOT/install/$INSTNAME/lib/python3.5/site-packages/sbml2matlab/sbml2matlab.py $ROOT/install/$INSTNAME/lib/python3.5/site-packages/sbml2matlab/__init__.py
cd $ROOT/install/$INSTNAME/lib/python3.5/site-packages
$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=macosx-10.9-x86_64

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
