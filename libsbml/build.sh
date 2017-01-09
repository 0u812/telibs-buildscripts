#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`

SRCNAME=libsbml-experimental
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
  "$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DENABLE_ARRAYS=ON -DENABLE_COMP=ON -DENABLE_DISTRIB=ON -DENABLE_DYN=ON -DENABLE_FBC=ON -DENABLE_GROUPS=ON -DENABLE_LAYOUT=ON -DENABLE_MULTI=ON -DENABLE_QUAL=ON -DENABLE_RENDER=ON -DENABLE_REQUIREDELEMENTS=ON -DENABLE_SPATIAL=ON -DWITH_CPP_NAMESPACE=ON -DWITH_PYTHON=OFF $ROOT/src/$SRCNAME
else
  echo "Building Python bindings"
  "$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLIBBZ_LIBRARY="$LIBBZIP2" -DLIBBZ_INCLUDE_DIR="$LIBBZIP2_INCLUDE" -DLIBXML_LIBRARY="$LIBXML2" -DLIBXML_INCLUDE_DIR="$LIBXML2_INCLUDE" -DLIBZ_LIBRARY="$ZLIB" -DLIBZ_INCLUDE_DIR="$ZLIB_INCLUDE" $CMAKE_ICONV_FLAGS -DENABLE_ARRAYS=ON -DENABLE_COMP=ON -DENABLE_DISTRIB=ON -DENABLE_DYN=ON -DENABLE_FBC=ON -DENABLE_GROUPS=ON -DENABLE_LAYOUT=ON -DENABLE_MULTI=ON -DENABLE_QUAL=ON -DENABLE_RENDER=ON -DENABLE_REQUIREDELEMENTS=ON -DENABLE_SPATIAL=ON -DWITH_CPP_NAMESPACE=ON -DSWIG_EXECUTABLE="$SWIG" -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DPYTHON_USE_DYNAMIC_LOOKUP=ON $ROOT/src/$SRCNAME
fi
eval $CMAKE_BUILD_CMD
