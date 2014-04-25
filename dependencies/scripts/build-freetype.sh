#!/bin/bash

. $(dirname $0)/utils.sh

if [ ! -f $CACHEROOT/freetype-$FREETYPE_VERSION.tar.gz ]; then
  echo "Downloading freetype source"
  try curl -L http://download.savannah.gnu.org/releases/freetype/freetype-old/freetype-$FREETYPE_VERSION.tar.gz > $CACHEROOT/freetype-$FREETYPE_VERSION.tar.gz
fi

echo "Unpacking freetype"
try rm -rf $TMPROOT/freetype-$FREETYPE_VERSION
try tar xvf $CACHEROOT/freetype-$FREETYPE_VERSION.tar.gz
try mv freetype-$FREETYPE_VERSION $TMPROOT

# if [ -f $TMPROOT/freetype-$FREETYPE_VERSION/libfreetype-arm7.a ]; then
#   exit 0;
# fi

# lib not found, compile it
echo "Configuring freetype"
pushd $TMPROOT/freetype-$FREETYPE_VERSION
try ./configure --prefix=$DESTROOT \
  --host="$ARM_HOST" \
  --enable-static=yes \
  --enable-shared=no \
  CC="$ARM_CC" AR="$ARM_AR" \
  LDFLAGS="$ARM_LDFLAGS" CFLAGS="$ARM_CFLAGS"
echo "Building freetype"
try make clean
try make
try make install

# copy to buildroot
echo "Moving freetype build products into place"
cp objs/.libs/libfreetype.a $BUILDROOT/lib/libfreetype.a
cp -a include $BUILDROOT/include/freetype

popd
