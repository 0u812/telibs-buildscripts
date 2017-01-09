#/usr/bin/env zsh

# PHONY_PYLIB=/usr/local/Cellar/python/2.7.9/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib

SRCNAME=sbml2matlab
if [[ -z "${PYTHON+x}" ]]; then
  INSTNAME=$SRCNAME-$OS_STR
else
  INSTNAME=$SRCNAME-$OS_STR-$CP
fi

mkdir -p $ROOT/build/$INSTNAME
cd $_
rm -rf *
if [[ -z "${PYTHON+x}" ]]; then
  echo "Not building Python bindings"
  "$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_PREFIX=$LIBSBML_PREFIX -DSWIG_EXECUTABLE="$SWIG" -DWITH_PYTHON=OFF $ROOT/src/sbml2matlab
else
  echo "Building Python bindings"
  "$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_PREFIX=$LIBSBML_PREFIX -DSWIG_EXECUTABLE="$SWIG" -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE $ROOT/src/sbml2matlab
fi
eval $CMAKE_BUILD_CMD
