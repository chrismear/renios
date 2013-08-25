#!/bin/bash

. $(dirname $0)/utils.sh

if [ ! -f $CACHEROOT/freetype-$FREETYPE_VERSION.tar.gz ]; then
  try curl -L http://download.savannah.gnu.org/releases/freetype/freetype-old/freetype-$FREETYPE_VERSION.tar.gz > $CACHEROOT/freetype-$FREETYPE_VERSION.tar.gz
fi

try rm -rf $TMPROOT/freetype-$FREETYPE_VERSION
try tar xvf $CACHEROOT/freetype-$FREETYPE_VERSION.tar.gz
try mv freetype-$FREETYPE_VERSION $TMPROOT

# if [ -f $TMPROOT/freetype-$FREETYPE_VERSION/libfreetype-arm7.a ]; then
#   exit 0;
# fi

# lib not found, compile it
pushd $TMPROOT/freetype-$FREETYPE_VERSION
try ./configure --prefix=$DESTROOT \
  --host="$ARM_HOST" \
  --enable-static=yes \
  --enable-shared=no \
  CC="$ARM_CC" AR="$ARM_AR" \
  LDFLAGS="$ARM_LDFLAGS" CFLAGS="$ARM_CFLAGS"
try make clean
try make
try make install

# copy to buildroot
cp objs/.libs/libfreetype.a $BUILDROOT/lib/libfreetype.a
cp -a include $BUILDROOT/include/freetype

popd
