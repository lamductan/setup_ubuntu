#!/bin/bash

# Common
pwd=$PWD
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PROGRAM_DIR=$HOME/Downloads/programs
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt
DIRECTORY=$(cd `dirname $0` && pwd)

chmod a+x $DIRECTORY/utils/gnome-terminal-profile 
$DIRECTORY/utils/gnome-terminal-profile import $DIRECTORY/utils/gruvbox.profile
tar -xf $DIRECTORY/utils/archives/dotfiles.tar.xz -C $HOME
cd $HOME/dotfiles
./deploy
cd $HOME
cp $DIRECTORY/utils/dotfiles/pam_environment $HOME/.pam_environment

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
cp $DIRECTORY/utils/archives/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz .
tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
cmake --build Release
cp $PACKAGE_DIR/ccls/Release/ccls $LOCAL_DIR/bin

pip3 install compiledb --user

GOROOT=$HOME/dev/go/go1.13.4
GOPATH=$HOME/dev/go/packages
export GOROOT GOPATH
export PATH=$GOROOT/bin:$PATH
go get -u github.com/sourcegraph/go-langserver
ln -s $GOPATH/bin/go-langserver $LOCAL_DIR/bin/go-langserver

pip3 install python-language-server --user

echo "exec zsh" >> $HOME/.bashrc
