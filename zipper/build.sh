#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
SRCNAME=zipper
INSTNAME=$SRCNAME-$OS_STR

mkdir -p $ROOT/build/$INSTNAME
cd $_
rm -rf *
cmake "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBZ_LIBRARY="$ZLIB" -DLIBZ_INCLUDE_DIR="$ZLIB_INCLUDE" $ROOT/src/$SRCNAME
eval $CMAKE_BUILD_CMD
