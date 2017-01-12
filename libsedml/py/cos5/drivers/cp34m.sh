#/usr/bin/env bash

export CPVER=cp34
export CP=cp34m
export PYVER2=3.4
PYTHON_DIR=/opt/python/cp34-cp34m
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python${PYVER2}m

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
