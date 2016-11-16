#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

ROOT=/whlbldr

mkdir -p $ROOT/build/libroadrunner-deps
cd $_
pwd
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_INSTALL_PREFIX=$ROOT/install/libroadrunner-deps $ROOT/src/libroadrunner-deps
make -j4 && make install

# copy to roadrunner-xcode-py2 and roadrunner-xcode-py3
rsync -av $ROOT/install/libroadrunner-deps/ $ROOT/install/roadrunner-py2m
rsync -av $ROOT/install/libroadrunner-deps/ $ROOT/install/roadrunner-py2mu
rsync -av $ROOT/install/libroadrunner-deps/ $ROOT/install/roadrunner-py3m
