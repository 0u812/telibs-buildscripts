#/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# build the project
source "$( dirname "${BASH_SOURCE[0]}" )"/../../cos5.sh

# fix dep libs
cp /usr/lib64/libbz2.so.1.0.3 $ROOT/install/$INSTNAME/site-packages/roadrunner/libbz2.so.1
cp /usr/lib64/libxml2.so.2.6.26 $ROOT/install/$INSTNAME/site-packages/roadrunner/libxml2.so.2
cp /lib64/libz.so.1.2.3 $ROOT/install/$INSTNAME/site-packages/roadrunner/libz.so.1
patchelf --set-rpath '$ORIGIN/.' $ROOT/install/$INSTNAME/site-packages/roadrunner/_$SRCNAME.so

cd $ROOT/install/$INSTNAME

$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=$WHEEL_PLATFORM

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
