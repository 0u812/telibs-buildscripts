#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

OS_STR=win64
ROOT=/c/Users/phantom/Documents/devel
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR

CMAKE="C:/Users/phantom/Downloads/cmake-3.7.0-win64-x64/bin/cmake"
CMAKE_GEN=-G"Visual Studio 14 2015 Win64"
CMAKE_PLATFORM_FLAGS=
CMAKE_BUILD_CMD="xcodebuild -configuration Release build install -target install"

# libSBML
LIBSBML_INSTNAME=libsbml-experimental-$OS_STR
LIBSBML_INSTALL_DIR=$ROOT/install/$LIBSBML_INSTNAME
LIBSBML=$LIBSBML_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_INSTALL_DIR/include
LIBSBML_EXTRA_LIBS='xml2;bz2;z;iconv'

# libNuML
LIBNUML_INSTALL_DIR=$ROOT/install/libnuml-$OS_STR
NUML=$LIBNUML_INSTALL_DIR/lib/libnuml-static.a
NUML_INCLUDE=$LIBNUML_INSTALL_DIR/include

# CellML
OMNIIDL="C:\Users\phantom\Documents\exc\src\omniORB-4.2.1-2\omniORB-4.2.1\bin\x86_win32\omniidl.exe"
BISON="C:/Users/phantom/Downloads/win_flex_bison-2.5.6/win_bison.exe"
FLEX="C:/Users/phantom/Downloads/win_flex_bison-2.5.6/win_flex.exe"
FLEXINCL="C:/Users/phantom/Downloads/win_flex_bison-2.5.6"
CELL_API_CXX_FLAGS="/DWIN32_LEAN_AND_MEAN /IC:\Users\phantom\Downloads\win_flex_bison-2.5.6"
