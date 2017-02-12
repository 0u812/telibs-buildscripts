#/usr/bin/env zsh

source "$( dirname "${BASH_SOURCE[0]}" )"/../common/win/win64-vs14.sh
source "$( dirname "${BASH_SOURCE[0]}" )"/build.sh

# copy over cellml libs
cp $CELLAPI/lib/cellml.dll $ANTIMONY_INSTALL/bindings/python/antimony/cellml.dll
cp $CELLAPI/lib/cevas.dll $ANTIMONY_INSTALL/bindings/python/antimony/cevas.dll
cp $CELLAPI/lib/annotools.dll $ANTIMONY_INSTALL/bindings/python/antimony/annotools.dll
cp $CELLAPI/lib/cuses.dll $ANTIMONY_INSTALL/bindings/python/antimony/cuses.dll
cp $CELLAPI/lib/telicems.dll $ANTIMONY_INSTALL/bindings/python/antimony/telicems.dll

# copy over c++ libs
cp $ANTIMONY_INSTALL/bin/{msvcp140.dll,vcruntime140.dll} $ANTIMONY_INSTALL/bindings/python/antimony
