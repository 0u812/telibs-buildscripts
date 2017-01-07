#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose


# check out latest source
cd $ROOT/src/cellml-api
git pull

mkdir -p $ROOT/build/cellapi
cd $_
rm -rf *
pwd
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/cell-api -DOMNIIDL=$OMNIIDL -DENABLE_CUSES=TRUE -DENABLE_ANNOTOOLS=TRUE -DENABLE_CEVAS=TRUE -DENABLE_TELICEMS=TRUE -DENABLE_CCGS=ON -DENABLE_CELEDS=ON -DENABLE_CELEDS_EXPORTER=ON -DENABLE_MALAES=ON -DENABLE_RDF=ON -DENABLE_VACSS=ON -DCMAKE_CXX_FLAGS= -DBISON_EXECUTABLE=$BISON -DFLEX_EXECUTABLE=$FLEX -DFLEX_INCLUDE_DIR=$FLEXINCL $ROOT/src/cellml-api
cmake --build . --target install --config Release
