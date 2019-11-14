#!/bin/bash

# Common
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt

DIRECTORY=$(cd `dirname $0` && pwd)

### meson
pip3 install --user meson

### re2c
wget https://github.com/skvadrik/re2c/archive/1.2.1.tar.gz -O $SOURCE_DIR/re2c-1.2.1.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/re2c-1.2.1* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/re2c-1.2.1*
./autogen.sh
./configure --prefix=$LOCAL_DIR
make -j8
make install
cd $HOME

### ninja
wget https://github.com/ninja-build/ninja/archive/v1.9.0.tar.gz -O $SOURCE_DIR/ninja.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/ninja* -C $OPT_DIR/
cd $OPT_DIR/ninja*
./configure.py --bootstrap
