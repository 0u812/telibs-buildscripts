#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`

export CP=cp27
PYTHON_DIR=/Users/phantom/.pyenv/versions/2.7.13
export PYTHON=$PYTHON_DIR/bin/python
export PYTHON_INCLUDE=$PYTHON_DIR/include/python2.7

sh $THIS_DIR/../../libcombine-osx-10.9.sh
