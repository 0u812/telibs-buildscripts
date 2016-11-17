#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

ROOT=/c/Users/phantom/Documents/devel
CMAKE=/c/Users/phantom/Downloads/cmake-3.7.0-win64-x64/bin/cmake
GIT=git
MSBUILD=/c/Program\ Files\ \(x86\)/MSBuild/14.0/Bin/MSBuild.exe

mkdir -p $ROOT/build/libroadrunner-deps-vs14-64-2
cd $_
pwd
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/libroadrunner-deps-vs14-64 $ROOT/src/libroadrunner-deps
# http://stackoverflow.com/questions/1629779/msbuild-builds-defaults-to-debug-configuration
$MSBUILD libroadrunner_deps.sln /p:Configuration=Release /t INSTALL

# copy to roadrunner-xcode-py2 and roadrunner-xcode-py3
#cp -R $ROOT/install/libroadrunner-deps/ $ROOT/install/roadrunner-py2m
#cp -R $ROOT/install/libroadrunner-deps/ $ROOT/install/roadrunner-py2mu
#cp -R $ROOT/install/libroadrunner-deps/ $ROOT/install/roadrunner-py3m
