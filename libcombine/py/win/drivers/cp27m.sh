#/usr/bin/env bash

export CPVER=cp27
export CP=cp27m
PYVER2=2.7
PYTHON_DIR="C:\Pythons\win64-vs14\cp27m"
export PYTHON="$PYTHON_DIR\python.exe"
export PYTHON_INCLUDE="$PYTHON_DIR\include"
export PYTHON_LIB="$PYTHON_DIR\libs\python27.lib"
export PYTHON_LINKING="-DPYTHON_LIBRARY=$PYTHON_LIB"

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
