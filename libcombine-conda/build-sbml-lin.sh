#/usr/bin/env bash

export PATH=/home/user/exc/install/gcc-5.4.0/bin:$PATH
export CC=/home/user/exc/install/gcc-5.4.0/bin/gcc
export CXX=/home/user/exc/install/gcc-5.4.0/bin/g++
export LD_LIBRARY_PATH=/home/user/exc/install/gcc-5.4.0/lib:$LD_LIBRARY_PATH

cd ~/devel/build/libsbml-experimental
cmake -DCMAKE_CXX_FLAGS="-std=c++17" -DCMAKE_INSTALL_PREFIX=~/devel/install/libsbml-experimental -DENABLE_COMP=ON -DENABLE_LAYOUT=ON -DENABLE_RENDER=ON -DENABLE_DISTRIB=ON -DENABLE_FBC=ON -DSKIP_MINIZIP_IMPLEMENTATION=ON -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE=~/anaconda2/bin/python2.7 -DPYTHON_INCLUDE_DIR=~/anaconda2/include/python2.7 -DPYTHON_LIBRARY=~/anaconda2/lib/libpython2.7.so ~/devel/src/libsbml-experimental
make -j4 install
