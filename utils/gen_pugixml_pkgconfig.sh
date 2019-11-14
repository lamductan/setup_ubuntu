LOCAL_DIR=$HOME/.local
DIRECTORY=$(cd `dirname $0` && pwd)
PUGIXML_PKGCONFIG_FILEPATH=$DIRECTORY/pkgconfig/pugixml.pc

echo "prefix=$LOCAL_DIR" > $PUGIXML_PKGCONFIG_FILEPATH 
echo "exec_prefix=\${prefix}" >> $PUGIXML_PKGCONFIG_FILEPATH
echo "libdir=\${exec_prefix}/lib/" >> $PUGIXML_PKGCONFIG_FILEPATH
echo "includedir=\${prefix}/include" >> $PUGIXML_PKGCONFIG_FILEPATH
echo >> $PUGIXML_PKGCONFIG_FILEPATH
echo "Name: pugixml" >> $PUGIXML_PKGCONFIG_FILEPATH
echo "Description: libpugixml" >> $PUGIXML_PKGCONFIG_FILEPATH
echo "Version: 1.9.0" >> $PUGIXML_PKGCONFIG_FILEPATH
echo "Libs: -L\${libdir} -lpugixml" >> $PUGIXML_PKGCONFIG_FILEPATH
echo "Cflags: -I\${includedir}/" >> $PUGIXML_PKGCONFIG_FILEPATH
