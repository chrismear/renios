#!/bin/bash

. $(dirname $0)/utils.sh

# ftp://ftp.simplesystems.org//pub/libpng/png/src/history/libpng12/libpng-1.2.49.tar.bz2

if [ ! -f $CACHEROOT/libpng-1.2.49.tar.bz2 ]; then
  echo 'Downloading libpng source'
  try curl ftp://ftp.simplesystems.org//pub/libpng/png/src/history/libpng12/libpng-1.2.49.tar.bz2 > $CACHEROOT/libpng-1.2.49.tar.bz2
fi

try rm -rf $TMPROOT/libpng-1.2.49
echo 'Extracting libpng source'
try tar xjf $CACHEROOT/libpng-1.2.49.tar.bz2
try mv libpng-1.2.49 $TMPROOT

pushd $TMPROOT/libpng-1.2.49

echo 'Configuring libpng'
try ./configure --prefix=$DESTROOT \
  --host=arm-apple-darwin \
  --enable-static=yes \
  --enable-shared=no \
  CC="$ARM_CC" AR="$ARM_AR" \
  LDFLAGS="$ARM_LDFLAGS" CFLAGS="$ARM_CFLAGS"
try make clean
echo 'Building libpng'
try make
try make install

popd

echo 'Moving libpng build products into place'
try cp $DESTROOT/lib/libpng12.a $BUILDROOT/lib
try ln -s libpng12.a $BUILDROOT/lib/libpng.a

try cp -a $DESTROOT/include/libpng12 $BUILDROOT/include

try rm -f $BUILDROOT/include/png.h
try ln -s libpng12/png.h $BUILDROOT/include/png.h

try rm -f $BUILDROOT/include/pngconf.h
try ln -s libpng12/pngconf.h $BUILDROOT/include/pngconf.h
