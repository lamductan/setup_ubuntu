#!/bin/bash

###Preliminaries###
# Root user must already install build-essential  #
#End Preliminaries#

# Common
pwd=$PWD
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt

DIRECTORY=$(cd `dirname $0` && pwd)

### glib
wget https://github.com/GNOME/glib/archive/2.62.2.tar.gz -O $SOURCE_DIR/glib2.62.2.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/glib2.62.2.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/glib-2.62.2
meson _build --prefix=$LOCAL_DIR/
ninja -C _build
ninja -C _build install
cp $PACKAGE_DIR/glib-2.62.2/_build/gio/libgio-2.0.so
cp $PACKAGE_DIR/glib-2.62.2/_build/gio/libgio-2.0.so $LOCAL_DIR/lib/x86_64-linux-gnu
cd $HOME

### libxml
curl http://archive.ubuntu.com/ubuntu/pool/main/libx/libxml2/libxml2_2.9.4+dfsg1.orig.tar.xz -o $SOURCE_DIR/libxml2_2.9.4+dfsg1.orig.tar.xz
tar -xf $SOURCE_DIR/libxml2_2.9.4+dfsg1.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libxml*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libxslt
curl http://archive.ubuntu.com/ubuntu/pool/main/libx/libxslt/libxslt_1.1.29.orig.tar.gz -o $SOURCE_DIR/libxslt_1.1.29.orig.tar.gz
tar -xf $SOURCE_DIR/libxslt_1.1.29.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libxslt-1.1.29
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### dconf-tools
curl http://archive.ubuntu.com/ubuntu/pool/main/d/d-conf/d-conf_0.26.0.orig.tar.xz -o $SOURCE_DIR/d-conf_0.26.0.orig.tar.xz
tar -xf $SOURCE_DIR/d-conf_0.26.0.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/dconf-0.26.0
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### expat
wget https://github.com/libexpat/libexpat/archive/R_2_2_9.tar.gz -O $SOURCE_DIR/expat_2.2.9.tar.gz --no-check-certificate
tar -xf $SOURCE_DIR/expat_2.2.9.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libexpat*/expat
./buildconf.sh
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### XML parser
curl https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.41.tar.gz -o $SOURCE_DIR/XML-Parser-2.41.tar.gz
tar -xf $SOURCE_DIR/XML-Parser-2.41* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/XML-Parser-2.41*
perl Makefile.PL &&
make &&
make test &&
make install --prefix=$LOCAL_DIR
cd $HOME

### intltool
curl http://archive.ubuntu.com/ubuntu/pool/universe/i/intltool/intltool_0.51.0.orig.tar.gz -o $SOURCE_DIR/intltool_0.51.0.tar.gz
tar -xf $SOURCE_DIR/intltool_0.51.0* -C $PACKAGE_DIR/
cd $PACKAGE_DIR/intltool-0.51.0*
./configure --prefix=$LOCAL_DIR
make -j
make install &&
install -v -m644 -D doc/I18N-HOWTO \
    $LOCAL_DIR/share/doc/intltool-0.50.2/I18N-HOWTO
cd $HOME
cp $DIRECTORY/intltool-update $LOCAL_DIR/bin

