#/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# build the project
source "$( dirname "${BASH_SOURCE[0]}" )"/../../win64-vs14.sh
# copy over setup.py
cp $THIS_DIR/setup.py $ROOT/install/$INSTNAME/bindings/python
# copy over __init__.py
cp $THIS_DIR/__init__.py $ROOT/install/$INSTNAME/bindings/python/$SRCNAME

# copy MSVC runtimes
for rt in ${VCRUNTIMES[*]}; do echo $rt && cp $rt $ROOT/install/$INSTNAME/bindings/python/$SRCNAME; done

cd $ROOT/install/$INSTNAME/bindings/python
# rename to tesbml
rm -rf tesbml
mv $SRCNAME tesbml

$PYTHON setup.py bdist_wheel --python-tag=$CPVER --plat-name=$WHEEL_PLATFORM

# fix ABI tag http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name '*none*' -type f -exec bash -c 'mv "$1" "${1/none/${CP}}" ' -- \{\} \;
cd ..
cp dist/* $WHEEL_DIR
