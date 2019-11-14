# Common
pwd=$PWD
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PROGRAM_DIR=$HOME/Downloads/programs
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt
APP_DIR=$LOCAL_DIR/share/applications
DIRECTORY=$(cd `dirname $0` && pwd)

### ibus-unikey
wget https://github.com/GNOME/gnome-common/archive/3.18.0.tar.gz --no-check-certificate -O $PROGRAM_DIR/gnome-common-3.18.0.tar.gz
tar xf $PROGRAM_DIR/gnome-common-3.18.0.tar.gz -C $PACKAGE_DIR
cd $PACKAGE_DIR/gnome-common-3.18.0
./autogen.sh
./configure --prefix=$LOCAL_DIR
make
make install
cd $HOME

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
XORG_PREFIX=$OPT_DIR/Xorg
XORG_CONFIG="--sysconfdir=$LOCAL_DIR/etc --localstatedir=$LOCAL_DIR/var --disable-static"
export XORG_PREFIX XORG_CONFIG

pathappend $XORG_PREFIX/bin             PATH
pathappend $XORG_PREFIX/lib/pkgconfig   PKG_CONFIG_PATH
pathappend $XORG_PREFIX/share/pkgconfig PKG_CONFIG_PATH

pathappend $XORG_PREFIX/lib             LIBRARY_PATH
pathappend $XORG_PREFIX/include         C_INCLUDE_PATH
pathappend $XORG_PREFIX/include         CPLUS_INCLUDE_PATH

ACLOCAL="aclocal -I $XORG_PREFIX/share/aclocal"
export PATH PKG_CONFIG_PATH ACLOCAL LIBRARY_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH

wget https://github.com/ibus/ibus/archive/1.5.21.tar.gz -O $PROGRAM_DIR/ibus-1.5.21.tar.gz --no-check-certificate
tar xf $PROGRAM_DIR/ibus-1.5.21.tar.gz -C $PACKAGE_DIR
rm -rf $LOCAL_DIR/lib/pkgconfig/pangocairo.pc
mkdir $LOCAL_DIR/share/unicode
mkdir $LOCAL_DIR/share/unicode/emoji
wget -r -nH --cut-dirs=3 -np --reject="index.html*" --no-check-certificate https://www.unicode.org/Public/emoji/4.0/ -P $LOCAL_DIR/share/unicode/emoji
mkdir $LOCAL_DIR/share/unicode/ucd
curl https://www.unicode.org/Public/UCD/latest/ucd/UCD.zip -o $PROGRAM_DIR/UCD.zip
unzip $PROGRAM_DIR/UCD.zip -d $LOCAL_DIR/share/unicode/ucd
mkdir $LOCAL_DIR/share/unicode/cldr
curl https://www.unicode.org/Public/cldr/36/cldr-common-36.0.zip -o $PROGRAM_DIR/cldr-common-36.0.zip
unzip $PROGRAM_DIR/cldr-common-36.0.zip -d $LOCAL_DIR/share/unicode/cldr

curl http://archive.ubuntu.com/ubuntu/pool/main/i/iso-codes/iso-codes_3.79.orig.tar.xz -o $SOURCE_DIR/iso-codes_3.79.orig.tar.xz
tar -xf $SOURCE_DIR/iso-codes_3.79.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/iso-codes-3.79
./configure --prefix=$LOCAL_DIR
make -j8
make install
cd $HOME

cd $PACKAGE_DIR/ibus-1.5.21
./autogen.sh
./configure --prefix=$LOCAL_DIR \
            --with-unicode-emoji-dir=$LOCAL_DIR/share/unicode/emoji \
            --with-ucd-dir=$LOCAL_DIR/share/unicode/ucd \
            --with-emoji-annotation-dir=$LOCAL_DIR/share/unicode/cldr/common/annotations
make
make install
cp $PACKAGE_DIR/ibus-1.5.21/ibus-1.0.pc $LOCAL_DIR/lib/pkgconfig
cd $HOME

wget https://github.com/vn-input/ibus-unikey/archive/0.6.1.tar.gz -O $PROGRAM_DIR/ibus-unikey-0.6.1.tar.gz --no-check-certificate
tar xf $PROGRAM_DIR/ibus-unikey-0.6.1.tar.gz -C $PACKAGE_DIR
export PKG_CONFIG_PATH=$DIRECTORY/utils/pkgconfig:$PKG_CONFIG_PATH
cd $PACKAGE_DIR/ibus-unikey-0.6.1
./autogen.sh
./configure --prefix=$LOCAL_DIR CC=c89
make
make install
cd $HOME

### virtualbox
curl http://archive.ubuntu.com/ubuntu/pool/universe/a/acpica-unix/acpica-unix_20180105.orig.tar.gz -o $SOURCE_DIR/acpica-unix_20180105.orig.tar.gz
tar -xf $SOURCE_DIR/acpica-unix_20180105.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/acpica-unix-20180105
make -j8 PREFIX=$LOCAL_DIR
make install PREFIX=$LOCAL_DIR
cd $HOME

curl http://archive.ubuntu.com/ubuntu/pool/main/libv/libvpx/libvpx_1.7.0.orig.tar.gz -o $SOURCE_DIR/libvpx_1.7.0.orig.tar.gz
tar -xf $SOURCE_DIR/libvpx_1.7.0.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libvpx-1.7.0
./configure --prefix=$LOCAL_DIR
make -j8
make install
cd $HOME

curl http://archive.ubuntu.com/ubuntu/pool/main/o/opus/opus_1.1.2.orig.tar.gz -o $SOURCE_DIR/opus_1.1.2.orig.tar.gz
tar -xf $SOURCE_DIR/opus_1.1.2.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/opus-1.1.2
./autogen.sh
./configure --prefix=$LOCAL_DIR
make -j8
make install
cd $HOME

### mesa
curl ftp://ftp.freedesktop.org/pub/mesa/mesa-18.3.6.tar.xz -o $SOURCE_DIR/mesa-18.3.6.tar.xz
tar -xf $SOURCE_DIR/mesa-18.3.6.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/mesa-18.3.6
meson _build --prefix=$LOCAL_DIR
ninja -C _build
ninja -C _build install
cd $HOME

wget https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14.tar.bz2 --no-check-certificate -O $SOURCE_DIR/VirtualBox-6.0.14.tar.bz2
tar xvjf $SOURCE_DIR/VirtualBox-6.0.14.tar.bz2 -C $PACKAGE_DIR/
cd $PACKAGE_DIR/VirtualBox-6.0.14
./configure --disable-sdl
make -j8
make install
cd $HOME
cp $DIRECTORY/utils/desktop/virtualbox.desktop $APP_DIR
chmod a+x $APP_DIR/virtualbox.desktop
