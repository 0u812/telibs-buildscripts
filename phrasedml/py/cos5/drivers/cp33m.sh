#/usr/bin/env bash

export CPVER=cp33
export CP=cp33m
PYVER2=3.3
PYTHON_DIR=/opt/python/${CPVER}-${CP}

export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python${PYVER2}m

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
