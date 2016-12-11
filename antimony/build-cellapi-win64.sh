#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

ROOT=/c/Users/phantom/Documents/devel
CMAKE=/c/Users/phantom/Downloads/cmake-3.7.0-win64-x64/bin/cmake
GIT=git
#MSBUILD="/c/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe"
DEVENV="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"
BISON="C:/Users/phantom/Downloads/win_flex_bison-2.5.6/win_bison.exe"
FLEX="C:/Users/phantom/Downloads/win_flex_bison-2.5.6/win_flex.exe"
FLEXINCL="C:/Users/phantom/Downloads/win_flex_bison-2.5.6"

OMNIIDL="C:\Users\phantom\Documents\exc\src\omniORB-4.2.1-2\omniORB-4.2.1\bin\x86_win32\omniidl.exe"

# check out latest source
cd $ROOT/src/cellml-api
git pull

mkdir -p $ROOT/build/cellapi
cd $_
rm -rf *
pwd
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/cell-api -DOMNIIDL=$OMNIIDL -DENABLE_CUSES=TRUE -DENABLE_ANNOTOOLS=TRUE -DENABLE_CEVAS=TRUE -DENABLE_TELICEMS=TRUE -DENABLE_CCGS=ON -DENABLE_CELEDS=ON -DENABLE_CELEDS_EXPORTER=ON -DENABLE_MALAES=ON -DENABLE_RDF=ON -DENABLE_VACSS=ON -DCMAKE_CXX_FLAGS="/IC:\Users\phantom\Downloads\win_flex_bison-2.5.6" -DBISON_EXECUTABLE=$BISON -DFLEX_EXECUTABLE=$FLEX -DFLEX_INCLUDE_DIR=$FLEXINCL $ROOT/src/cellml-api
cmake --build . --target install --config Release
