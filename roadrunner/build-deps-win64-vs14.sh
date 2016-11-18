#!/usr/bin/env bash

# exit on failure
# set -e
# echo commands as they are run
set -o verbose

ROOT=/c/Users/phantom/Documents/devel
CMAKE=/c/Users/phantom/Downloads/cmake-3.7.0-win64-x64/bin/cmake
GIT=git
#MSBUILD="/c/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe"
DEVENV="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"

MC="C:/Program Files (x86)/Microsoft SDKs/Windows/v7.0A/Bin/MC.Exe"

mkdir -p $ROOT/build/libroadrunner-deps-vs14-64-2
cd $_
pwd
"$CMAKE" -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/libroadrunner-deps-vs14-64 -DCMAKE_MC_COMPILER=$MC $ROOT/src/libroadrunner-deps
# http://stackoverflow.com/questions/1629779/msbuild-builds-defaults-to-debug-configuration
# http://stackoverflow.com/questions/17504288/force-msbuild-to-build-a-project-which-is-unselected-in-solution-config
"$DEVENV" libroadrunner_deps.sln //Build Release //Project INSTALL

# copy to roadrunner-xcode-py2 and roadrunner-xcode-py3
cp -R $ROOT/install/libroadrunner-deps-vs14-64 $ROOT/install/roadrunner-py2m-win64
cp -R $ROOT/install/libroadrunner-deps-vs14-64 $ROOT/install/roadrunner-py3m-win64
