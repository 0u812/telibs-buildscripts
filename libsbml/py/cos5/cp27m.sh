#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

export CPVER=cp27
export CP=cp27m
PYTHON_DIR=/opt/python/cp27-cp27m
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python2.7

# build the project
source "$( dirname "${BASH_SOURCE[0]}" )"/../../cos5.sh
# copy over setup.py
cp $THIS_DIR/setup.py $ROOT/install/$INSTNAME/lib/python2.7/site-packages
# rename libsbml.py to __init__.py
mv $ROOT/install/$INSTNAME/lib/python2.7/site-packages/libsbml/libsbml.py $ROOT/install/$INSTNAME/lib/python2.7/site-packages/libsbml/__init__.py
cd $ROOT/install/$INSTNAME/lib/python2.7/site-packages
$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=macosx-10.9-x86_64

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
