#/usr/bin/env bash
yum -y install libxml2-devel gpg openssl-devel expat-devel gettext-devel zlib-devel bzip2-devel pcre-devel

# add tool path
export PATH=/whlbldr/tools/bin:$PATH

# add gcc paths
export LD_LIBRARY_PATH=/whlbldr/install/gcc-5.4.0/lib:/whlbldr/install/gcc-5.4.0/lib64:$LD_LIBRARY_PATH
# export PATH=/whlbldr/install/gcc-5.4.0/bin:$PATH

rsync -av /whlbldr/.ssh ~
rsync -av /whlbldr/.pypirc ~

git config --global user.email 0u812@users.noreply.github.com
git config --global user.name  0u812

# swig
export PATH=/whlbldr/install/swig/bin:$PATH
