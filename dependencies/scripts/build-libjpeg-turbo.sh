#!/bin/bash

. $(dirname $0)/environment.sh

if [ ! -f $CACHEROOT/libjpeg-turbo-1.2.0.tar.gz ]; then
  echo 'Downloading libjpeg-turbo source'
  try curl -L http://downloads.sourceforge.net/project/libjpeg-turbo/1.2.0/libjpeg-turbo-1.2.0.tar.gz > $CACHEROOT/libjpeg-turbo-1.2.0.tar.gz
fi

try rm -rf $TMPROOT/libjpeg-turbo-1.2.0
echo 'Extracting libjpeg-turbo source'
try tar xjf $CACHEROOT/libjpeg-turbo-1.2.0.tar.gz
try mv libjpeg-turbo-1.2.0 $TMPROOT

pushd $TMPROOT/libjpeg-turbo-1.2.0

echo 'Configuring libjpeg-turbo'
try ./configure --prefix=$DESTROOT \
  --host=arm-apple-darwin \
  --enable-static=yes \
  --enable-shared=no \
  CC="$ARM_CC" AR="$ARM_AR" \
  LDFLAGS="$ARM_LDFLAGS" CFLAGS="$ARM_CFLAGS"
try make clean
echo 'Building libjpeg-turbo'
try make
try make install

popd

echo 'Moving libjpeg-turbo build products into place'
try cp $DESTROOT/lib/libjpeg.a $BUILDROOT/lib

try cp $DESTROOT/include/jpeglib.h $BUILDROOT/include
try cp $DESTROOT/include/jconfig.h $BUILDROOT/include
try cp $DESTROOT/include/jerror.h $BUILDROOT/include
try cp $DESTROOT/include/jmorecfg.h $BUILDROOT/include
try cp $DESTROOT/include/jerror.h $BUILDROOT/include
