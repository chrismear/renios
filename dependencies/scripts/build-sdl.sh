#!/bin/bash

. $(dirname $0)/environment.sh

# http://www.libsdl.org/release/SDL-1.2.15.tar.gz

# Download SDL source if necessary
if [ ! -f $CACHEROOT/SDL-$SDL_VERSION.tar.gz ]; then
  echo 'Downloading SDL source'
  curl http://www.libsdl.org/release/SDL-$SDL_VERSION.tar.gz > $CACHEROOT/SDL-$SDL_VERSION.tar.gz
fi

# Clean any previous extractions,
rm -rf $TMPROOT/SDL-$SDL_VERSION
# then extract SDL source to cache directory
echo 'Extracting SDL source'
try tar -xzf $CACHEROOT/SDL-$SDL_VERSION.tar.gz
try mv SDL-$SDL_VERSION $TMPROOT

try pushd $TMPROOT/SDL-$SDL_VERSION

# Patch
echo 'Patching SDL source'
try patch -p1 < $RENIOSDEPROOT/patches/sdl/sdl-$SDL_VERSION-ios.patch
try chmod a+x $TMPROOT/SDL-$SDL_VERSION/build-scripts/iosbuild.sh

try pushd $TMPROOT/SDL-$SDL_VERSION/build-scripts

# Configure
echo 'Configuring SDL'
try ./iosbuild.sh configure-armv7

# Build
echo 'Building SDL'
try ./iosbuild.sh make-armv7

try popd # build-scripts

try popd # SDL

echo 'Moving SDL build products into place'
try cp $TMPROOT/SDL-$SDL_VERSION/build/armv7/build/.libs/libSDL.a $BUILDROOT/lib

try mkdir -p $BUILDROOT/include/SDL
try cp -a $TMPROOT/SDL-$SDL_VERSION/build/armv7/include/* $BUILDROOT/include/SDL

# Usage: ./iosbuild.sh [all|configure[-armv6|-armv7|-i386]|make[-armv6|-armv7|-i386]|merge|clean[-armv6|-armv7|-i386]]
