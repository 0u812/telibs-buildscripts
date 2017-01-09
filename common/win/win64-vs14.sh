#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

OS_STR=win64-vs14
ROOT="C:/Users/phantom/Documents/devel"
export WHEEL_DIR=$ROOT/src/wheelhouse
mkdir -p $WHEEL_DIR

CMAKE="C:/Users/phantom/Downloads/cmake-3.7.0-win64-x64/bin/cmake"
CMAKE_GEN=-G"Visual Studio 14 2015 Win64"
CMAKE_PLATFORM_FLAGS=
CMAKE_BUILD_CMD="\"$CMAKE\" --build . --target install --config Release"
SWIG="C:/Users/phantom/Downloads/swig/swigwin-3.0.5/swig.exe"

# libSBML deps
LIBBZIP2="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/lib/libbz2.lib"
LIBBZIP2_INCLUDE="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/include"
LIBICONV="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/lib/libiconv.lib"
LIBXML2="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/lib/libxml2.lib"
LIBXML2_INCLUDE="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/include"
ZLIB="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/lib/zdll.lib"
ZLIB_INCLUDE="C:/Users/phantom/Downloads/libsbml/libSBML_dependencies_vs14_release_x64/libSBML-Dependencies-1.0.0-b1-win64/include"
CMAKE_ICONV_FLAGS=( -DICONV_LIBRARY="$LIBICONV" )

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
