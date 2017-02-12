#/usr/bin/env zsh

source "$( dirname "${BASH_SOURCE[0]}" )"/../common/win/win64-vs14.sh
source "$( dirname "${BASH_SOURCE[0]}" )"/build.sh

# copy over cellml libs
cp $CELLAPI/lib/cellml.dll $ROOT/install/$INSTNAME/bindings/python/antimony/cellml.dll
cp $CELLAPI/lib/cevas.dll $ROOT/install/$INSTNAME/bindings/python/antimony/cevas.dll
cp $CELLAPI/lib/annotools.dll $ROOT/install/$INSTNAME/bindings/python/antimony/annotools.dll
cp $CELLAPI/lib/cuses.dll $ROOT/install/$INSTNAME/bindings/python/antimony/cuses.dll
cp $CELLAPI/lib/telicems.dll $ROOT/install/$INSTNAME/bindings/python/antimony/telicems.dll

# copy over c++ libs
cp $ROOT/install/$INSTNAME/bin/{msvcp140.dll,vcruntime140.dll} $ROOT/install/$INSTNAME/bindings/python/antimony
