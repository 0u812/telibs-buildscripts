#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

ISWIN=TRUE

OS_STR=win64-vs14
ROOT="C:/Users/phantom/Documents/devel"
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR
WHEEL_PLATFORM=win_amd64
EVSEP=";"

CMAKE="C:/Users/phantom/Downloads/cmake-3.7.0-win64-x64/bin/cmake"
CMAKE_GEN=-G"Visual Studio 14 2015 Win64"
CMAKE_PLATFORM_FLAGS=( "-DCMAKE_CXX_FLAGS=-I$NUMPY_INCLUDE" )
CMAKE_BUILD_CMD="\"$CMAKE\" --build . --target install --config Release"
SWIG="C:/Users/phantom/Downloads/swig/swigwin-3.0.5/swig.exe"

# runtimes
VCRUNTIME1="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/bin/msvcp140.dll"
VCRUNTIME2="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/bin/vcruntime140.dll"
VCRUNTIMES=( "$VCRUNTIME1" "$VCRUNTIME2" )

# libSBML deps
LIBBZIP2="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/lib/libbz2.lib"
LIBBZIP2_INCLUDE="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/include"
LIBICONV="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/lib/libiconv.lib"
LIBXML2="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/lib/libxml2.lib"
LIBXML2_INCLUDE="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/include"
ZLIB="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/lib/zdll.lib"
ZLIB_INCLUDE="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/include"
CMAKE_ICONV_FLAGS=( -DLIBICONV_LIBRARY="$LIBICONV" )

if [[ "$LIBSBMLNS" == "OFF" ]]; then
  LIBSBML_NSSTR="-nons"
else
  LIBSBML_NSSTR=
fi

# libSBML
LIBSBML_INSTNAME=libsbml-experimental-$OS_STR$LIBSBML_NSSTR
LIBSBML_INSTALL_DIR=$ROOT/install/$LIBSBML_INSTNAME
LIBSBML_STATIC=$LIBSBML_INSTALL_DIR/lib/libsbml-static.lib
LIBSBML_INCLUDE=$LIBSBML_INSTALL_DIR/include
LIBSBML_EXTRA_LIBS="$LIBXML2;$LIBBZIP2;$ZLIB;$LIBICONV;ws2_32.lib"

# libNuML
LIBNUML_INSTALL_DIR=$ROOT/install/libnuml-$OS_STR$LIBSBML_NSSTR
LIBNUML=$LIBNUML_INSTALL_DIR/lib/libnuml-static.lib
LIBNUML_INCLUDE=$LIBNUML_INSTALL_DIR/include

# CellML
OMNIIDL="C:\Users\phantom\Documents\exc\src\omniORB-4.2.1-2\omniORB-4.2.1\bin\x86_win32\omniidl.exe"
BISON="C:/Users/phantom/Downloads/win_flex_bison-2.5.6/win_bison.exe"
FLEX="C:/Users/phantom/Downloads/win_flex_bison-2.5.6/win_flex.exe"
FLEXINCL="C:/Users/phantom/Downloads/win_flex_bison-2.5.6"
CELL_API_CXX_FLAGS="//IC:\Users\phantom\Downloads\win_flex_bison-2.5.6"
CELLAPI=$ROOT/install/cell-api-$OS_STR

# Antimony
ANTIMONY_EXTRA_LIBS="ws2_32.lib"

# zipper
ZIPPER_INSTNAME=zipper-$OS_STR
ZIPPER_INSTALL_DIR=$ROOT/install/$ZIPPER_INSTNAME
ZIPPER=$ZIPPER_INSTALL_DIR/lib/libZipper-static.lib
ZIPPER_INCLUDE_DIR=$ZIPPER_INSTALL_DIR/include

# libSEDML
LIBSEDML_INSTNAME=libsedml-$OS_STR$LIBSBML_NSSTR
LIBSEDML_INSTALL_DIR=$ROOT/install/$LIBSEDML_INSTNAME
LIBSEDML=$LIBSEDML_INSTALL_DIR/lib/libsedml-static.lib
LIBSEDML_INCLUDE=$LIBSEDML_INSTALL_DIR/include

# roadrunner deps
#MC="C:/Program Files (x86)/Microsoft SDKs/Windows/v7.0A/Bin/MC.Exe"
RR_DEPS_WIN_SPECIFIC_OPTIONS=-DCMAKE_MC_COMPILER="C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin\MC.Exe"

# roadrunner
LLVM_CONFIG="C:/Users/phantom/Documents/exc/install/llvm-3.5.2-vs14-64/bin/llvm-config.exe"
RR_CPP11=FALSE
RR_TR1_NS=OFF
