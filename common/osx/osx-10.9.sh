#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

OSX_VER=10.9
OS_STR=osx-$OSX_VER
ROOT=~/devel
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_VER.sdk
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR
WHEEL_PLATFORM=macosx-10.9-x86_64
EVSEP=":"

CMAKE=cmake
CMAKE_GEN="-GXcode"
CMAKE_PLATFORM_FLAGS=( "-DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VER" "-DCMAKE_CXX_FLAGS=-I$NUMPY_INCLUDE" )
CMAKE_BUILD_CMD="xcodebuild -configuration Release build install -target install"
SWIG=/usr/local/bin/swig

# libSBML deps
LIBBZIP2=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/lib/libbz2.1.0.dylib
LIBBZIP2_INCLUDE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include
LIBICONV=
LIBXML2=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/lib/libxml2.2.dylib
LIBXML2_INCLUDE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/libxml2
ZLIB=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/lib/libz.1.2.5.dylib
ZLIB_INCLUDE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include
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
OMNIIDL=/Users/phantom/etc/install/omniorb-4.2.1/bin/omniidl
BISON=/usr/local/Cellar/bison/3.0.4/bin/bison
FLEX=/usr/bin/flex
FLEXINCL=/usr/include
CELL_API_CXX_FLAGS="-std=c++0x -stdlib=libc++"
CELLAPI=$ROOT/install/cell-api-osx-10.9

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
LLVM_CONFIG=/Users/phantom/etc/install/llvm-3.5.2-xcode/bin/llvm-config
RR_CPP11=FALSE
RR_TR1_NS=OFF
