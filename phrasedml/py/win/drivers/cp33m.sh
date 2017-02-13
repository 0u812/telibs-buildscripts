#/usr/bin/env bash

export CPVER=cp33
export CP=cp33m
PYVER2=3.3
PYTHON_DIR="C:\Pythons\win64-vs14\cp33m"
export PYTHON"=$PYTHON_DIR\python.exe"
export PYTHON_INCLUDE="$PYTHON_DIR\include"
export PYTHON_LIB="$PYTHON_DIR\libs\python33.lib"
export PYTHON_LINKING="-DPYTHON_LIBRARY=$PYTHON_LIB"

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
