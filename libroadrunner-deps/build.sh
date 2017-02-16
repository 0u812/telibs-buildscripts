#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
SRCNAME=libroadrunner-deps
if [[ -z "${PYTHON+x}" ]]; then
  INSTNAME=$SRCNAME-$OS_STR
else
  INSTNAME=$SRCNAME-$OS_STR-$CP
fi

mkdir -p $ROOT/build/$INSTNAME
cd $_
pwd
rm -rf *
"$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME "$RR_DEPS_WIN_SPECIFIC_OPTIONS" $ROOT/src/$SRCNAME
eval $CMAKE_BUILD_CMD
