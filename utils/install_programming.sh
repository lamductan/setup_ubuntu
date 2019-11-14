#!/bin/bash

# Common
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt

DIRECTORY=$(cd `dirname $0` && pwd)

## Download package sources and install packages
### Nodejs
curl https://nodejs.org/dist/v12.13.0/node-v12.13.0.tar.gz -o $SOURCE_DIR/node-v12.13.0.tar.gz
tar -xf $SOURCE_DIR/node* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/node*
./configure --prefix=$LOCAL_DIR
make -j8
make test-only
make doc
./node -e "console.log('Hello from Node.js ' + process.version)"
make install
cd $HOME

### Java
tar -xvzf $DIRECTORY/archives/jdk-8*.tar.gz -C $OPT_DIR
JAVA_HOME=$OPT_DIR/jdk1.8.0_131
echo "export JAVA_HOME=$JAVA_HOME" > $HOME/.bash_path_programming
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> $HOME/.bash_path_programming

### Go
mkdir $HOME/dev
mkdir $HOME/dev/go
mkdir $HOME/dev/go/packages
mkdir $HOME/dev/go/packages/bin
curl https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz -o $SOURCE_DIR/go1.13.4.tar.gz
tar -xzf $SOURCE_DIR/go*.tar.gz -C $HOME/dev/go
mv $HOME/dev/go/go* $HOME/dev/go/go1.13.4
GOROOT=$HOME/dev/go/go1.13.4
GOPATH=$HOME/dev/go/packages
echo "export GOROOT=$GOROOT" >> $HOME/.bash_path_programming
echo "export GOPATH=$GOPATH" >> $HOME/.bash_path_programming
echo "export PATH=\$GOROOT/bin:\$PATH" >> $HOME/.bash_path_programming


