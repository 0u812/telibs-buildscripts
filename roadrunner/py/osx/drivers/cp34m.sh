#/usr/bin/env zsh

export CPVER=cp34
export CP=cp34m
PYVER2=3.4
PYTHON_DIR=/Users/phantom/.pyenv/versions/3.4.5
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python3.4m
export PIP=$PYTHON_DIR/bin/pip

source "$( dirname "${BASH_SOURCE[0]}" )"/../common.sh
