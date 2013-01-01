#!/bin/bash

. $(dirname $0)/environment.sh

if [ ! -f $CACHEROOT/freetype-$FREETYPE_VERSION.tar.gz ]; then
  try curl -L http://download.savannah.gnu.org/releases/freetype/freetype-old/freetype-$FREETYPE_VERSION.tar.gz > $CACHEROOT/freetype-$FREETYPE_VERSION.tar.gz
fi
if [ ! -d $TMPROOT/freetype-$FREETYPE_VERSION ]; then
  try rm -rf $TMPROOT/freetype-$FREETYPE_VERSION
  try tar xvf $CACHEROOT/freetype-$FREETYPE_VERSION.tar.gz
  try mv freetype-$FREETYPE_VERSION $TMPROOT
fi

if [ -f $TMPROOT/freetype-$FREETYPE_VERSION/libfreetype-arm7.a ]; then
  exit 0;
fi

# lib not found, compile it
pushd $TMPROOT/freetype-$FREETYPE_VERSION
try ./configure --prefix=$DESTROOT \
  --host=arm-apple-darwin \
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
