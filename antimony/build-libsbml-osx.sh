#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

mkdir -p ~/devel/build/libsbml-experimental-xcode
cd $_
pwd
cmake -G"Xcode" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_INSTALL_PREFIX=~/devel/install/libsbml-experimental-xcode -DENABLE_DISTRIB=ON -DENABLE_COMP=ON -DENABLE_LAYOUT=ON -DENABLE_RENDER=ON -DWITH_PYTHON=OFF /Users/phantom/devel/src/libsbml-experimental
xcodebuild -configuration Release build install -target install
