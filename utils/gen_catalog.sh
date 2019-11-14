#!/bin/bash

LOCAL_DIR=$HOME/.local

if [ ! -e $LOCAL_DIR/etc/xml/docbook ]; then
    xmlcatalog --noout --create $LOCAL_DIR/etc/xml/docbook
fi &&
xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.5//EN" \
    "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5/calstblx.dtd" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5/soextblx.dtd" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5/dbpoolx.mod" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5/dbhierx.mod" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5/htmltblx.mod" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Notations V4.5//EN" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5/dbnotnx.mod" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5/dbcentx.mod" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5/dbgenent.mod" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.5" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5" \
    $LOCAL_DIR/etc/xml/docbook &&
xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.5" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5" \
    $LOCAL_DIR/etc/xml/docbook

if [ ! -e $LOCAL_DIR/etc/xml/catalog ]; then
    xmlcatalog --noout --create $LOCAL_DIR/etc/xml/catalog
fi &&
xmlcatalog --noout --add "delegatePublic" \
    "-//OASIS//ENTITIES DocBook XML" \
    "file://$LOCAL_DIR/etc/xml/docbook" \
    $LOCAL_DIR/etc/xml/catalog &&
xmlcatalog --noout --add "delegatePublic" \
    "-//OASIS//DTD DocBook XML" \
    "file://$LOCAL_DIR/etc/xml/docbook" \
    $LOCAL_DIR/etc/xml/catalog &&
xmlcatalog --noout --add "delegateSystem" \
    "http://www.oasis-open.org/docbook/" \
    "file://$LOCAL_DIR/etc/xml/docbook" \
    $LOCAL_DIR/etc/xml/catalog &&
xmlcatalog --noout --add "delegateURI" \
    "http://www.oasis-open.org/docbook/" \
    "file://$LOCAL_DIR/etc/xml/docbook" \
    $LOCAL_DIR/etc/xml/catalog

for DTDVERSION in 4.1.2 4.2 4.3 4.4
do
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V$DTDVERSION//EN" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/docbookx.dtd" \
    $LOCAL_DIR/etc/xml/docbook
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5" \
    $LOCAL_DIR/etc/xml/docbook
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
    "file://$HOME/share/xml/docbook/xml-dtd-4.5" \
    $LOCAL_DIR/etc/xml/docbook
  xmlcatalog --noout --add "delegateSystem" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
    "file://$LOCAL_DIR/etc/xml/docbook" \
    $LOCAL_DIR/etc/xml/catalog
  xmlcatalog --noout --add "delegateURI" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
    "file://$LOCAL_DIR/etc/xml/docbook" \
    $LOCAL_DIR/etc/xml/catalog
done

if [ ! -d $LOCAL_DIR/etc/xml ]; then install -v -m755 -d $LOCAL_DIR/etc/xml; fi &&
if [ ! -f $LOCAL_DIR/etc/xml/catalog ]; then
    xmlcatalog --noout --create $LOCAL_DIR/etc/xml/catalog
fi &&

xmlcatalog --noout --add "rewriteSystem" \
           "http://docbook.sourceforge.net/release/xsl/1.71.1" \
           "$HOME/share/xml/docbook/xsl-stylesheets-1.71.1" \
    $LOCAL_DIR/etc/xml/catalog &&

xmlcatalog --noout --add "rewriteURI" \
           "http://docbook.sourceforge.net/release/xsl/1.71.1" \
           "$HOME/share/xml/docbook/xsl-stylesheets-1.71.1" \
    $LOCAL_DIR/etc/xml/catalog &&

xmlcatalog --noout --add "rewriteSystem" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "$HOME/share/xml/docbook/xsl-stylesheets-1.71.1" \
    $LOCAL_DIR/etc/xml/catalog &&

xmlcatalog --noout --add "rewriteURI" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "$HOME/share/xml/docbook/xsl-stylesheets-1.71.1" \
    $LOCAL_DIR/etc/xml/catalog

