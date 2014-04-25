#!/bin/bash

. $(dirname $0)/utils.sh

export PATH="$PATH:`pwd`"

if [ ! -f $CACHEROOT/libjpeg-turbo-1.2.0.tar.gz ]; then
  echo 'Downloading libjpeg-turbo source'
  try curl -L http://downloads.sourceforge.net/project/libjpeg-turbo/1.2.0/libjpeg-turbo-1.2.0.tar.gz > $CACHEROOT/libjpeg-turbo-1.2.0.tar.gz
fi

try rm -rf $TMPROOT/libjpeg-turbo-1.2.0
echo 'Extracting libjpeg-turbo source'
try tar xjf $CACHEROOT/libjpeg-turbo-1.2.0.tar.gz 2>&1 >/dev/null
try mv libjpeg-turbo-1.2.0 $TMPROOT

pushd $TMPROOT/libjpeg-turbo-1.2.0

echo 'Configuring libjpeg-turbo'
try autoreconf -fiv 2>&1 >/dev/null

# Under Xcode 5, this compile fails if -O is set to anything other than 0.
try ./configure --prefix=$DESTROOT \
  --with-jpeg8 \
  --host="$ARM_HOST" \
  --enable-static \
  --disable-shared \
  CC="$ARM_REAL_CC" AR="$ARM_AR" \
  LDFLAGS="-no-integrated-as $ARM_LDFLAGS" \
  CFLAGS="-no-integrated-as $ARM_CFLAGS -O0" \
  CPPFLAGS="$CFLAGS"
  CCASFLAGS="-no-integrated-as $ARM_CFLAGS" 2>&1 >/dev/null

try make clean 2>&1 >/dev/null
echo 'Building libjpeg-turbo'
try make 2>&1 >/dev/null
try make install 2>&1 >/dev/null

popd

echo 'Moving libjpeg-turbo build products into place'
try cp $DESTROOT/lib/libjpeg.a $BUILDROOT/lib

try cp $DESTROOT/include/jpeglib.h $BUILDROOT/include
try cp $DESTROOT/include/jconfig.h $BUILDROOT/include
try cp $DESTROOT/include/jerror.h $BUILDROOT/include
try cp $DESTROOT/include/jmorecfg.h $BUILDROOT/include
try cp $DESTROOT/include/jerror.h $BUILDROOT/include
