#!/bin/bash

# From https://github.com/kivy/kivy-ios

try () {
  "$@" || exit -1
}

# Find iOS SDK paths

export SDKVER=`xcodebuild -showsdks | fgrep "iphoneos" | tail -n 1 | awk '{print $2}'`
export DEVROOT=`xcode-select -print-path`/Platforms/iPhoneOS.platform/Developer
export SDKROOT=$DEVROOT/SDKs/iPhoneOS$SDKVER.sdk

if [ ! -d $DEVROOT ]; then
  echo "Unable to found the Xcode iPhoneOS.platform"
  echo
  echo "The path is automatically set from 'xcode-select -print-path'"
  echo " + /Platforms/iPhoneOS.platform/Developer"
  echo
  echo "Ensure 'xcode-select -print-path' is set."
  exit 1
fi

# Set up build locations
export RENIOSDEPROOT="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"
export BUILDROOT="$RENIOSDEPROOT/build"
export TMPROOT="$RENIOSDEPROOT/tmp"
export DESTROOT="$RENIOSDEPROOT/tmp/root"
export CACHEROOT="$RENIOSDEPROOT/cache"

# Flags for ARM cross-compilation
export ARM_CC="$DEVROOT/usr/bin/arm-apple-darwin10-llvm-gcc-4.2"
export ARM_AR="$DEVROOT/usr/bin/ar"
export ARM_LD="$DEVROOT/usr/bin/ld"
export ARM_CFLAGS="-march=armv7 -mcpu=arm176jzf -mcpu=cortex-a8"
export ARM_CFLAGS="$ARM_CFLAGS -pipe -no-cpp-precomp"
export ARM_CFLAGS="$ARM_CFLAGS -isysroot $SDKROOT"
export ARM_CFLAGS="$ARM_CFLAGS -miphoneos-version-min=$SDKVER"
export ARM_LDFLAGS="-isysroot $SDKROOT"
export ARM_LDFLAGS="$ARM_LDFLAGS -miphoneos-version-min=$SDKVER"

# Release or debug?
# export ARM_CFLAGS="$ARM_CFLAGS -O3"
export ARM_CFLAGS="$ARM_CFLAGS -O0 -g"

# create build directory if not found
try mkdir -p $BUILDROOT
try mkdir -p $BUILDROOT/include
try mkdir -p $BUILDROOT/lib
try mkdir -p $CACHEROOT
try mkdir -p $TMPROOT
try mkdir -p $DESTROOT

# Versions

export PYTHON_VERSION=2.7.3
export RENPY_VERSION=6.15.7
export PYGAME_VERSION=1.9.1
export SDL_VERSION=1.2.15
export FREETYPE_VERSION=2.3.12
export FRIBIDI_VERSION=0.19.2
export SDL2_REVISION=45187a87d35b
export SDL2_TTF_REVISION=15fdede47c58
export SDL2_IMAGE_REVISION=4a8d59cbf927
export LIBAV_VERSION=9.6

# one method to deduplicate some symbol in libraries
function deduplicate() {
  fn=$(basename $1)
  echo "== Trying to remove duplicate symbol in $1"
  try mkdir ddp
  try cd ddp
  try ar x $1
  try ar rc $fn *.o
  try ranlib $fn
  try mv -f $fn $1
  try cd ..
  try rm -rf ddp
}