### dbus
curl http://archive.ubuntu.com/ubuntu/pool/main/d/dbus/dbus_1.12.2.orig.tar.gz -o $SOURCE_DIR/dbus_1.12.2.orig.tar.gz
tar xf $SOURCE_DIR/dbus_1.12.2.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/dbus-1.12.2
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### dbus-glib
curl http://archive.ubuntu.com/ubuntu/pool/main/d/dbus-glib/dbus-glib_0.110.orig.tar.gz -o $SOURCE_DIR/dbus-glib_0.110.orig.tar.gz
tar xf $SOURCE_DIR/dbus-glib_0.110.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/dbus-glib-0.110
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### gettext
curl http://archive.ubuntu.com/ubuntu/pool/main/g/gettext/gettext_0.19.8.1.orig.tar.xz -o $SOURCE_DIR/gettext_0.19.8.1.orig.tar.xz
tar xf $SOURCE_DIR/gettext_0.19.8.1.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/gettext-0.19.8.1
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### bison
wget http://ftp.gnu.org/gnu/bison/bison-3.4.tar.gz -O $SOURCE_DIR/bison-3.4.tar.gz --no-check-certificate
tar xf $SOURCE_DIR/bison-3.4.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/bison*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### flex
wget https://github.com/westes/flex/releases/download/v2.6.3/flex-2.6.3.tar.gz -O $SOURCE_DIR/flex_2.6.3.tar.gz --no-check-certificate
tar xf $SOURCE_DIR/flex_2.6.3.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/flex*
./autogen.sh
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libIdl
curl http://archive.ubuntu.com/ubuntu/pool/universe/libi/libidl/libidl_0.8.14.orig.tar.gz -o $SOURCE_DIR/libidl_0.8.14.orig.tar.gz
tar xf $SOURCE_DIR/libidl_0.8.14.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libIDL-0.8.14
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### popt
curl http://archive.ubuntu.com/ubuntu/pool/main/p/popt/popt_1.16.orig.tar.gz -o $SOURCE_DIR/popt_1.16.orig.tar.gz
tar -xf $SOURCE_DIR/popt_1.16.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/popt-1.16
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### orbit2.0
tar -xf $DIRECTORY/ORBit2-2.14.19.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/ORBit2-2.14.19
./configure --prefix=$LOCAL_DIR CC=gcc
make clean
make -j
make install
cd $HOME

### gconf
curl http://archive.ubuntu.com/ubuntu/pool/universe/g/gconf/gconf_3.2.6.orig.tar.xz -o $SOURCE_DIR/gconf_3.2.6.orig.tar.xz
tar xf $SOURCE_DIR/gconf_3.2.6.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/GConf-3.2.6
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### gobject-introspection
curl http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.62/gobject-introspection-1.62.0.tar.xz -o $SOURCE_DIR/gobject-introspection-1.62.0.tar.xz
tar xf $SOURCE_DIR/gobject-introspection-1.62.0.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/gobject-introspection-1.62.0
rm -rf build
mkdir build &&
cd    build &&
meson --prefix=$LOCAL_DIR .. &&
ninja
ninja install

