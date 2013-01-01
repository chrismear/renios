#!/bin/bash

. $(dirname $0)/environment.sh

# Download Ren'Py SDK if necessary
if [ ! -f $CACHEROOT/renpy-$RENPY_VERSION-sdk.tar.bz2 ]; then
  echo 'Downloading RenPy SDK'
  curl http://www.renpy.org/dl/$RENPY_VERSION/renpy-$RENPY_VERSION-sdk.tar.bz2 > $CACHEROOT/renpy-$RENPY_VERSION-sdk.tar.bz2
fi

# Clean any previous extractions,
rm -rf $TMPROOT/renpy-$RENPY_VERSION-sdk
# then extract Python source to cache directory
echo 'Extracting RenPy SDK'
try tar -xjf $CACHEROOT/renpy-$RENPY_VERSION-sdk.tar.bz2
try mv renpy-$RENPY_VERSION-sdk $TMPROOT

try pushd $TMPROOT/renpy-$RENPY_VERSION-sdk

# Patch
echo 'Patching RenPy SDK'
try patch -p1 < $RENIOSDEPROOT/patches/renpy/renpy-$RENPY_VERSION-ios.patch

# Set environment variables for Python module cross-compile
OLD_CC="$CC"
OLD_CFLAGS="$CFLAGS"
OLD_LDSHARED="$LDSHARED"
export CC="$ARM_CC"
export CFLAGS="$ARM_CFLAGS"
export CFLAGS="$CFLAGS -I$BUILDROOT/include -I$BUILDROOT/include/SDL -I$BUILDROOT/include/freetype"
export LDSHARED="$RENIOSDEPROOT/scripts/liblink"

HOSTPYTHON="$RENIOSDEPROOT/tmp/Python-$PYTHON_VERSION/hostpython"

pushd module
export RENIOS_IOS=1
$HOSTPYTHON setup.py build_ext -g
popd

export CC="$OLD_CC"
export CFLAGS="$OLD_CFLAGS"
export LDSHARED="$OLD_LDSHARED"

popd
