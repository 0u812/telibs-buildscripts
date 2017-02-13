#/usr/bin/env zsh

source "$( dirname "${BASH_SOURCE[0]}" )"/../common/win/win64-vs14.sh
source "$( dirname "${BASH_SOURCE[0]}" )"/build.sh

# copy over c++ libs
cp $ROOT/install/$INSTNAME/bin/{msvcp140.dll,vcruntime140.dll} $ROOT/install/$INSTNAME/bindings/python/phrasedml
