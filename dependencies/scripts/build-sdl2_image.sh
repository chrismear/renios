#!/bin/bash

. $(dirname $0)/environment.sh

# Clone SDL_image if necessary
if [ ! -d $TMPROOT/SDL_image ] ; then
  echo 'Cloning SDL_image source'
  try pushd $TMPROOT
  try hg clone -u $SDL2_IMAGE_REVISION http://hg.libsdl.org/SDL_image SDL_image
  try cd SDL_image
  try popd
fi

try pushd $TMPROOT/SDL_image
try hg up -r $SDL2_IMAGE_REVISION

# Patch
# echo 'Patching SDL_image source'
# try patch -p1 < $RENIOSDEPROOT/patches/SDL_image/SDL_image-$SDL2_IMAGE_REVISION-ios.patch

set -x
try ./configure --prefix=$DESTROOT \
  --with-freetype-prefix=$DESTROOT \
  --host=arm-apple-darwin \
  --enable-static=yes \
  --enable-shared=no \
  --without-x \
  --disable-sdl-test \
  OBJC="$ARM_CC" \
  CC="$ARM_CC" AR="$ARM_AR" \
  LDFLAGS="$ARM_LDFLAGS" CFLAGS="$ARM_CFLAGS" \
  SDL_CONFIG="$BUILDROOT/bin/sdl-config"

try make clean
try make libSDL2_image.la

popd

try cp $TMPROOT/SDL_image/.libs/libSDL2_image.a $BUILDROOT/lib/libSDL2_image.a
try cp -a $TMPROOT/SDL_image/SDL_image.h $BUILDROOT/include
