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

NUMPY_INCLUDE=/opt/python/cp27-cp27m/lib/python2.7/site-packages/numpy/core/include

CMAKE=/whlbldr/tools/bin/cmake
CMAKE_GEN="-GUnix Makefiles"
CMAKE_PLATFORM_FLAGS=( -DCMAKE_CXX_FLAGS="-I$NUMPY_INCLUDE" )
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

if [[ "$LIBSBMLNS" == "OFF" ]]; then
  LIBSBML_NSSTR="-nons"
else
  LIBSBML_NSSTR=
fi

# libSBML
LIBSBML_INSTNAME=libsbml-experimental-$OS_STR$LIBSBML_NSSTR
LIBSBML_INSTALL_DIR=$ROOT/install/$LIBSBML_INSTNAME
LIBSBML_STATIC=$LIBSBML_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_INSTALL_DIR/include
LIBSBML_EXTRA_LIBS='xml2;bz2;z'

# libNuML
LIBNUML_INSTALL_DIR=$ROOT/install/libnuml-$OS_STR$LIBSBML_NSSTR
LIBNUML=$LIBNUML_INSTALL_DIR/lib/libnuml-static.a
LIBNUML_INCLUDE=$LIBNUML_INSTALL_DIR/include

# CellML
OMNIIDL=/whlbldr/install/omniorb-4.2.1/bin/omniidl
BISON=/whlbldr/install/bison-3.0.4/bin/bison
FLEX=/whlbldr/install/flex-2.6.2/bin/flex
FLEXINCL=/whlbldr/install/flex-2.6.2/include
CELL_API_CXX_FLAGS="-std=c++11 -I/whlbldr/install/flex-2.6.2/include"

# zipper
ZIPPER_INSTNAME=zipper-$OS_STR
ZIPPER_INSTALL_DIR=$ROOT/install/$ZIPPER_INSTNAME
ZIPPER=$ZIPPER_INSTALL_DIR/lib/libZipper-static.a
ZIPPER_INCLUDE_DIR=$ZIPPER_INSTALL_DIR/include

# libSEDML
LIBSEDML_INSTNAME=libsedml-$OS_STR$LIBSBML_NSSTR
LIBSEDML_INSTALL_DIR=$ROOT/install/$LIBSEDML_INSTNAME
LIBSEDML=$LIBSEDML_INSTALL_DIR/lib/libsedml-static.a
LIBSEDML_INCLUDE=$LIBSEDML_INSTALL_DIR/include

# roadrunner
LLVM_CONFIG=/whlbldr/install/llvm-3.3/bin/llvm-config
RR_CPP11=FALSE
RR_TR1_NS=TRUE