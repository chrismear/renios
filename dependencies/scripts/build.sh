#!/bin/bash

. $(dirname $0)/utils.sh

RENIOSCOMPONENT=$1

if [ "X$RENIOSCOMPONENT" == "X" ]; then
  echo $(basename $0) "<component>"
  exit 1
fi

. $(dirname $0)/environment.sh

echo "STARTING REN'IOS BUILD"

# BUILD FOR SIMULATOR

echo "BUILDING FOR SIMULATOR (DEBUG)"

. $(dirname $0)/environment-simulator.sh
. $(dirname $0)/environment-debug.sh
try $(dirname $0)/build-$RENIOSCOMPONENT.sh

echo "BUILDING FOR SIMULATOR (RELEASE)"

. $(dirname $0)/environment-simulator.sh
. $(dirname $0)/environment-release.sh
try $(dirname $0)/build-$RENIOSCOMPONENT.sh

# BUILD FOR DEVICE, ARMV7

echo "BUILDING FOR ARMV7 (DEBUG)"

. $(dirname $0)/environment-armv7.sh
. $(dirname $0)/environment-debug.sh
try $(dirname $0)/build-$RENIOSCOMPONENT.sh

echo "BUILDING FOR ARMV7 (RELEASE)"

. $(dirname $0)/environment-armv7.sh
. $(dirname $0)/environment-release.sh
try $(dirname $0)/build-$RENIOSCOMPONENT.sh

# BUILD FOR DEVICE, ARMV7S

echo "BUILDING FOR ARMV7S (DEBUG)"

. $(dirname $0)/environment-armv7s.sh
. $(dirname $0)/environment-debug.sh
try $(dirname $0)/build-$RENIOSCOMPONENT.sh

echo "BUILDING FOR ARMV7S (RELEASE)"

. $(dirname $0)/environment-armv7s.sh
. $(dirname $0)/environment-release.sh
try $(dirname $0)/build-$RENIOSCOMPONENT.sh

# BUILD FOR DEVICE, ARM64

echo "BUILDING FOR ARM64 (DEBUG)"

. $(dirname $0)/environment-arm64.sh
. $(dirname $0)/environment-debug.sh
try $(dirname $0)/build-$RENIOSCOMPONENT.sh

echo "BUILDING FOR ARM64 (RELEASE)"

. $(dirname $0)/environment-arm64.sh
. $(dirname $0)/environment-release.sh
try $(dirname $0)/build-$RENIOSCOMPONENT.sh

