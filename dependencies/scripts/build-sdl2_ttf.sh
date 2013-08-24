#!/bin/bash

. $(dirname $0)/utils.sh

# Clone SDL_ttf if necessary
if [ ! -d $TMPROOT/SDL_ttf ] ; then
  echo 'Cloning SDL_ttf source'
  try pushd $TMPROOT
  try hg clone -u $SDL2_TTF_REVISION http://hg.libsdl.org/SDL_ttf SDL_ttf
  try cd SDL_ttf
  try popd
fi

try pushd $TMPROOT/SDL_ttf
try hg up -r $SDL2_TTF_REVISION

# Patch
# echo 'Patching SDL_ttf source'
# try patch -p1 < $RENIOSDEPROOT/patches/SDL_ttf/SDL_ttf-$SDL2_TTF_REVISION-ios.patch

set -x
try ./configure --prefix=$DESTROOT \
  --with-freetype-prefix=$DESTROOT \
  --host=arm-apple-darwin \
  --enable-static=yes \
  --enable-shared=no \
  --without-x \
  --disable-sdl-test \
  CC="$ARM_CC" AR="$ARM_AR" \
  LDFLAGS="$ARM_LDFLAGS" CFLAGS="$ARM_CFLAGS" \
  SDL_CONFIG="$BUILDROOT/bin/sdl-config"

try make clean
try make libSDL2_ttf.la

popd

try cp $TMPROOT/SDL_ttf/.libs/libSDL2_ttf.a $BUILDROOT/lib/libSDL2_ttf.a
try cp -a $TMPROOT/SDL_ttf/SDL_ttf.h $BUILDROOT/include
