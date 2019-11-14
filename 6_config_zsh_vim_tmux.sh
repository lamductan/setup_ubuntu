#!/bin/bash

# Common
pwd=$PWD
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PROGRAM_DIR=$HOME/Downloads/programs
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt
DIRECTORY=$(cd `dirname $0` && pwd)

utils/gnome-terminal-profile import utils/tdlam_terminal.profile
tar -xf $DIRECTORY/utils/archives/dotfiles.tar.xz -C $HOME/dotfiles
cd ~/dotfiles
./deploy
cd $HOME
cp $DIRECTORY/utils/dotfiles/pam_environment $HOME/.pam_environment

### libncurses-dev
curl http://archive.ubuntu.com/ubuntu/pool/main/n/ncurses/ncurses_6.1.orig.tar.gz -o $SOURCE_DIR/ncurses_6.1.orig.tar.gz
tar -xf $SOURCE_DIR/ncurses_6.1.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/ncurses-6.1
./configure --prefix=$LOCAL_DIR --with-build-cflags='-fPIC' --with-build-cppflags='-fPIC' --with-termlib --with-shared
make -j8 CFLAGS='-fPIC' CXXFLAGS='-fPIC'
make install
cd $HOME

### ccls
cd $PACKAGE_DIR
git clone --recursive https://github.com/MaskRay/ccls
cd ccls
cp $LOCAL_DIR/lib/libtinfo* . 
cp $LOCAL_DIR/lib/libz* .
LD_LIBRARY=$PACKAGE_DIR/ccls
LD_LIBRARY_PATH=$LD_LIBRARY
LIBRARY_PATH=$LD_LIBRARY
CPATH=$LD_LIBRARY
export LD_LIBRARY LD_LIBRARY_PATH LIBRARY_PATH CPATH
wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
cmake --build Release
cp $PACKAGE_DIR/ccls/Release/ccls $LOCAL_DIR/bin
pip3 install compiledb --user
go get -u github.com/sourcegraph/go-langserver
ln -s $GOPATH/bin/go-langserver $LOCAL_DIR/bin/go-langserver

### For convenience, install softwares right now
bash DIRECTORY/7_install_softwares.sh
