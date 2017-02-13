#/usr/bin/env zsh

export CPVER=cp34
export CP=cp34m
PYVER2=3.4
PYTHON_DIR="C:\Pythons\win64-vs14\cp34m"
export PYTHON="$PYTHON_DIR\python.exe"
export PYTHON_INCLUDE="$PYTHON_DIR\include"
export PYTHON_LIB="$PYTHON_DIR\libs\python34.lib"
export PYTHON_LINKING="-DPYTHON_LIBRARY=$PYTHON_LIB"

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
