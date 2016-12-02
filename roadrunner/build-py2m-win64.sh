#/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
ROOT=/c/Users/phantom/Documents/devel
LLVM_CONFIG=/c/Users/phantom/Documents/exc/install/llvm-3.5.2-vs14-64/bin/llvm-config.exe
PYTHON_INTERP=/c/Python27-64/python.exe
PIP=/c/Python27-64/Scripts/pip2.exe
PYTHON_INCLUDE=/c/Python27-64/include
GIT=git
DEVENV="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"

# check out latest roadrunner
cd $ROOT/src/roadrunner
$GIT pull
cd $ROOT/src/rrplugins
$GIT pull

$PIP install numpy

# Build roadrunner
mkdir -p $ROOT/build/roadrunner-py2m-vs14-64
cd $_
pwd
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/roadrunner-py2m-win64 -DLLVM_CONFIG_EXECUTABLE=$LLVM_CONFIG -DTHIRD_PARTY_INSTALL_FOLDER=$ROOT/install/roadrunner-py2m-win64 -DBUILD_PYTHON=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON -DRR_USE_CXX11=FALSE -DUSE_TR1_CXX_NS=FALSE -DPYTHON_EXECUTABLE=$PYTHON_INTERP -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DWITH_CONDA_BUILDER=OFF -DLIBSBML_LIBRARY=C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libsbml.lib -DLIBSBML_STATIC_LIBRARY=C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libsbml-static.lib -DZLIB_LIBRARY=C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/zdll.lib -DBZ2_LIBRARY=C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libbz2.lib -DICONV_LIBRARY=C:/Users/phantom/Documents/devel/install/roadrunner-vs14-64/lib/libiconv.lib -DSWIG_EXECUTABLE=C:/Users/phantom/Downloads/swig/swigwin-3.0.5/swig.exe  $ROOT/src/roadrunner

"$DEVENV" rr.sln //Build Release //Project INSTALL


# Build rrplugins
mkdir -p $ROOT/build/rrplugins-py2m-vs14-64 && cd $_
cmake -G"Visual Studio 14 2015 Win64" -DCMAKE_INSTALL_PREFIX=$ROOT/install/roadrunner-py2m-win64 -DCMAKE_BUILD_TYPE=Release -DTLP_DEPENDENCIES_PATH=$ROOT/install/roadrunner-py2m-win64 -DLIBXML2_INCLUDE_DIR=C:/Users/phantom/Documents/devel/src/libroadrunner-deps/third_party/dependencies/libsbml/include/ $ROOT/src/rrplugins

"$DEVENV" rrplugins.sln //Build Release //Project INSTALL

# copy libsbml.dll to site-packages/roadrunner
cp $ROOT/install/roadrunner-py2m-win64/bin/libsbml.dll $ROOT/install/roadrunner-py2m-win64/site-packages/roadrunner/
# copy runtimes to site-packages/roadrunner
cp $ROOT/install/roadrunner-py3m-win64/bin/{msvcp140.dll,vcruntime140.dll} $ROOT/install/roadrunner-py3m-win64/site-packages/roadrunner/

# Build pip package
cd $ROOT/install/roadrunner-py2m-win64
$PYTHON_INTERP setup.py bdist_wheel --python-tag=cp27 --plat-name=win_amd64
# Fix ABI tag
# http://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory
cd dist
find . -name 'libroadrunner*none*' -type f -exec bash -c 'mv "$1" "${1/none/cp27m}" ' -- \{\} \;
cd ..

# copy over setup for rrplugins
cp $THIS_DIR/rrplugins-setup.py $ROOT/install/roadrunner-py2m-win64
$PYTHON_INTERP rrplugins-setup.py bdist_wheel --universal

echo "Now do something like twine upload $ROOT/install/roadrunner-py2m-win64/dist/*"
