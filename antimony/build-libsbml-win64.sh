#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/c/Users/phantom/Documents/devel
SWIG="C:/Users/phantom/Downloads/swig/swigwin-3.0.5/swig.exe"
LIBXML_INCL="C:\Users\phantom\Documents\devel\src\libroadrunner-deps\third_party\dependencies\libsbml\include"
LIBXML="C:\Users\phantom\Documents\devel\src\libroadrunner-deps\third_party\dependencies\libsbml\lib\libxml2.lib"

mkdir -p $ROOT/build/libsbml-experimental
cd $_
pwd
rm -rf *
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/libsbml-experimental -DENABLE_DISTRIB=ON -DENABLE_COMP=ON -DENABLE_LAYOUT=ON -DENABLE_RENDER=ON -DENABLE_FBC=ON -DWITH_PYTHON=OFF -DLIBXML_INCLUDE_DIR=$LIBXML_INCL -DLIBXML_LIBRARY=$LIBXML -DEXTRA_LIBS="C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/zdll.lib;C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libbz2.lib;C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libiconv.lib;ws2_32.lib" $ROOT/src/libsbml-experimental
cmake --build . --target install --config Release
