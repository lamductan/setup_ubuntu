#!/bin/bash

###################Preliminaries###################
# Root user must already install build-essential  #
#################End Preliminaries#################

# Common
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt

## Custom PATH and LD_LIBRARY
####echo "source ~/.bash_paths" >> $HOME/.bashrc

echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin" > $HOME/.bash_paths
echo "LD_LIBRARY=/usr/local/lib" >> $HOME/.bash_paths
echo "CPATH=/usr/local/lib" >> $HOME/.bash_paths
echo >> $HOME/.bash_paths

echo "export PATH=${LOCAL_DIR}/bin:\$PATH" >> $HOME/.bash_paths
echo "export LD_LIBRARY=$LOCAL_DIR/lib:$LOCAL_DIR/lib/x86_64-linux-gnu:\$LD_LIBRARY" >> $HOME/.bash_paths
echo "export CPATH=$LOCAL_DIR/include:\$CPATH" >> $HOME/.bash_paths
echo >> $HOME/.bash_paths

echo "export PATH=$OPT_DIR/openssl/bin:\$PATH" >> $HOME/.bash_paths
echo "export LD_LIBRARY=$OPT_DIR/openssl/lib:\$LD_LIBRARY" >> $HOME/.bash_paths
echo "export CPATH=$OPT_DIR/openssl/include:\$CPATH" >> $HOME/.bash_paths
echo "export CPATH=$LOCAL_DIR/include/ncurses:\$CPATH" >> $HOME/.bash_paths
echo >> $HOME/.bash_paths

echo "export OPENSSL_ROOT_DIR=$OPT_DIR/openssl" >> $HOME/.bash_paths
echo "export PATH=$OPT_DIR/ninja-1.9.0:\$PATH" >> $HOME/.bash_paths

echo "export LD_LIBRARY_PATH=\$LD_LIBRARY" >> $HOME/.bash_paths
echo "export LIBRARY_PATH=\$LD_LIBRARY" >> $HOME/.bash_paths
echo "export PKG_CONFIG_PATH=$LOCAL_DIR/lib/pkgconfig:$LOCAL_DIR/lib/x86_64-linux-gnu/pkgconfig" >> $HOME/.bash_paths
echo >> $HOME/.bash_paths
