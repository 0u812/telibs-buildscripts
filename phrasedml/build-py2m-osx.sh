#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`

mkdir -p ~/devel/build/phrasedml-xcode-py2m
cd $_
pwd
cmake -GXcode -DCMAKE_INSTALL_PREFIX=/Users/phantom/devel/install/phrasedml-xcode -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DLIBSEDML_LIBRARY=/Users/phantom/devel/install/libsedml-xcode/lib/libsedml-static.a -DLIBSEDML_INCLUDE_DIR=/Users/phantom/devel/install/libsedml-xcode/include -DLIBSBML_LIBRARY=/Users/phantom/devel/install/libsbml-experimental-r22429-xcode/lib/libsbml-static.a -DLIBSBML_INCLUDE_DIR=/Users/phantom/devel/install/libsbml-experimental-r22429-xcode/include -DLIBNUML_LIBRARY=/Users/phantom/devel/install/libnuml-xcode/lib/libnuml-static.a -DLIBNUML_INCLUDE_DIR=/Users/phantom/devel/install/libnuml-xcode/include -DEXTRA_LIBS='xml2;bz2;z;iconv' -DWITH_PYTHON=ON -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=ON ~/devel/src/phrasedml

xcodebuild -target install -configuration Release