### libtiff
curl https://launchpadlibrarian.net/450059495/tiff_4.1.0.orig.tar.gz -o $SOURCE_DIR/tiff_4.1.0.orig.tar.gz
tar xf $SOURCE_DIR/tiff_4.1.0.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/tiff-4.1.0
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### nasm
curl https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.gz -o $SOURCE_DIR/nasm-2.14.02.tar.gz
tar xf $SOURCE_DIR/nasm-2.14.02.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/nasm*
sh configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libjpeg
curl http://archive.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo_1.5.2.orig.tar.gz -o $SOURCE_DIR/libjpeg-turbo_1.5.2.orig.tar.gz
tar xf $SOURCE_DIR/libjpeg-turbo_1.5.2.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libjpeg*
sh configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libpng
curl http://archive.ubuntu.com/ubuntu/pool/main/libp/libpng1.6/libpng1.6_1.6.34.orig.tar.xz -o $SOURCE_DIR/libpng1.6_1.6.34.orig.tar.xz
tar xf $SOURCE_DIR/libpng1.6_1.6.34.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libpng*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### share-mine-info
curl http://archive.ubuntu.com/ubuntu/pool/main/s/shared-mime-info/shared-mime-info_1.9.orig.tar.xz -o $SOURCE_DIR/shared-mime-info_1.9.orig.tar.xz
tar xf $SOURCE_DIR/shared-mime-info_1.9.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/shared-mime-info*
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libpixman
curl http://archive.ubuntu.com/ubuntu/pool/main/p/pixman/pixman_0.34.0.orig.tar.gz -o $SOURCE_DIR/pixman_0.34.0.orig.tar.gz
tar xf $SOURCE_DIR/pixman_0.34.0.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/pixman-0.34.0
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### pixbuf
curl http://archive.ubuntu.com/ubuntu/pool/main/g/gdk-pixbuf/gdk-pixbuf_2.36.11.orig.tar.xz -o $SOURCE_DIR/gdk-pixbuf_2.36.11.orig.tar.xz
tar xf $SOURCE_DIR/gdk-pixbuf_2.36.11.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/gdk-pixbuf-2.36.11
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### freetype
curl http://archive.ubuntu.com/ubuntu/pool/main/f/freetype/freetype_2.8.1.orig.tar.gz -o $SOURCE_DIR/freetype_2.8.1.orig.tar.gz
tar xzvf $SOURCE_DIR/freetype_2.8.1.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/freetype-2.8.1
tar xvjf freetype-2.8.1.tar.bz2
cd freetype-2.8.1
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### harfbuzz
wget https://github.com/harfbuzz/harfbuzz/archive/2.2.0.tar.gz -O $SOURCE_DIR/harfbuzz-2.2.0.tar.gz --no-check-certificate
tar xf $SOURCE_DIR/harfbuzz-2.2.0.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/harfbuzz-2.2.0
./autogen.sh
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### fontconfig
curl http://archive.ubuntu.com/ubuntu/pool/main/f/fontconfig/fontconfig_2.13.1.orig.tar.bz2 -o $SOURCE_DIR/fontconfig_2.13.1.orig.tar.bz2
tar xvjf $SOURCE_DIR/fontconfig_2.13.1.orig.tar.bz2 -C $PACKAGE_DIR/
cd $PACKAGE_DIR/fontconfig-2.13.1
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### harfbuzz
wget https://github.com/harfbuzz/harfbuzz/archive/2.6.4.tar.gz -O $SOURCE_DIR/harfbuzz-2.6.4.tar.gz --no-check-certificate
tar xf $SOURCE_DIR/harfbuzz-2.6.4.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/harfbuzz-2.6.4
./autogen.sh
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### freetype
curl http://archive.ubuntu.com/ubuntu/pool/main/f/freetype/freetype_2.10.1.orig.tar.gz -o $SOURCE_DIR/freetype_2.10.1.orig.tar.gz
tar xzvf $SOURCE_DIR/freetype_2.10.1.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/freetype-2.10.1
tar xvjf freetype-2.10.1.tar.bz2
cd freetype-2.10.1
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### gperf
curl http://archive.ubuntu.com/ubuntu/pool/universe/g/gperf/gperf_3.1.orig.tar.gz -o $SOURCE_DIR/gperf_3.1.orig.tar.gz
tar xf $SOURCE_DIR/gperf_3.1.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/gperf-3.1
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### fribidi
wget https://github.com/fribidi/fribidi/archive/v1.0.7.tar.gz -O $SOURCE_DIR/fribidi-1.0.7.tar.gz --no-check-certificate
tar xf $SOURCE_DIR/fribidi-1.0.7.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/fribidi-1.0.7
./autogen.sh
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libcairo
curl http://archive.ubuntu.com/ubuntu/pool/main/c/cairo/cairo_1.15.10.orig.tar.xz -o $SOURCE_DIR/cairo_1.15.10.orig.tar.xz
tar xf $SOURCE_DIR/cairo_1.15.10.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/cairo-1.15.10
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libpango
curl http://archive.ubuntu.com/ubuntu/pool/main/p/pango1.0/pango1.0_1.44.7.orig.tar.xz -o $SOURCE_DIR/pango1.0_1.44.7.orig.tar.xz
tar xf $SOURCE_DIR/pango1.0_1.44.7.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/pango-1.44.7
meson _build --prefix=$LOCAL_DIR
ninja -C _build
ninja -C _build install
cd $HOME

