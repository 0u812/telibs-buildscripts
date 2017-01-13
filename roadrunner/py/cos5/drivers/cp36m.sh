#/usr/bin/env bash

export CPVER=cp36
export CP=cp36m
PYVER2=3.6
PYTHON_DIR=/opt/python/${CPVER}-${CP}

export PYTHON=$PYTHON_DIR/bin/python
export PIP=$PYTHON_DIR/bin/pip
export PYTHON_INCLUDE=$PYTHON_DIR/include/python${PYVER2}m

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
