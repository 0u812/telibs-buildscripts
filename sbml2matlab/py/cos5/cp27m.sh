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
# copy over __init__.py
cp $THIS_DIR/__init__.py $ROOT/install/$INSTNAME/lib/python2.7/site-packages/sbml2matlab/

# fix dep libs
cp /usr/lib64/libbz2.so.1.0.3 $ROOT/install/$INSTNAME/lib/python2.7/site-packages/sbml2matlab/libbz2.so.1
cp /usr/lib64/libxml2.so.2.6.26 $ROOT/install/$INSTNAME/lib/python2.7/site-packages/sbml2matlab/libxml2.so.2
cp /lib64/libz.so.1.2.3 $ROOT/install/$INSTNAME/lib/python2.7/site-packages/sbml2matlab/libz.so.1
patchelf --set-rpath '$ORIGIN/.' $ROOT/install/$INSTNAME/lib/python2.7/site-packages/sbml2matlab/_sbml2matlab.so

cd $ROOT/install/$INSTNAME/lib/python2.7/site-packages

# build wheel
$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=$WHEEL_PLATFORM

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
