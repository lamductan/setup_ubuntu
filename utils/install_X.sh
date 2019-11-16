#!/bin/bash

# Common
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt

DIRECTORY=$(cd `dirname $0` && pwd)

pathremove () {
        local IFS=':'
        local NEWPATH
        local DIR
        local PATHVARIABLE=${2:-PATH}
        for DIR in ${!PATHVARIABLE} ; do
                if [ "$DIR" != "$1" ] ; then
                  NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
                fi
        done
        export $PATHVARIABLE="$NEWPATH"
}

pathprepend () {
        pathremove $1 $2
        local PATHVARIABLE=${2:-PATH}
        export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend () {
        pathremove $1 $2
        local PATHVARIABLE=${2:-PATH}
        export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

export -f pathremove pathprepend pathappend



# Environment
XORG_PREFIX=$OPT_DIR/Xorg
mkdir $LOCAL_DIR/etc
mkdir $LOCAL_DIR/var
XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=$LOCAL_DIR/etc --localstatedir=$LOCAL_DIR/var --disable-static"
export XORG_PREFIX XORG_CONFIG

pathappend $XORG_PREFIX/bin             PATH
pathappend $XORG_PREFIX/lib/pkgconfig   PKG_CONFIG_PATH
pathappend $XORG_PREFIX/share/pkgconfig PKG_CONFIG_PATH

pathappend $XORG_PREFIX/lib             LIBRARY_PATH
pathappend $XORG_PREFIX/include         C_INCLUDE_PATH
pathappend $XORG_PREFIX/include         CPLUS_INCLUDE_PATH

ACLOCAL="aclocal -I $XORG_PREFIX/share/aclocal"
export PATH PKG_CONFIG_PATH ACLOCAL LIBRARY_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH

ln -svf $XORG_PREFIX/share/X11 $LOCAL_DIR/share/X11


### util-macros 
curl https://www.x.org/archive//individual/util/util-macros-1.19.2.tar.bz2 -o $SOURCE_DIR/util-macros-1.19.2.tar.bz2
tar xvjf $SOURCE_DIR/util-macros-1.19.2.tar.bz2 -C $PACKAGE_DIR
cd $PACKAGE_DIR/util-macros*
./configure $XORG_CONFIG
make install

### xorgproto-2019.2 
curl https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2019.2.tar.bz2 -o $SOURCE_DIR/xorgproto-2019.2.tar.bz2
tar xvjf $SOURCE_DIR/xorgproto-2019.2.tar.bz2 -C $PACKAGE_DIR
cd $PACKAGE_DIR/xorgproto-2019.2*
rm -rf build &&
mkdir build &&
cd    build &&
meson --prefix=$XORG_PREFIX .. &&
ninja
ninja install &&
install -vdm 755 $XORG_PREFIX/share/doc/xorgproto-2019.2 &&
install -vm 644 ../[^m]*.txt ../PM_spec $XORG_PREFIX/share/doc/xorgproto-2019.2

### libXau-1.0.9 
curl https://www.x.org/archive//individual/lib/libXau-1.0.9.tar.bz2 -o $SOURCE_DIR/libXau-1.0.9.tar.bz2
tar xvjf $SOURCE_DIR/libXau-1.0.9.tar.bz2 -C $PACKAGE_DIR
cd $PACKAGE_DIR/libXau-1.0.9*
./configure $XORG_CONFIG &&
make
make install

### libXdmcp-1.1.3
curl https://www.x.org/archive//individual/lib/libXdmcp-1.1.3.tar.bz2 -o $SOURCE_DIR/libXdmcp-1.1.3.tar.bz2
tar xvjf $SOURCE_DIR/libXdmcp-1.1.3.tar.bz2 -C $PACKAGE_DIR
cd $PACKAGE_DIR/libXdmcp-1.1.3*
./configure $XORG_CONFIG &&
make
make install

### xcb-proto-1.13
curl https://xcb.freedesktop.org/dist/xcb-proto-1.13.tar.bz2 -o $SOURCE_DIR/xcb-proto-1.13.tar.bz2
tar xvjf $SOURCE_DIR/xcb-proto-1.13.tar.bz2 -C $PACKAGE_DIR
cd $PACKAGE_DIR/xcb-proto-1.13*
./configure $XORG_CONFIG &&
make
make install

### libxcb-1.13.1 
curl https://xcb.freedesktop.org/dist/libxcb-1.13.1.tar.bz2  -o $SOURCE_DIR/libxcb-1.13.1.tar.bz2
tar xvjf $SOURCE_DIR/libxcb-1.13.1.tar.bz2 -C $PACKAGE_DIR
cd $PACKAGE_DIR/libxcb-1.13.1*
sed -i "s/pthread-stubs//" configure &&
./configure $XORG_CONFIG      \
            --without-doxygen \
            --docdir='${datadir}'/doc/libxcb-1.13.1 &&
make
make install

### Xorg libraries
rm -rf $DIRECTORY/lib
mkdir $DIRECTORY/lib &&
cd $DIRECTORY/lib &&
grep -v '^#' $DIRECTORY/lib-7.md5 | awk '{print $2}' | wget -i- -c \
    -B https://www.x.org/pub/individual/lib/ --no-check-certificate &&
md5sum -c $DIRECTORY/lib-7.md5

for package in $(grep -v '^#' $DIRECTORY/lib-7.md5 | awk '{print $2}')
do
  packagedir=${package%.tar.bz2}
  tar -xf $package
  pushd $packagedir
  case $packagedir in
    libICE* )
      ./configure $XORG_CONFIG ICE_LIBS=-lpthread
    ;;

    libXfont2-[0-9]* )
      ./configure $XORG_CONFIG --disable-devel-docs
    ;;

    libXt-[0-9]* )
      ./configure $XORG_CONFIG \
                  --with-appdefaultdir=/etc/X11/app-defaults
    ;;

    * )
      ./configure $XORG_CONFIG
    ;;
  esac
  make
  #make check 2>&1 | tee ../$packagedir-make_check.log
  make install
  popd
  rm -rf $packagedir
done


ln -sv $XORG_PREFIX/lib $LOCAL_DIR/lib/X11 &&
ln -sv $XORG_PREFIX/include/X11 $LOCAL_DIR/include/X11

### xclip
curl http://archive.ubuntu.com/ubuntu/pool/main/x/xclip/xclip_0.12+svn84.orig.tar.gz -o $SOURCE_DIR/xclip.tar.gz
tar -xf $SOURCE_DIR/xclip* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/xclip*
autoconf
./configure XORG_CONFIG --with-x --x-includes=$OPT_DIR/Xorg/include/X11 --x-libraries=$OPT_DIR/Xorg/lib --prefix=$LOCAL_DIR
make
make install
cd $HOME
