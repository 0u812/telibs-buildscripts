#!/usr/bin/env bash

# exit on failure
set -e
# echo commands as they are run
set -o verbose

source "$( dirname "${BASH_SOURCE[0]}" )"/../common/lin/cos5-gcc54.sh
source "$( dirname "${BASH_SOURCE[0]}" )"/build.sh
