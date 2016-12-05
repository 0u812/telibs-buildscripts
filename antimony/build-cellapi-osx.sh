#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

OMNIIDL=/Users/phantom/etc/install/omniorb-4.2.1/bin/omniidl

mkdir -p ~/devel/build/cellapi-xcode
cd $_
pwd
cmake -G"Xcode" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_INSTALL_PREFIX=~/devel/install/cell-api-xcode -DOMNIIDL=$OMNIIDL -DENABLE_CUSES=TRUE -DENABLE_ANNOTOOLS=TRUE -DENABLE_CEVAS=TRUE -DENABLE_TELICEMS=TRUE -DENABLE_CCGS=ON -DENABLE_CELEDS=ON -DENABLE_CELEDS_EXPORTER=ON -DENABLE_MALAES=ON -DENABLE_RDF=ON -DENABLE_VACSS=ON ~/devel/src/cellml-api
xcodebuild -configuration Release build install -target install
