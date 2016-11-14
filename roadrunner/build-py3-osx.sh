#/usr/bin/env zsh
set -e

cd ~/devel/build/roadrunner-xcode-py3
cmake -G"Xcode" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_CXX_FLAGS="-I/Library/Frameworks/Python.framework/Versions/3.5/lib/python3.5/site-packages/numpy/core/include" -DCMAKE_INSTALL_PREFIX=~/devel/install/roadrunner-xcode-py3 -DLLVM_CONFIG_EXECUTABLE=/Users/phantom/etc/install/llvm-3.5.2-xcode/bin/llvm-config -DTHIRD_PARTY_INSTALL_FOLDER=~/devel/install/roadrunner-xcode-py3 -DBUILD_PYTHON=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON -DRR_USE_CXX11=False -DUSE_TR1_CXX_NS=OFF -DPYTHON_EXECUTABLE=/usr/local/bin/python3 -DPYTHON_LIBRARY=/Library/Frameworks/Python.framework/Versions/3.5/lib/libpython3.5m.dylib -DPYTHON_INCLUDE_DIR=/Library/Frameworks/Python.framework/Versions/3.5/include/python3.5m -DWITH_CONDA_BUILDER=OFF -DZLIB_LIBRARY_RELEASE=/usr/lib/libz.1.2.5.dylib -DZLIB_LIBRARY=/usr/lib/libz.1.2.5.dylib ~/devel/src/roadrunner
