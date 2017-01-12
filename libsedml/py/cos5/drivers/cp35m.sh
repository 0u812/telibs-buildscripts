#/usr/bin/env bash

export CPVER=cp35
export CP=cp35m
export PYVER2=3.5
PYTHON_DIR=/opt/python/cp35-cp35m
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python${PYVER2}m

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
