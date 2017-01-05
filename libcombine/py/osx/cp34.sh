#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`

export CP=cp34
PYTHON_DIR=/Users/phantom/.pyenv/versions/3.4.5
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python3.4m

# build the project
source $THIS_DIR/../../libcombine-osx-10.9.sh
# copy over setup.py
cp $THIS_DIR/setup.py $ROOT/install/$INSTNAME/lib/python3.4/site-packages
# rename libcombine.py to __init__.py per Frank
mv $ROOT/install/$INSTNAME/lib/python3.4/site-packages/libcombine/libcombine.py $ROOT/install/$INSTNAME/lib/python3.4/site-packages/libcombine/__init__.py
cd $ROOT/install/$INSTNAME/lib/python3.4/site-packages
$PYTHON setup.py bdist_wheel --python-tag=$CP --plat-name=macosx-10.9-x86_64

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'libcombine*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}m}" ' -- \{\} \;
cd ..
cp dist/* ~/wheelhouse
