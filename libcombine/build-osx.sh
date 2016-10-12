#! /usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# set SDK root
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk

LIBSBML_STATIC=/Users/phantom/etc/install/libsbml-5.13.0-experimental/lib/libsbml-static.a
CONDADIR=/Users/phantom/miniconda2
CONDA=$CONDADIR/bin/conda
PYTHON=$CONDADIR/bin/python
LIBCOMBINE_VERSION="0.1.0"

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THISDIR=`pwd`

while [ ! -d ".git" ]; do
  cd ..
done

cd ../..
DEVROOT=`pwd`
SRCROOT=$DEVROOT/src
BLDROOT=$DEVROOT/build
INSROOT=$DEVROOT/install

echo "Using DEVROOT $DEVROOT"

# ** zipper **

cd $SRCROOT
if [ ! -d zipper ]; then
  git clone git@github.com:fbergmann/zipper.git zipper
fi
cd zipper
git submodule update --init --recursive
git pull

cd $BLDROOT
mkdir -p zipper-xcode
cd zipper-xcode
echo "Creating CMake project in build directory " `pwd` " for source " `cd ../../src/zipper`
cmake -G"Xcode" -DCMAKE_INSTALL_PREFIX=$INSROOT/zipper-xcode CMAKE_OSX_DEPLOYMENT_TARGET=10.10 -DWITH_BOOST_FILESYSTEM=ON -DBOOST_ROOT=/Users/phantom/etc/install/imac/boost-1.59 -DBOOST_INCLUDE_DIR=/Users/phantom/etc/install/imac/boost-1.62/include -DBOOST_FILESYSTEM_LIBRARY=/Users/phantom/etc/install/imac/boost-1.62/lib/libboost_filesystem.a -DBOOST_SYSTEM_LIBRARY=/Users/phantom/etc/install/imac/boost-1.62/lib/libboost_system.a ../../src/zipper
xcodebuild -configuration Release build install -target install

# ** merge the fuckers **
mkdir -p $BLDROOT/libcombine-dep-merged
libtool -o libcombine-dep-merged.a $INSROOT/zipper-xcode/lib/libZipper-static.a $LIBSBML_STATIC /Users/phantom/etc/install/imac/boost-1.62/lib/libboost_system.a /Users/phantom/etc/install/imac/boost-1.62/lib/libboost_filesystem.a
MERGED_LIB=$(pwd)/libcombine-dep-merged.a
echo "Merged dep libs: $MERGED_LIB"

# ** libcombine **

cd $SRCROOT
if [ ! -d libcombine ]; then
  git clone git@github.com:sbmlteam/libCombine.git libcombine
fi
cd libcombine
git pull

cd ../../build
mkdir -p libcombine-xcode
cd libcombine-xcode
echo "Creating CMake project in build directory " `pwd` " for source " `cd ../../src/libcombine`
cmake -G"Xcode" -DCMAKE_INSTALL_PREFIX=$INSROOT/libcombine-xcode CMAKE_OSX_DEPLOYMENT_TARGET=10.10 -DLIBSBML_LIBRARY=$MERGED_LIB -DLIBSBML_INCLUDE_DIR=/Users/phantom/etc/install/libsbml-5.13.0-experimental/include -DLIBSBML_STATIC=ON -DEXTRA_LIBS='xml2;bz2;z;iconv' -DZIPPER_INCLUDE_DIR=/Users/phantom/devel/install/zipper-xcode/include -DZIPPER_LIBRARY=$MERGED_LIB -DWITH_PYTHON=ON -DPYTHON_LIBRARY=$CONDADIR/lib/libpython2.7.dylib -DPYTHON_INCLUDE_DIR=$CONDADIR/include/python2.7 -DPYTHON_EXECUTABLE=$CONDADIR/bin/python -DPYTHON_USE_DYNAMIC_LOOKUP=ON ../../src/libcombine
xcodebuild -configuration Release build install -target install

# ** make setup.py for libcombine **

cd $THISDIR
$PYTHON -c "f = open('meta.yaml.in'); s=f.read(); print(s.format(version='$LIBCOMBINE_VERSION'))" >$INSROOT/libcombine-xcode/lib/python2.7/site-packages/meta.yaml
$PYTHON -c "f = open('setup.py.in');  s=f.read(); print(s.format(version='$LIBCOMBINE_VERSION'))" >$INSROOT/libcombine-xcode/lib/python2.7/site-packages/setup.py
# rename libcombine.py to __init__.py per Frank
mv $INSROOT/libcombine-xcode/lib/python2.7/site-packages/libcombine/libcombine.py $INSROOT/libcombine-xcode/lib/python2.7/site-packages/libcombine/__init__.py
cp $THISDIR/{bld.bat,build.sh} $INSROOT/libcombine-xcode/lib/python2.7/site-packages
cd $INSROOT/libcombine-xcode/lib/python2.7/site-packages
$CONDA build .
# do something like
#~/miniconda2/bin/anaconda upload /Users/phantom/miniconda2/conda-bld/osx-64/libcombine-0.1.0-0.tar.bz2