### libcairo2
curl http://archive.ubuntu.com/ubuntu/pool/main/c/cairo/cairo_1.15.10.orig.tar.xz -o $SOURCE_DIR/cairo_1.15.10.orig.tar.xz
tar xf $SOURCE_DIR/cairo_1.15.10.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/cairo-1.15.10
./configure --prefix=$LOCAL_DIR --with-x --x-includes=$OPT_DIR/Xorg/include/X11 --x-libraries=$OPT_DIR/Xorg/lib
make -j
make install
cd $HOME

### atk
curl http://archive.ubuntu.com/ubuntu/pool/main/a/atk1.0/atk1.0_2.34.1.orig.tar.xz -o $SOURCE_DIR/atk1.0_2.34.1.orig.tar.xz
tar xf $SOURCE_DIR/atk1.0_2.34.1.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/atk*
ln -s $LOCAL_DIR/lib/x86_64-linux-gnu/libglib-2.0.so $LOCAL_DIR/lib/libglib-2.0.so 
meson _build . --prefix=$LOCAL_DIR
cd _build
ninja
ninja install
cd $HOME
ln -s ~/.local/lib/x86_64-linux-gnu/libatk-1.0.so ~/.local/lib/libatk.so

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

# libxi
curl http://archive.ubuntu.com/ubuntu/pool/main/libx/libxi/libxi_1.7.9.orig.tar.gz -o $SOURCE_DIR/libxi_1.7.9.orig.tar.gz
tar xf $SOURCE_DIR/libxi_1.7.9.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libXi-1.7.9
./configure $XORG_CONFIG &&
make
make install

 xproto
curl http://archive.ubuntu.com/ubuntu/pool/main/x/xorgproto/xorgproto_2018.4.orig.tar.gz -o $SOURCE_DIR/xorgproto_2018.4.orig.tar.gz
tar xf $SOURCE_DIR/xorgproto_2018.4.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/xorgproto-2018.4
./configure $XORG_CONFIG &&
make
make install

### libdrm
curl http://archive.ubuntu.com/ubuntu/pool/main/libd/libdrm/libdrm_2.4.91.orig.tar.gz -o $SOURCE_DIR/libdrm_2.4.91.orig.tar.gz
tar xf $SOURCE_DIR/libdrm_2.4.91.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libdrm-2.4.91
./configure --prefix=$LOCAL_DIR --with-x --x-includes=$OPT_DIR/Xorg/include/X11 --x-libraries=$OPT_DIR/Xorg/lib
make -j
make install
cd $HOME

### llvm
curl http://archive.ubuntu.com/ubuntu/pool/main/l/llvm-toolchain-6.0/llvm-toolchain-6.0_6.0.orig.tar.bz2 -o $SOURCE_DIR/llvm-toolchain-6.0_6.0.orig.tar.bz2
tar xf $SOURCE_DIR/llvm-toolchain-6.0_6.0.orig.tar.bz2 -C $PACKAGE_DIR/
cd $PACKAGE_DIR/llvm-toolchain*
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$LOCAL_DIR
make
make install
cd $HOME

### libelf
curl http://archive.ubuntu.com/ubuntu/pool/main/e/elfutils/elfutils_0.170.orig.tar.bz2 -o $SOURCE_DIR/elfutils_0.170.orig.tar.bz2
tar xvjf $SOURCE_DIR/elfutils_0.170.orig.tar.bz2 -C $PACKAGE_DIR/
cd $PACKAGE_DIR/elfutils*
./configure --enable-llvm --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libegl
curl http://archive.ubuntu.com/ubuntu/pool/main/m/mesa/mesa_18.0.0~rc5.orig.tar.gz -o $SOURCE_DIR/mesa_18.0.0~rc5.orig.tar.gz
tar xf $SOURCE_DIR/mesa_18.0.0~rc5.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/mesa*
./configure --enable-llvm --with-llvm-prefix=$LOCAL_DIR $XORG_CONFIG &&
make -j
make install
cd $HOME

