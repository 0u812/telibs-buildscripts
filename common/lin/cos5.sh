#/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

OS_STR=cos5
ROOT=/whlbldr
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR
WHEEL_PLATFORM=manylinux1-x86_64

CMAKE=/whlbldr/tools/bin/cmake
CMAKE_GEN="-GUnix Makefiles"
CMAKE_PLATFORM_FLAGS=
CMAKE_BUILD_CMD="make -j4 && make install"
SWIG=/whlbldr/install/swig/bin/swig

# libSBML deps
LIBBZIP2=/usr/lib64/libbz2.so
LIBBZIP2_INCLUDE=/usr/include
LIBICONV=
LIBXML2=/usr/lib64/libxml2.so
LIBXML2_INCLUDE=/usr/include/libxml2
ZLIB=/usr/lib64/libz.so
ZLIB_INCLUDE=/usr/include
CMAKE_ICONV_FLAGS=

# libSBML
LIBSBML_INSTNAME=libsbml-experimental-$OS_STR
LIBSBML_INSTALL_DIR=$ROOT/install/$LIBSBML_INSTNAME
# LIBSBML=$LIBSBML_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_STATIC=$LIBSBML_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_INSTALL_DIR/include
LIBSBML_EXTRA_LIBS='xml2;bz2;z'

# libSBML no-ns
LIBSBML_NONS_INSTNAME=libsbml-experimental-$OS_STR-nons
LIBSBML_NONS_INSTALL_DIR=$ROOT/install/$LIBSBML_NONS_INSTNAME
LIBSBML_NONS_STATIC=$LIBSBML_NONS_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_NONS_INCLUDE=$LIBSBML_NONS_INSTALL_DIR/include
LIBSBML_NONS_EXTRA_LIBS='xml2;bz2;z'

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