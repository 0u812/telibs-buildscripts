#! /usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

LIBSBML_STATIC=/home/user/devel/install/libsbml-experimental/lib/libsbml-static.a
CONDADIR=/home/user/anaconda2
CONDA=$CONDADIR/bin/conda
PYTHON=$CONDADIR/bin/python
LIBCOMBINE_VERSION="0.1.0"

export PATH=/home/user/exc/install/gcc-5.4.0/bin:$PATH
export CC=/home/user/exc/install/gcc-5.4.0/bin/gcc
export CXX=/home/user/exc/install/gcc-5.4.0/bin/g++
export LD_LIBRARY_PATH=/home/user/exc/install/gcc-5.4.0/lib:$LD_LIBRARY_PATH

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
mkdir -p zipper
cd zipper
echo "Creating CMake project in build directory " `pwd` " for source " `cd ../../src/zipper`
cmake -DCMAKE_INSTALL_PREFIX=$INSROOT/zipper -DCMAKE_CXX_FLAGS="-std=c++17" -DWITH_BOOST_FILESYSTEM=ON -DBOOST_ROOT=/home/user/exc/install/boost-1.62 -DBOOST_INCLUDE_DIR=/home/user/exc/install/boost-1.62/include -DBOOST_FILESYSTEM_LIBRARY=/home/user/exc/install/boost-1.62/lib/libboost_filesystem.a -DBOOST_SYSTEM_LIBRARY=/home/user/exc/install/boost-1.62/lib/libboost_system.a ../../src/zipper
make -j4 install

# ** libcombine **

cd $SRCROOT
if [ ! -d libcombine ]; then
  git clone git@github.com:sbmlteam/libCombine.git libcombine
fi
cd libcombine
git pull

cd ../../build
mkdir -p libcombine
cd libcombine
echo "Creating CMake project in build directory " `pwd` " for source " `cd ../../src/libcombine`
cmake -DCMAKE_INSTALL_PREFIX=$INSROOT/libcombine -DCMAKE_CXX_FLAGS="-std=c++17" -DLIBSBML_LIBRARY=$LIBSBML_STATIC -DLIBSBML_INCLUDE_DIR=/home/user/devel/install/libsbml-experimental/include -DLIBSBML_STATIC=ON -DEXTRA_LIBS='xml2;bz2;z;/home/user/exc/install/boost-1.62/lib/libboost_system.a;/home/user/exc/install/boost-1.62/lib/libboost_filesystem.a' -DZIPPER_INCLUDE_DIR=/home/user/devel/install/zipper/include -DZIPPER_LIBRARY=$INSROOT/zipper/lib/libZipper-static.a -DWITH_PYTHON=ON -DPYTHON_LIBRARY=$CONDADIR/lib/libpython2.7.so -DPYTHON_INCLUDE_DIR=$CONDADIR/include/python2.7 -DPYTHON_EXECUTABLE=$CONDADIR/bin/python -DPYTHON_USE_DYNAMIC_LOOKUP=ON ../../src/libcombine
make -j4 install

# ** make setup.py for libcombine **

cd $THISDIR
$PYTHON -c "f = open('meta.yaml.in'); s=f.read(); print(s.format(version='$LIBCOMBINE_VERSION'))" >$INSROOT/libcombine/lib/python2.7/site-packages/meta.yaml
$PYTHON -c "f = open('setup.py.in');  s=f.read(); print(s.format(version='$LIBCOMBINE_VERSION'))" >$INSROOT/libcombine/lib/python2.7/site-packages/setup.py
# rename libcombine.py to __init__.py per Frank
mv $INSROOT/libcombine/lib/python2.7/site-packages/libcombine/libcombine.py $INSROOT/libcombine/lib/python2.7/site-packages/libcombine/__init__.py
cp $THISDIR/{bld.bat,build.sh} $INSROOT/libcombine/lib/python2.7/site-packages
cd $INSROOT/libcombine/lib/python2.7/site-packages
$CONDA build .
# do something like
#~/miniconda2/bin/anaconda upload /home/user/miniconda2/conda-bld/osx-64/libcombine-0.1.0-0.tar.bz2
