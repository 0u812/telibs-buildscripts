#/usr/bin/env zsh

mkdir -p $ROOT/build/$INSTNAME
cd $_
rm -rf *
if [[ -z "${PYTHON+x}" ]]; then
  echo "Not building Python bindings"
  cmake $CMAKE_GEN $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DEXTRA_LIBS=$LIBSBML_EXTRA_LIBS -DWITH_PYTHON=OFF -DLIBNUML_INCLUDE_DIR=$NUML_INCLUDE $ROOT/src/$SRCNAME
else
  echo "Building Python bindings"
  cmake $CMAKE_GEN $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_INCLUDE_DIR=$LIBSBML_INCLUDE -DLIBSBML_STATIC=ON -DEXTRA_LIBS=$LIBSBML_EXTRA_LIBS -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DPYTHON_USE_DYNAMIC_LOOKUP=ON -DLIBNUML_INCLUDE_DIR=$NUML_INCLUDE $ROOT/src/$SRCNAME
fi
eval $CMAKE_BUILD_CMD
