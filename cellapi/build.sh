#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
SRCNAME=cell-api
if [[ -z "${PYTHON+x}" ]]; then
  INSTNAME=$SRCNAME-$OS_STR
else
  INSTNAME=$SRCNAME-$OS_STR-$CP
fi

mkdir -p $ROOT/build/$INSTNAME
cd $_
pwd
rm -rf *
if [[ `uname` == "Linux" ]]; then
  # COS5 only
  ln -s /whlbldr/install/flex-2.6.2/include/FlexLexer.h /usr/include
fi
$CMAKE "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DOMNIIDL=$OMNIIDL -DENABLE_CUSES=TRUE -DENABLE_ANNOTOOLS=TRUE -DENABLE_CEVAS=TRUE -DENABLE_TELICEMS=TRUE -DENABLE_CCGS=ON -DENABLE_CELEDS=ON -DENABLE_CELEDS_EXPORTER=ON -DENABLE_MALAES=ON -DENABLE_RDF=ON -DENABLE_VACSS=ON -DCMAKE_CXX_FLAGS=$CELL_API_CXX_FLAGS -DCMAKE_C_FLAGS=$CELL_API_C_FLAGS -DBISON_EXECUTABLE=$BISON -DFLEX_EXECUTABLE=$FLEX -DFLEX_INCLUDE_DIR=$FLEXINCL $ROOT/src/cellml-api
eval $CMAKE_BUILD_CMD
