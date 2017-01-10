#/usr/bin/env bash

export CPVER=cp33
export CP=cp33m
export PYVER2=3.3
PYTHON_DIR=/opt/python/cp33-cp33m
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python${PYVER2}m

source "$( dirname "${BASH_SOURCE[0]}" )"/common.sh
