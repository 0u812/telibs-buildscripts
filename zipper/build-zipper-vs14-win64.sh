#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/c/Users/phantom/Documents/devel
CMAKE="C:\Users\phantom\Downloads\cmake-3.7.0-win64-x64\bin\cmake.exe"
NAME=zipper-vs14-win64

INSTALL_DIR=$ROOT/install/$NAME

ZLIB="C:/Users/phantom/Documents/devel/src/libroadrunner-deps/third_party/dependencies/libsbml/lib/zdll.lib"
ZLIB_INCLUDE_DIR="C:/Users/phantom/Documents/devel/src/libroadrunner-deps/third_party/dependencies/libsbml/include"

mkdir -p $ROOT/build/$NAME
cd $_
pwd
rm -rf *
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DLIBZ_LIBRARY=$ZLIB -DLIBZ_INCLUDE_DIR=$ZLIB_INCLUDE_DIR $ROOT/src/zipper
"$CMAKE" --build . --target install --config Release
