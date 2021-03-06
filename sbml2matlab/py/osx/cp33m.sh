#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=~/devel

export CPVER=cp33
export CP=cp33m
PYTHON_DIR=/Users/phantom/.pyenv/versions/3.3.6
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python3.3m
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR

# build the project
source $THIS_DIR/../../osx-10.9.sh
# copy over setup.py
cp $THIS_DIR/setup.py $ROOT/install/$INSTNAME/lib/python3.3/site-packages
cp $THIS_DIR/__init__.py $ROOT/install/$INSTNAME/lib/python3.3/site-packages/sbml2matlab

cd $ROOT/install/$INSTNAME/lib/python3.3/site-packages
$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=macosx-10.9-x86_64

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
