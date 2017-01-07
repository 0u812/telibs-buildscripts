#/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

export LD_LIBRARY_PATH=/whlbldr/install/gcc-5.4.0/lib64:$LD_LIBRARY_PATH
export PATH=/whlbldr/install/gcc-5.4.0/bin:$PATH
export PATH=/whlbldr/tools/bin:$PATH
export PATH=/whlbldr/install/bison-3.0.4/bin:$PATH
export PATH=/whlbldr/install/flex-2.6.2/bin:$PATH
export CC=`which gcc`
export CXX=`which g++`

OS_STR=cos5-gcc54
ROOT=/whlbldr
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR

CMAKE=cmake
CMAKE_GEN="-GUnix Makefiles"
CMAKE_PLATFORM_FLAGS=
CMAKE_BUILD_CMD="make -j4 && make install"

# libSBML
LIBSBML_INSTNAME=libsbml-experimental-$OS_STR
LIBSBML_INSTALL_DIR=$ROOT/install/$LIBSBML_INSTNAME
LIBSBML=$LIBSBML_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_INSTALL_DIR/include
LIBSBML_EXTRA_LIBS='xml2;bz2;z'

# libNuML
LIBNUML_INSTALL_DIR=$ROOT/install/libnuml-$OS_STR
NUML=$LIBNUML_INSTALL_DIR/lib/libnuml-static.a
NUML_INCLUDE=$LIBNUML_INSTALL_DIR/include

# CellML
OMNIIDL=/whlbldr/install/omniorb-4.2.1/bin/omniidl
BISON=bison
FLEX=flex
FLEXINCL=/whlbldr/install/flex-2.6.2/include
CELL_API_CXX_FLAGS="-std=c++11 -I/whlbldr/install/flex-2.6.2/include"
