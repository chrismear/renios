#!/bin/bash

. $(dirname $0)/utils.sh

# ftp://ftp.simplesystems.org//pub/libpng/png/src/history/libpng12/libpng-1.2.49.tar.bz2

if [ ! -f $CACHEROOT/libpng-1.2.49.tar.bz2 ]; then
  echo 'Downloading libpng source'
  try curl -L http://downloads.sourceforge.net/project/libpng/libpng12/older-releases/1.2.49/libpng-1.2.49.tar.bz2 > $CACHEROOT/libpng-1.2.49.tar.bz2
fi

try rm -rf $TMPROOT/libpng-1.2.49
echo 'Extracting libpng source'
try tar xjf $CACHEROOT/libpng-1.2.49.tar.bz2 2>&1 >/dev/null
try mv libpng-1.2.49 $TMPROOT

pushd $TMPROOT/libpng-1.2.49

echo 'Configuring libpng'
try autoreconf -fiv
try ./configure --prefix=$DESTROOT \
  --host="$ARM_HOST" \
  --enable-static=yes \
  --enable-shared=no \
  CC="$ARM_CC" AR="$ARM_AR" \
  LDFLAGS="$ARM_LDFLAGS" CFLAGS="$ARM_CFLAGS" 2>&1 >/dev/null
try make clean 2>&1 >/dev/null
echo 'Building libpng'
try make 2>&1 >/dev/null
try make install 2>&1 >/dev/null

popd

echo 'Moving libpng build products into place'
try cp $DESTROOT/lib/libpng12.a $BUILDROOT/lib
try ln -sf libpng12.a $BUILDROOT/lib/libpng.a

try cp -a $DESTROOT/include/libpng12 $BUILDROOT/include

try rm -f $BUILDROOT/include/png.h
try ln -sf libpng12/png.h $BUILDROOT/include/png.h

try rm -f $BUILDROOT/include/pngconf.h
try ln -sf libpng12/pngconf.h $BUILDROOT/include/pngconf.h
