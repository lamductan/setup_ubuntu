#!/bin/bash

###################Preliminaries###################
# Root user must already install build-essential  #
#################End Preliminaries#################

# Common
pwd=$PWD
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt
DIRECTORY=$(cd `dirname $0` && pwd)
mkdir $LOCAL_DIR/bin
mkdir $LOCAL_DIR/lib
mkdir $SOURCE_DIR
mkdir $PACKAGE_DIR
mkdir $OPT_DIR

## Download package sources and install packages
### OpenSSL
wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1d.tar.gz -O $SOURCE_DIR/OpenSSL_1_1_1d.tar.gz --no-check-certificate
mkdir $OPT_DIR/openssl
tar xfvz $SOURCE_DIR/OpenSSL* --directory $OPT_DIR/openssl
cd $OPT_DIR/openssl/openssl*
./config --prefix=$OPT_DIR/openssl --openssldir=$OPT_DIR/openssl/ssl
make -j
make test
make install
cd $HOME

### zlib
wget http://zlib.net/zlib-1.2.11.tar.gz -O $SOURCE_DIR/zlib-1.2.11.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/zlib* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/zlib*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### curl
wget https://github.com/curl/curl/releases/download/curl-7_67_0/curl-7.67.0.tar.gz -O $SOURCE_DIR/curl-7.67.0.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/curl* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/curl*
./configure --prefix=$LOCAL_DIR --with-ssl=$OPT_DIR/openssl
make -j
make install
cd $HOME

### m4
curl http://ftp.gnu.org/gnu/m4/m4-latest.tar.gz -o $SOURCE_DIR/m4.tar.gz
tar -xf $SOURCE_DIR/m4* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/m4*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### help2man
curl http://archive.ubuntu.com/ubuntu/pool/universe/h/help2man/help2man_1.47.6.tar.xz -o $SOURCE_DIR/help2man.tar.gz
tar -xf $SOURCE_DIR/help2man* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/help2man*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### autoconf
curl http://archive.ubuntu.com/ubuntu/pool/main/a/autoconf/autoconf_2.69.orig.tar.xz -o $SOURCE_DIR/autoconf.tar.gz
tar -xf $SOURCE_DIR/autoconf* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/autoconf*
./configure --prefix=$LOCAL_DIR
make -j
make check
make install
cd $HOME

### tcl
curl https://nchc.dl.sourceforge.net/project/tcl/Tcl/8.6.9/tcl8.6.9-src.tar.gz -o $SOURCE_DIR/tcl.tar.gz
tar -xf $SOURCE_DIR/tcl* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/tcl*/unix
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### sqlite3
curl https://launchpadlibrarian.net/354343812/sqlite3_3.22.0.orig.tar.xz -o $SOURCE_DIR/sqlite3.tar.xz
tar -xf $SOURCE_DIR/sqlite3* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/sqlite3*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### python2.7
tar -xf $DIRECTORY/utils/archives/cpython-2.7.16* -C $PACKAGE_DIR/
export OPENSSL_ROOT=$OPT_DIR/openssl
cd $PACKAGE_DIR/cpython-2.7.16*
./configure --with-pydebug --enable-loadable-sqlite-extensions --prefix=$LOCAL_DIR --enable-shared
make -j
make install
cd $HOME

### automake
curl http://ftp.gnu.org/gnu/automake/automake-1.16.tar.gz -o $SOURCE_DIR/automake.tar.gz
tar -xf $SOURCE_DIR/automake* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/automake*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libtool
curl http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz -o $SOURCE_DIR/libtool.tar.gz
tar -xf $SOURCE_DIR/libtool* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libtool*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### Git
wget https://github.com/git/git/archive/v2.9.0.tar.gz -O $SOURCE_DIR/git-2.9.0.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/git* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/git*
make configure
./configure --prefix=$LOCAL_DIR
make all doc -j
make install
cd $HOME

### CMake
wget https://github.com/Kitware/CMake/releases/download/v3.16.0-rc3/cmake-3.16.0-rc3.tar.gz -O $SOURCE_DIR/cmake-3.16.0-rc3.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/cmake* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/cmake*
./configure --prefix=$LOCAL_DIR
make
make install
cd $HOME

### hdf5
curl https://s3.amazonaws.com/hdf-wordpress-1/wp-content/uploads/manual/HDF5/HDF5_1_10_5/source/hdf5-1.10.5.tar.gz -o $SOURCE_DIR/hdf5-1.10.5.tar.gz
tar -xf $SOURCE_DIR/hdf5* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/hdf5*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libncurses-dev
curl https://launchpadlibrarian.net/271597305/ncurses_6.0+20160625.orig.tar.gz -o $SOURCE_DIR/ncurses.tar.gz
tar -xf $SOURCE_DIR/ncurses* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/ncurses*
./configure --prefix=$LOCAL_DIR --with-build-cflags='-fPIC' --with-build-cppflags='-fPIC'
make -j CFLAGS='-fPIC' CXXFLAGS='-fPIC'
make install
cd $HOME