if [ "$RENIOSCOMPONENT" == "all" ]; then

  echo "PRODUCING FAT BINARIES"

  # PRODUCE FAT BINARIES

  try mkdir -p $RENIOSDEPROOT/build/debug

  # Copy most (non-binary) files from one of the builds, doesn't matter which.
  try cp -a $RENIOSDEPROOT/build/iphoneos-armv7/debug/include $RENIOSDEPROOT/build/debug/
  try cp -a $RENIOSDEPROOT/build/iphoneos-armv7/debug/python $RENIOSDEPROOT/build/debug/
  try cp -a $RENIOSDEPROOT/build/iphoneos-armv7/debug/renpy $RENIOSDEPROOT/build/debug/

  # Build fat binaries for the .a libraries
  # TODO Do this programatically rather than writing each command explicitly here
  try mkdir -p $RENIOSDEPROOT/build/debug/lib
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libSDL.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libSDL.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libSDL.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libSDL.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libSDL.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libSDL2_image.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libSDL2_image.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libSDL2_image.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libSDL2_image.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libSDL2_image.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libSDL2_ttf.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libSDL2_ttf.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libSDL2_ttf.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libSDL2_ttf.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libSDL2_ttf.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libavcodec.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libavcodec.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libavcodec.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libavcodec.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libavcodec.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libavdevice.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libavdevice.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libavdevice.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libavdevice.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libavdevice.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libavfilter.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libavfilter.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libavfilter.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libavfilter.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libavfilter.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libavformat.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libavformat.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libavformat.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libavformat.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libavformat.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libavutil.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libavutil.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libavutil.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libavutil.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libavutil.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libfreetype.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libfreetype.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libfreetype.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libfreetype.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libfreetype.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libfribidi.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libfribidi.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libfribidi.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libfribidi.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libfribidi.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libjpeg.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libjpeg.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libjpeg.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libjpeg.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libjpeg.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libpng12.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libpng12.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libpng12.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libpng12.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libpng12.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libpygame.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libpygame.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libpygame.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libpygame.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libpygame.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libpython2.7.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libpython2.7.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libpython2.7.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libpython2.7.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libpython2.7.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/librenpy.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/librenpy.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/librenpy.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/librenpy.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/librenpy.a
  try lipo -create -output $RENIOSDEPROOT/build/debug/lib/libswscale.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/debug/lib/libswscale.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/debug/lib/libswscale.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/debug/lib/libswscale.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/debug/lib/libswscale.a
  try pushd $RENIOSDEPROOT/build/debug/lib
  # Strip debugging symbols to avoid "Unable to open object file" errors
  # TODO: So what is the point of having a separate debug build anymore?
  try xcrun strip -Sxr *.a
  try ln -sf libpng12.a libpng.a
  try popd

  try mkdir -p $RENIOSDEPROOT/build/release

  # Copy most (non-binary) files from one of the builds, doesn't matter which.
  try cp -a $RENIOSDEPROOT/build/iphoneos-armv7/release/include $RENIOSDEPROOT/build/release/
  try cp -a $RENIOSDEPROOT/build/iphoneos-armv7/release/python $RENIOSDEPROOT/build/release/
  try cp -a $RENIOSDEPROOT/build/iphoneos-armv7/release/renpy $RENIOSDEPROOT/build/release/

  # Build fat binaries for the .a libraries
  # TODO Do this programatically rather than writing each command explicitly here
  try mkdir -p $RENIOSDEPROOT/build/release/lib
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libSDL.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libSDL.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libSDL.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libSDL.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libSDL.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libSDL2_image.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libSDL2_image.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libSDL2_image.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libSDL2_image.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libSDL2_image.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libSDL2_ttf.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libSDL2_ttf.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libSDL2_ttf.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libSDL2_ttf.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libSDL2_ttf.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libavcodec.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libavcodec.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libavcodec.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libavcodec.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libavcodec.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libavdevice.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libavdevice.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libavdevice.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libavdevice.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libavdevice.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libavfilter.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libavfilter.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libavfilter.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libavfilter.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libavfilter.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libavformat.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libavformat.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libavformat.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libavformat.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libavformat.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libavutil.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libavutil.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libavutil.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libavutil.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libavutil.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libfreetype.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libfreetype.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libfreetype.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libfreetype.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libfreetype.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libfribidi.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libfribidi.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libfribidi.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libfribidi.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libfribidi.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libjpeg.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libjpeg.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libjpeg.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libjpeg.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libjpeg.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libpng12.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libpng12.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libpng12.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libpng12.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libpng12.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libpygame.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libpygame.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libpygame.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libpygame.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libpygame.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libpython2.7.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libpython2.7.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libpython2.7.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libpython2.7.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libpython2.7.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/librenpy.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/librenpy.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/librenpy.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/librenpy.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/librenpy.a
  try lipo -create -output $RENIOSDEPROOT/build/release/lib/libswscale.a -arch i386 $RENIOSDEPROOT/build/iphonesimulator-i386/release/lib/libswscale.a -arch armv7 $RENIOSDEPROOT/build/iphoneos-armv7/release/lib/libswscale.a -arch armv7s $RENIOSDEPROOT/build/iphoneos-armv7s/release/lib/libswscale.a -arch arm64 $RENIOSDEPROOT/build/iphoneos-arm64/release/lib/libswscale.a
  try pushd $RENIOSDEPROOT/build/release/lib
  # Strip debugging symbols to avoid "Unable to open object file" errors
  try xcrun strip -Sxr *.a
  try ln -sf libpng12.a libpng.a
  try popd

fi

echo "REN'IOS BUILD COMPLETE"
