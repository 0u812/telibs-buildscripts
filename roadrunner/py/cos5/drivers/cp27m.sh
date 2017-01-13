#/usr/bin/env bash

export CPVER=cp27
export CP=cp27m
PYVER2=2.7
PYTHON_DIR=/opt/python/${CPVER}-${CP}

export PYTHON=$PYTHON_DIR/bin/python
export PIP=$PYTHON_DIR/bin/pip
export PYTHON_INCLUDE=$PYTHON_DIR/include/python2.7

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
