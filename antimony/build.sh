#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
SRCNAME=antimony
if [[ -z "${PYTHON+x}" ]]; then
  INSTNAME=$SRCNAME-$OS_STR
else
  INSTNAME=$SRCNAME-$OS_STR-$CP
fi

if [[ "$LIBSBMLNS" == "OFF" ]]; then
  INSTNAME="$INSTNAME"-nons
fi

mkdir -p $ROOT/build/$INSTNAME
cd $_
pwd
rm -rf *
"$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML_INSTALL_DIR -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI -DCMAKE_CXX_FLAGS="-std=c++11" $ROOT/src/$SRCNAME
make -j4 && make install
"$CMAKE" "$CMAKE_GEN" $CMAKE_PLATFORM_FLAGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOT/install/$INSTNAME -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON -DLIBSBML_INSTALL_DIR=$LIBSBML_INSTALL_DIR -DWITH_LIBSBML_COMPRESSION=ON -DPYTHON_EXECUTABLE=$PYTHON -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DWITH_QTANTIMONY=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF -DWITH_CONDA_BUILDER=OFF -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR=$CELLAPI -DCMAKE_CXX_FLAGS="-std=c++11" $ROOT/src/$SRCNAME
make -j4 && make install
make -j4 && make install

if [[ `uname` == "Linux" ]]; then
  # copy over cellml libs
  cp $CELLAPI/lib/libcellml.so.1.13 $ROOT/install/$INSTNAME/bindings/python/antimony/libcellml.so.2
  cp $CELLAPI/lib/libcevas.so.1.13 $ROOT/install/$INSTNAME/bindings/python/antimony/libcevas.so.1
  cp $CELLAPI/lib/libannotools.so.1.13 $ROOT/install/$INSTNAME/bindings/python/antimony/libannotools.so.2
  cp $CELLAPI/lib/libcuses.so.1.13 $ROOT/install/$INSTNAME/bindings/python/antimony/libcuses.so.1
  cp $CELLAPI/lib/libtelicems.so.1.13 $ROOT/install/$INSTNAME/bindings/python/antimony/libtelicems.so.1

  # copy libsbml dep libs
  cp /usr/lib64/libbz2.so.1.0.3 $ROOT/install/$INSTNAME/bindings/python/$SRCNAME/libbz2.so.1
  cp /usr/lib64/libxml2.so.2.6.26 $ROOT/install/$INSTNAME/bindings/python/$SRCNAME/libxml2.so.2
  cp /lib64/libz.so.1.2.3 $ROOT/install/$INSTNAME/bindings/python/$SRCNAME/libz.so.1

  patchelf --set-rpath '$ORIGIN/.' $ROOT/install/$INSTNAME/bindings/python/antimony/_antimony.so

  # copy over c++ libs
  cp /whlbldr/install/gcc-5.4.0/lib64/libstdc++.so.6 $ROOT/install/$INSTNAME/bindings/python/antimony
  cp /whlbldr/install/gcc-5.4.0/lib64/libgcc_s.so.1 $ROOT/install/$INSTNAME/bindings/python/antimony
fi

if [[ `uname` == "Darwin" ]]; then
  # copy over cellml libs
  cp $CELLAPI/lib/libcellml.1.13.dylib $ROOT/install/$INSTNAME/bindings/python/antimony/libcellml.2.dylib
  cp $CELLAPI/lib/libcevas.1.13.dylib $ROOT/install/$INSTNAME/bindings/python/antimony/libcevas.1.dylib
  cp $CELLAPI/lib/libannotools.1.13.dylib $ROOT/install/$INSTNAME/bindings/python/antimony/libannotools.2.dylib
  cp $CELLAPI/lib/libcuses.1.13.dylib $ROOT/install/$INSTNAME/bindings/python/antimony/libcuses.1.dylib
  cp $CELLAPI/lib/libtelicems.1.13.dylib $ROOT/install/$INSTNAME/bindings/python/antimony/libtelicems.1.dylib

  # fix cellml libraries
  install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/libcevas.1.dylib
  #install_name_tool -add_rpath "@loader_path/." $ROOT/install/$INSTNAME/bindings/python/antimony/libcevas.1.dylib

  install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/libannotools.2.dylib
  #install_name_tool -add_rpath "@loader_path/." $ROOT/install/$INSTNAME/bindings/python/antimony/libannotools.2.dylib

  install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/libcuses.1.dylib
  install_name_tool -change libannotools.2.dylib "@rpath/libannotools.2.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/libcuses.1.dylib
  #install_name_tool -add_rpath "@loader_path/." $ROOT/install/$INSTNAME/bindings/python/antimony/libcuses.1.dylib

  install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/libtelicems.1.dylib
  #install_name_tool -add_rpath "@loader_path/." $ROOT/install/$INSTNAME/bindings/python/antimony/libtelicems.1.dylib

  # fix ids of libraries
  install_name_tool -change libcellml.2.dylib "@rpath/libcellml.2.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/_antimony.so
  install_name_tool -change libcevas.1.dylib "@rpath/libcevas.1.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/_antimony.so
  install_name_tool -change libannotools.2.dylib "@rpath/libannotools.2.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/_antimony.so
  install_name_tool -change libcuses.1.dylib "@rpath/libcuses.1.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/_antimony.so
  install_name_tool -change libtelicems.1.dylib "@rpath/libtelicems.1.dylib" $ROOT/install/$INSTNAME/bindings/python/antimony/_antimony.so

  install_name_tool -add_rpath "@loader_path/." $ROOT/install/$INSTNAME/bindings/python/antimony/_antimony.so
fi