### libepoxy
curl http://archive.ubuntu.com/ubuntu/pool/main/libe/libepoxy/libepoxy_1.4.3.orig.tar.xz -o $SOURCE_DIR/libepoxy_1.4.3.orig.tar.xz
tar xf $SOURCE_DIR/libepoxy_1.4.3.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libepoxy-1.4.3
./configure $XORG_CONFIG --prefix=$LOCAL_DIR --with-x --x-includes=$OPT_DIR/Xorg/include/X11 --x-libraries=$OPT_DIR/Xorg/lib
make -j
make install
cd $HOME

### xml dtd
curl https://docbook.org/xml/4.5/docbook-xml-4.5.zip -o $SOURCE_DIR/docbook-xml-4.5.zip
unzip $SOURCE_DIR/docbook-xml-4.5.zip -d $PACKAGE_DIR/docbook-xml-4.5
cd $PACKAGE_DIR/docbook-xml-4.5
install -v -d -m755 $LOCAL_DIR/share/xml/docbook/xml-dtd-4.5 &&
install -v -d -m755 $LOCAL_DIR/etc/xml &&
cp -v -af docbook.cat *.dtd ent/ *.mod \
    $LOCAL_DIR/share/xml/docbook/xml-dtd-4.5

### xsl
wget http://downloads.sourceforge.net/docbook/docbook-xsl-1.71.1.tar.bz2 -O $SOURCE_DIR/docbook-xsl-1.71.1.tar.bz2 --no-check-certificate
tar xvjf $SOURCE_DIR/docbook-xsl-1.71.1.tar.bz2 -C $PACKAGE_DIR/
cd $PACKAGE_DIR/docbook-xsl*
install -v -m755 -d $LOCAL_DIR/share/xml/docbook/xsl-stylesheets-1.71.1 &&
cp -v -R VERSION common eclipse extensions fo highlighting html \
         htmlhelp images javahelp lib manpages params profiling \
         slides template tools website wordml xhtml             \
    $LOCAL_DIR/share/xml/docbook/xsl-stylesheets-1.71.1 &&
install -v -m644 -D README \
                    $LOCAL_DIR/share/doc/docbook-xsl-1.71.1/.XSL &&
install -v -m755    RELEASE-NOTES* NEWS* \
                    $LOCAL_DIR/share/doc/docbook-xsl-1.71.1
cd $HOME

bash $DIRECTORY/utils/gen_catalog.sh

### itstool
curl http://archive.ubuntu.com/ubuntu/pool/universe/i/itstool/itstool_2.0.2.orig.tar.gz -o $SOURCE_DIR/itstool_2.0.2.orig.tar.gz
tar xf $SOURCE_DIR/itstool_2.0.2.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/itstool-2.0.2
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### gtk-doc
curl http://archive.ubuntu.com/ubuntu/pool/universe/g/gtk-doc/gtk-doc_1.27.orig.tar.xz -o $SOURCE_DIR/gtk-doc_1.27.orig.tar.xz
tar xf $SOURCE_DIR/gtk-doc_1.27.orig.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/gtk-doc*
./configure --with-xml-catalog=$LOCAL_DIR/etc/xml/catalog \
            --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### atspi-2
curl http://ftp.gnome.org/pub/gnome/sources/at-spi2-core/2.34/at-spi2-core-2.34.0.tar.xz -o $SOURCE_DIR/at-spi2-core_2.34.0.tar.xz
tar xf $SOURCE_DIR/at-spi2-core_2.34.0.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/at-spi2-core-2.34.0
export PKG_CONFIG_PATH=$DIRECTORY/utils/pkgconfig:$PKG_CONFIG_PATH
meson _build . --prefix=$LOCAL_DIR
cd _build
ninja reconfigure
ninja install
cd $HOME

