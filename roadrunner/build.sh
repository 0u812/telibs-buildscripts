#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
SRCNAME=roadrunner
RRP_SRCNAME=rrplugins
if [[ -z "${PYTHON+x}" ]]; then
  INSTNAME=$SRCNAME-$OS_STR
else
  INSTNAME=$SRCNAME-$OS_STR-$CP
fi
if [[ -z "${PYTHON+x}" ]]; then
  RRP_INSTNAME=$RRP_SRCNAME-$OS_STR
else
  RRP_INSTNAME=$RRP_SRCNAME-$OS_STR-$CP
fi

# copy libroadrunner-deps into the install directory
rm -rf $ROOT/install/$INSTNAME
rsync -av $ROOT/install/libroadrunner-deps-$OS_STR/ $ROOT/install/$INSTNAME

# install numpy
$PIP install numpy

mkdir -p $ROOT/build/$INSTNAME
cd $_
pwd
rm -rf *
if [[ -z "${PYTHON+x}" ]]; then
  echo "Not building Python bindings"
  exit 1
else
  "$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DLLVM_CONFIG_EXECUTABLE=$LLVM_CONFIG -DTHIRD_PARTY_INSTALL_FOLDER=$ROOT/install/$INSTNAME -DBUILD_PYTHON=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON -DRR_USE_CXX11=$RR_CPP11 -DUSE_TR1_CXX_NS=$RR_TR1_NS -DPYTHON_EXECUTABLE=$PYTHON_INTERP -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DWITH_CONDA_BUILDER=OFF -DZLIB_LIBRARY_RELEASE=$ZLIB -DZLIB_LIBRARY=$ZLIB $ROOT/src/$SRCNAME
fi
eval $CMAKE_BUILD_CMD

mkdir -p $ROOT/build/$RRP_INSTNAME
cd $_
pwd
rm -rf *
if [[ -z "${PYTHON+x}" ]]; then
  echo "Not building Python bindings"
  exit 1
else
cmake -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DCMAKE_BUILD_TYPE=Release -DTLP_DEPENDENCIES_PATH=$ROOT/install/$INSTNAME $ROOT/src/$RRP_SRCNAME
fi
eval $CMAKE_BUILD_CMD
