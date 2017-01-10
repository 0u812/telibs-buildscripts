#/usr/bin/env zsh

CMAKE_GEN="-GXcode"
CMAKE_PLATFORM_FLAGS=( "-DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VER" )
CMAKE_BUILD_CMD="xcodebuild -configuration Release build install -target install"

LIBSBML_INSTNAME=libsbml-experimental-osx-$OSX_VER
LIBSBML_INSTALL_DIR=$ROOT/install/$LIBSBML_INSTNAME
LIBSBML=$LIBSBML_INSTALL_DIR/lib/libsbml-static.a
LIBSBML_INCLUDE=$LIBSBML_INSTALL_DIR/include

LIBNUML_INSTALL_DIR=$ROOT/install/libnuml-osx-10.9
NUML=$LIBNUML_INSTALL_DIR/lib/libnuml-static.a
NUML_INCLUDE=$LIBNUML_INSTALL_DIR/include

export CMAKE_PREFIX_PATH="$LIBSBML_INSTALL_DIR/lib/cmake:$LIBNUML_INSTALL_DIR/lib/cmake"
echo "CMAKE_PREFIX_PATH = $CMAKE_PREFIX_PATH"

source libcombine-build.sh
