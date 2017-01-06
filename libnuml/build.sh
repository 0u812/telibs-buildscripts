#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`

SRCNAME=libnuml
INSTNAME=$SRCNAME-$OS_STR

export CMAKE_PREFIX_PATH="$LIBSBML_INSTALL_DIR/lib/cmake"

mkdir -p $ROOT/build/$INSTNAME
cd $_
rm -rf *
cmake $CMAKE_GEN $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DEXTRA_LIBS=$LIBSBML_EXTRA_LIBS $ROOT/src/NuML/$SRCNAME
eval $CMAKE_BUILD_CMD