### libevent
wget https://github.com/libevent/libevent/archive/release-2.1.11-stable.tar.gz -O $SOURCE_DIR/libevent-2.1.11.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/libevent* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libevent*
autoreconf -i
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### pkg-config
curl https://pkg-config.freedesktop.org/releases/pkg-config-0.28.tar.gz -o $SOURCE_DIR/pkg-config.tar.xz
tar -xf $SOURCE_DIR/pkg-config* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/pkg-config*
./configure --prefix=$LOCAL_DIR --with-internal-glib
make -j
make install
cd $HOME

### libffi
curl http://archive.ubuntu.com/ubuntu/pool/main/libf/libffi/libffi_3.2.1.orig.tar.gz -o $SOURCE_DIR/libffi.tar.gz
tar -xf $SOURCE_DIR/libffi* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libffi*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### util-linux
curl https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.28/util-linux-2.28.2.tar.xz -o $SOURCE_DIR/util-linux.tar.gz
tar -xf $SOURCE_DIR/util-linux* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/util-linux*
autoconf
./configure --prefix=$LOCAL_DIR     \
            --disable-use-tty-group \
            --disable-chfn-chsh     \
            --disable-login         \
            --disable-nologin       \
            --disable-su            \
            --disable-setpriv       \
            --disable-runuser       \
            --disable-pylibmount    \
            --disable-static        \
            --without-python        \
            --without-systemd       \
            --without-systemdsystemunitdir
make -j
make install
cd $HOME

### pcre
curl https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz -o $SOURCE_DIR/pcre-8.43.tar.gz
tar -xf $SOURCE_DIR/pcre-8.43.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/pcre-8.43
mkdir $LOCAL_DIR
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### pcre2
curl https://ftp.pcre.org/pub/pcre/pcre2-10.33.tar.gz -o $SOURCE_DIR/pcre2.tar.gz
tar -xf $SOURCE_DIR/pcre2* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/pcre2*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### pip2
curl https://bootstrap.pypa.io/get-pip.py -o $SOURCE_DIR/get-pip.py
python $SOURCE_DIR/get-pip.py --user

### b2
pip install b2 --user

### boost
wget https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.gz -O $SOURCE_DIR/boost_1_66_1.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/boost* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/boost*
./bootstrap.sh --prefix=$LOCAL_DIR
./b2 install
cd $HOME

### python3.6.8
curl http://archive.ubuntu.com/ubuntu/pool/main/x/xz-utils/xz-utils_5.2.2.orig.tar.xz -o $SOURCE_DIR/xz-utils_5.2.2.tar.xz
tar -xf $SOURCE_DIR/xz-utils_5.2.2* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/xz-5.2.2*
./autogen.sh
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME
curl http://archive.ubuntu.com/ubuntu/pool/main/b/bzip2/bzip2_1.0.6.orig.tar.bz2 -o $SOURCE_DIR/bzip2.tar.bz2
## override current Makefile with Makefile added -fPIC
cp $DIRECTORY/utils/bz2_Makefile $PACKAGE_DIR/bzip2*/Makefile
tar xvjf $SOURCE_DIR/bzip2* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/bzip2*
make -j
make install PREFIX=$LOCAL_DIR
cd $HOME

tar -xf $DIRECTORY/utils/archives/cpython-3.6.8* -C $PACKAGE_DIR/
export OPENSSL_ROOT=$OPT_DIR/openssl
cd $PACKAGE_DIR/cpython-3.6.8*
./configure --with-pydebug --with-tcltk-includes="-I$LOCAL_DIR/include" \
            --enable-loadable-sqlite-extensions --prefix=$LOCAL_DIR     \
            --with-tcltk-libs="-L$LOCAL_DIR/lib -ltcl8.6"
make -j
make install
cd $HOME

### tmux
wget https://github.com/tmux/tmux/archive/2.9.tar.gz -O $SOURCE_DIR/tmux-2.9.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/tmux* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/tmux*
./autogen.sh
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libX-dev
bash utils/install_meson_ninja.sh
bash utils/install_X.sh

### gtk
bash utils/install_gtk.sh

## Java, Go, Nodejs
bash utils/install_programming.sh

### zsh
curl https://nchc.dl.sourceforge.net/project/zsh/zsh/5.7.1/zsh-5.7.1.tar.xz -o $SOURCE_DIR/zsh.tar.xz
mkdir $PACKAGE_DIR/zsh && unxz $SOURCE_DIR/zsh.tar.xz && tar -xvf $SOURCE_DIR/zsh.tar -C $PACKAGE_DIR/zsh --strip-components 1
cd $PACKAGE_DIR/zsh
./configure --prefix=$LOCAL_DIR
make -j
make install
echo "exec zsh" >> $HOME/.bashrc

### For convenience, run the next two scripts here
bash 6_config_zsh_vim_tmux.sh
bash 7_install_softwares.sh
