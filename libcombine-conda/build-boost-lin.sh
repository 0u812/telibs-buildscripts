#/usr/bin/env bash

export PATH=/home/user/exc/install/gcc-5.4.0/bin:$PATH
export CC=/home/user/exc/install/gcc-5.4.0/bin/gcc
export CXX=/home/user/exc/install/gcc-5.4.0/bin/g++
export LD_LIBRARY_PATH=/home/user/exc/install/gcc-5.4.0/lib:$LD_LIBRARY_PATH

cd ~/exc/src/boost_1_62_0
./bootstrap.sh --with-toolset=gcc --prefix=/home/user/exc/install/boost-1.62
./b2 cxxflags="-std=c++17 -fPIC" -j4 install
