#! /usr/bin/env bash

# exit on failure
set -e

# set SDK root
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"

# ** zipper **

cd ../
if [ ! -d zipper ]; then
  git clone git@github.com:fbergmann/zipper.git zipper
fi
cd zipper
git submodule update --init --recursive
git pull

cd ../../build
mkdir -p zipper-xcode
cd zipper-xcode
echo "Creating CMake project in build directory " `pwd` " for source " `cd ../../src/zipper`
cmake -G"Xcode" -DCMAKE_INSTALL_PREFIX=../../install/zipper-xcode CMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DWITH_BOOST_FILESYSTEM=ON -DBOOST_ROOT=/Users/phantom/etc/install/boost-1.59 -DBOOST_INCLUDE_DIR=/Users/phantom/etc/install/boost-1.59/include -DBOOST_FILESYSTEM_LIBRARY=/Users/phantom/etc/install/boost-1.59/lib/libboost_filesystem.a ../../src/zipper
xcodebuild -configuration Release build install -target install

# ** libcombine **

cd ../
if [ ! -d libcombine ]; then
  git clone git@github.com:sbmlteam/libCombine.git libcombine
fi
cd libcombine
git pull

cd ../../build
mkdir -p libcombine-xcode
cd libcombine-xcode
echo "Creating CMake project in build directory " `pwd` " for source " `cd ../../src/libcombine`
cmake -G"Xcode" -DCMAKE_INSTALL_PREFIX=../../install/libcombine-xcode CMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DLIBSBML_LIBRARY=/Users/phantom/etc/install/libsbml-5.13.0-experimental/lib/libsbml-static.a -DLIBSBML_INCLUDE_DIR=/Users/phantom/etc/install/libsbml-5.13.0-experimental/include -DLIBSBML_STATIC=ON -DEXTRA_LIBS='xml2;bz2;z;iconv' -DWITH_PYTHON=ON -DPYTHON_USE_DYNAMIC_LOOKUP=ON ../../src/libcombine
