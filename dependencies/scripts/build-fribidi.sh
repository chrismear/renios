#!/bin/bash

. $(dirname $0)/utils.sh

if [ ! -f $CACHEROOT/fribidi-$FRIBIDI_VERSION.tar.gz ]; then
  echo "Downloading fribidi source"
  try curl -L http://www.fribidi.org/download/fribidi-$FRIBIDI_VERSION.tar.gz > $CACHEROOT/fribidi-$FRIBIDI_VERSION.tar.gz
fi
if [ ! -d $TMPROOT/fribidi-$FRIBIDI_VERSION ]; then
  try rm -rf $TMPROOT/fribidi-$FRIBIDI_VERSION
  try tar xvf $CACHEROOT/fribidi-$FRIBIDI_VERSION.tar.gz
  try mv fribidi-$FRIBIDI_VERSION $TMPROOT
fi

# if [ -f $TMPROOT/freetype-$FRIBIDI_VERSION/libfreetype-arm7.a ]; then
#   exit 0;
# fi

# lib not found, compile it

echo "Configuring fribidi"
pushd $TMPROOT/fribidi-$FRIBIDI_VERSION
try ./configure --prefix=$DESTROOT \
  --host=arm-apple-darwin \
  --enable-static=yes \
  --enable-shared=no \
  CC="$ARM_CC" AR="$ARM_AR" \
  LD="$ARM_LD" \
  LDFLAGS="$ARM_LDFLAGS" CFLAGS="$ARM_CFLAGS -DFRIBIDI_CHUNK_SIZE=4080" 2>&1 >/dev/null

# Hack to fix broken stringize detection
try echo "#define HAVE_STRINGIZE 1" >> $TMPROOT/fribidi-$FRIBIDI_VERSION/config.h


echo "Building fribidi"
try make clean 2>&1 >/dev/null
try make 2>&1 >/dev/null
try make install 2>&1 >/dev/null

# copy to buildroot
echo "Moving fribidi build products into place"
cp $DESTROOT/lib/libfribidi.a $BUILDROOT/lib/libfribidi.a
rm -rdf $BUILDROOT/include/fribidi
cp -a $DESTROOT/include/fribidi $BUILDROOT/include

popd # fribidi
