#/usr/bin/env zsh

# exit on failure
set -e
# echo commands as they are run
set -o verbose

# cd to the directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
THIS_DIR=`pwd`
cd $THIS_DIR
# parallel -j0 --halt now,fail=1 exec ::: ./py/osx/* # stops at first error
parallel -j0 exec ::: ./py/osx/*
