#/usr/bin/env bash

export CPVER=cp27
export CP=cp27mu
PYVER2=2.7
PYTHON_DIR=/opt/python/${CPVER}-${CP}
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python${PYVER2}

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
