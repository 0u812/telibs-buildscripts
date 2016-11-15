#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

mkdir -p ~/devel/build/libroadrunner-deps-xcode
cd $_
pwd
cmake -G"Xcode" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_INSTALL_PREFIX=~/devel/install/libroadrunner-deps-xcode ~/devel/src/libroadrunner-deps
xcodebuild -configuration Release build install -target install

# copy to roadrunner-xcode-py2 and roadrunner-xcode-py3
rsync -av ~/devel/install/libroadrunner-deps-xcode/ ~/devel/install/roadrunner-xcode-py2
rsync -av ~/devel/install/libroadrunner-deps-xcode/ ~/devel/install/roadrunner-xcode-py3
