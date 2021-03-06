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
echo "Configuring SDL_ttf"
try ./configure --prefix=$DESTROOT \
  --with-freetype-prefix=$DESTROOT \
  --host="$ARM_HOST" \
  --enable-static=yes \
  --enable-shared=no \
  --without-x \
  --disable-sdltest \
  CC="$ARM_CC" AR="$ARM_AR" \
  LDFLAGS="$ARM_LDFLAGS" \
  CFLAGS="$ARM_CFLAGS -DHAVE_STRLCPY=1 -DHAVE_STRLEN=1" \
  SDL_CONFIG="$BUILDROOT/bin/sdl-config" 2>&1 >/dev/null

echo "Building SDL_ttf"
try make clean 2>&1 >/dev/null
try make libSDL2_ttf.la 2>&1 >/dev/null

popd

echo "Moving SDL_ttf build products into place"
try cp $TMPROOT/SDL_ttf/.libs/libSDL2_ttf.a $BUILDROOT/lib/libSDL2_ttf.a
try cp -a $TMPROOT/SDL_ttf/SDL_ttf.h $BUILDROOT/include
