#/usr/bin/env bash

export CPVER=cp35
export CP=cp35m
PYVER2=3.5
PYTHON_DIR="C:\Pythons\win64-vs14\cp35m"
export PYTHON="$PYTHON_DIR\python.exe"
export PIP="$PYTHON_DIR\Scripts\pip.exe"
export PYTHON_INCLUDE="$PYTHON_DIR\include"
export PYTHON_LIB="$PYTHON_DIR\libs\python35.lib"
export PYTHON_LINKING="-DPYTHON_LIBRARY=$PYTHON_LIB"

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
