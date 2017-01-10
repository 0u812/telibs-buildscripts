#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
SRCNAME=libsedml
if [[ -z "${PYTHON+x}" ]]; then
  INSTNAME=$SRCNAME-$OS_STR
else
  INSTNAME=$SRCNAME-$OS_STR-$CP
fi

if [[ "$LIBSBMLNS" == "OFF" ]]; then
  INSTNAME="$INSTNAME"-nons
fi

export CMAKE_PREFIX_PATH="$LIBSBML_INSTALL_DIR/lib/cmake:$LIBNUML_INSTALL_DIR/lib/cmake:$CMAKE_PREFIX_PATH"

mkdir -p $ROOT/build/$INSTNAME
cd $_
rm -rf *
if [[ -z "${PYTHON+x}" ]]; then
  echo "Not building Python bindings"
  "$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DEXTRA_LIBS=$LIBSBML_EXTRA_LIBS -DWITH_CPP_NAMESPACE="$LIBSBMLNS" -DWITH_PYTHON=OFF -DLIBNUML_LIBRARY=$NUML -DLIBNUML_INCLUDE_DIR=$NUML_INCLUDE $ROOT/src/$SRCNAME
else
  echo "Building Python bindings"
  "$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_LIBRARY=$LIBSBML -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DEXTRA_LIBS=$LIBSBML_EXTRA_LIBS -DWITH_CPP_NAMESPACE=ON -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DPYTHON_USE_DYNAMIC_LOOKUP="$LIBSBMLNS" -DLIBNUML_LIBRARY=$ -DLIBNUML_INCLUDE_DIR=$NUML_INCLUDE $ROOT/src/$SRCNAME
fi
eval $CMAKE_BUILD_CMD
