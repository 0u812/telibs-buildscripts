#/usr/bin/env zsh

PHONY_PYLIB=/usr/local/Cellar/python/2.7.9/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib

mkdir -p $ROOT/build/$INSTNAME
cd $_
rm -rf *
if [[ -z "${PYTHON+x}" ]]; then
  echo "Not building Python bindings"
  cmake $CMAKE_GEN $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_PREFIX=$LIBSBML_PREFIX -DWITH_PYTHON=OFF $ROOT/src/sbml2matlab
else
  echo "Building Python bindings"
  cmake $CMAKE_GEN $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBSBML_PREFIX=$LIBSBML_PREFIX -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE $ROOT/src/sbml2matlab
fi
eval $CMAKE_BUILD_CMD
