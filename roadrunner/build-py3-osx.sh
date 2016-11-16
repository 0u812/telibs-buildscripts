#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`

# Build roadrunner
mkdir -p ~/devel/build/roadrunner-xcode-py3
cd $_
pwd
cmake -G"Xcode" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_CXX_FLAGS="-I/Library/Frameworks/Python.framework/Versions/3.5/lib/python3.5/site-packages/numpy/core/include" -DCMAKE_INSTALL_PREFIX=~/devel/install/roadrunner-xcode-py3 -DLLVM_CONFIG_EXECUTABLE=/Users/phantom/etc/install/llvm-3.5.2-xcode/bin/llvm-config -DTHIRD_PARTY_INSTALL_FOLDER=~/devel/install/roadrunner-xcode-py3 -DBUILD_PYTHON=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON -DRR_USE_CXX11=False -DUSE_TR1_CXX_NS=OFF -DPYTHON_EXECUTABLE=/usr/local/bin/python3 -DPYTHON_LIBRARY=/Library/Frameworks/Python.framework/Versions/3.5/lib/libpython3.5m.dylib -DPYTHON_INCLUDE_DIR=/Library/Frameworks/Python.framework/Versions/3.5/include/python3.5m -DWITH_CONDA_BUILDER=OFF -DZLIB_LIBRARY_RELEASE=/usr/lib/libz.1.2.5.dylib -DZLIB_LIBRARY=/usr/lib/libz.1.2.5.dylib ~/devel/src/roadrunner

# no stripping allowed - this is a family biochemical network simulator
# echo Using custom config $(echo $THIS_DIR/no-strippy.config)
xcodebuild -target install -configuration Release


# Build rrplugins
mkdir -p ~/devel/build/rrplugins-xcode-py3 && cd $_
cmake -G"Xcode" -DCMAKE_INSTALL_PREFIX=~/devel/install/roadrunner-xcode-py3 -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DTLP_DEPENDENCIES_PATH=~/devel/install/roadrunner-xcode-py3 ~/devel/src/rrplugins
xcodebuild -target install -configuration Release


# Build pip package
cd ~/devel/install/roadrunner-xcode-py3
python3 setup.py bdist_wheel --python-tag=cp35 --plat-name=macosx-10.9-x86_64
# Fix ABI tag
# http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'libroadrunner*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp35m}" ' -- \{\} \;
cd ..

# copy over setup for rrplugins
cp $THIS_DIR/rrplugins-setup.py ~/devel/install/roadrunner-xcode-py3
python3 rrplugins-setup.py bdist_wheel --universal

echo "Now do something like /Library/Frameworks/Python.framework/Versions/2.7/bin/twine upload ~/devel/install/roadrunner-xcode-py3/dist/*"