### atspi2atk
curl http://ftp.gnome.org/pub/gnome/sources/at-spi2-atk/2.34/at-spi2-atk-2.34.1.tar.xz -o $SOURCE_DIR/at-spi2-atk-2.34.1.tar.xz
tar xf $SOURCE_DIR/at-spi2-atk-2.34.1.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/at-spi2-atk-2.34.1
export PKG_CONFIG_PATH=$DIRECTORY/utils/pkgconfig:$PKG_CONFIG_PATH
meson _build . --prefix=$LOCAL_DIR --reconfigure
cd _build
ninja
ninja install
cd $HOME

### libkbcommon
curl http://archive.ubuntu.com/ubuntu/pool/main/libx/libxkbcommon/libxkbcommon_0.8.0.orig.tar.gz -o $SOURCE_DIR/libxkbcommon_0.8.0.orig.tar.gz
tar xf $SOURCE_DIR/libxkbcommon_0.8.0.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/libxkbcommon-0.8.0
./autogen.sh
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### wayland
curl https://wayland.freedesktop.org/releases/wayland-1.17.0.tar.xz -o $SOURCE_DIR/wayland-1.17.0.tar.xz
tar xf $SOURCE_DIR/wayland-1.17.0.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/wayland-1.17.0
./configure --prefix=$LOCAL_DIR --disable-documentation
make -j
make install
cd $HOME

### wayland-protocol
curl https://wayland.freedesktop.org/releases/wayland-protocols-1.18.tar.xz -o $SOURCE_DIR/wayland-protocols-1.18.tar.xz
tar xf $SOURCE_DIR/wayland-protocols-1.18.tar.xz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/wayland-protocols-1.18
./configure --prefix=$LOCAL_DIR
make -j
make install
cd $HOME

### libpugixml
curl http://archive.ubuntu.com/ubuntu/pool/universe/p/pugixml/pugixml_1.9.orig.tar.gz -o $SOURCE_DIR/pugixml_1.9.orig.tar.gz
tar xf $SOURCE_DIR/pugixml_1.9.orig.tar.gz -C $PACKAGE_DIR/
cd $PACKAGE_DIR/pugixml-1.9
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$LOCAL_DIR
make -j
make install
cd $HOME

### gtk3
wget https://github.com/GNOME/gtk/archive/3.24.12.tar.gz -O $SOURCE_DIR/gtk-3.24.12.tar.gz --no-check-certificate
tar xf $SOURCE_DIR/gtk-3.24.12.tar.gz -C $PACKAGE_DIR/
ln -s $LOCAL_DIR/lib/x86_64-linux-gnu/libgobject-2.0.so $LOCAL_DIR/lib/libgobject-2.0.so 
cd $PACKAGE_DIR/gtk-3.24.12
rm -rf build-gtk3
mkdir build-gtk3 &&
cd    build-gtk3 &&
meson --prefix=$LOCAL_DIR     \
      -Dgtk_doc=false         \
      -Dman=false             \
      -Dwayland_backend=true  \
      -Dbroadway_backend=true .. &&
ninja reconfigure
ninja install
## if there is error: "undefined symbol", rum: 
##    LD_DEBUG=symbols,bindings ldd -r .local/lib/x86_64-linux-gnu/libgtk-3.so |& grep gdk_window_move_to_rect |& grep linux-gnu
cp $LOCAL_DIR/lib/x86_64-linux-gnu/libgdk-3.so $LOCAL_DIR/lib/libgdk-3.so
cp $LOCAL_DIR/lib/x86_64-linux-gnu/libgdk-3.so $LOCAL_DIR/lib/libgdk-3.so.0
cp $LOCAL_DIR/lib/x86_64-linux-gnu/libgtk-3.so $LOCAL_DIR/lib/libgtk-3.so
cd $HOME
ln -s /usr/lib/x86_64-linux-gnu/gtk-3.0/modules/libcanberra-gtk-module.so .local/lib/libcanberra-gtk-module.so
ln -s /var/run/dbus/system_bus_socket .local/var/run/dbus/system_bus_socket
