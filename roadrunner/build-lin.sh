#!/usr/bin/env bash
set -e

# cd to directory of this script
cd "$( dirname "${BASH_SOURCE[0]}" )"
# cd to the directory containing src, build, install
while [ ! -d .git ]; do
  cd ..
done
cd ../..

ROOT=`pwd`
echo "Using root dir $ROOT"
