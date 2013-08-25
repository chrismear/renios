#!/bin/bash

. $(dirname $0)/utils.sh

# Download Ren'Py SDK if necessary
if [ ! -f $CACHEROOT/renpy-$RENPY_VERSION-sdk.tar.bz2 ]; then
  echo 'Downloading RenPy SDK'
  curl http://www.renpy.org/dl/$RENPY_VERSION/renpy-$RENPY_VERSION-sdk.tar.bz2 > $CACHEROOT/renpy-$RENPY_VERSION-sdk.tar.bz2
fi

# Clean any previous extractions,
rm -rdf $TMPROOT/renpy-$RENPY_VERSION-sdk
# then extract Python source to cache directory
echo 'Extracting RenPy SDK'
try tar -xjf $CACHEROOT/renpy-$RENPY_VERSION-sdk.tar.bz2
try mv renpy-$RENPY_VERSION-sdk $TMPROOT

try pushd $TMPROOT/renpy-$RENPY_VERSION-sdk

# Patch
echo 'Patching RenPy SDK'
try patch -p1 < $RENIOSDEPROOT/patches/renpy/renpy-$RENPY_VERSION-renios.patch

# Set environment variables for Python module cross-compile
OLD_CC="$CC"
OLD_CFLAGS="$CFLAGS"
OLD_LDSHARED="$LDSHARED"
export CC="$ARM_CC"
export CFLAGS="$ARM_CFLAGS"
export CFLAGS="$CFLAGS -I$BUILDROOT/include -I$BUILDROOT/include/SDL -I$BUILDROOT/include/freetype"
export CFLAGS="$CFLAGS -I$IOSSDKROOT/System/Library/Frameworks/OpenGLES.framework/Headers"
export LDSHARED="$RENIOSDEPROOT/scripts/liblink"

HOSTPYTHON="$RENIOSDEPROOT/tmp/Python-$PYTHON_VERSION/hostpython"

pushd module
export RENIOS_IOS=1
export RENPY_CYTHON='/usr/local/bin/cython'
try $HOSTPYTHON setup.py build_ext -g

rm -rdf iosbuild
try $HOSTPYTHON setup.py install --root iosbuild

bd=$TMPROOT/renpy-${RENPY_VERSION}-sdk/module/build/lib.macosx-*
try $RENIOSDEPROOT/scripts/biglink $BUILDROOT/lib/librenpy.a $bd $bd/pysdlsound $bd/renpy/display $bd/renpy/gl $bd/renpy/text
deduplicate $BUILDROOT/lib/librenpy.a

# Copy stub *.so files into site-packages, so Python interpreter knows these modules exist.
rm -rdf "$BUILDROOT/python/lib/python2.7/site-packages/pysdlsound"
rm -rdf "$BUILDROOT/python/lib/python2.7/site-packages/renpy"
# Copy to python for iOS installation
try cp $TMPROOT/renpy-${RENPY_VERSION}-sdk/module/iosbuild/usr/local/lib/python2.7/site-packages/*.so "$BUILDROOT/python/lib/python2.7/site-packages"
try cp -R "$TMPROOT/renpy-${RENPY_VERSION}-sdk/module/iosbuild/usr/local/lib/python2.7/site-packages/pysdlsound" "$BUILDROOT/python/lib/python2.7/site-packages"
try cp -R "$TMPROOT/renpy-${RENPY_VERSION}-sdk/module/iosbuild/usr/local/lib/python2.7/site-packages/renpy" "$BUILDROOT/python/lib/python2.7/site-packages"


# # Strip away the large stuff
# # find iosbuild/ | grep -E '*\.(py|pyc|so\.o|so\.a|so\.libs)$$' | xargs rm

try rm -rdf $BUILDROOT/renpy
try mkdir -p $BUILDROOT/renpy
try cp -a "$TMPROOT/renpy-${RENPY_VERSION}-sdk/common" "$BUILDROOT/renpy/"
try cp -a "$TMPROOT/renpy-${RENPY_VERSION}-sdk/renpy" "$BUILDROOT/renpy/"

popd

export CC="$OLD_CC"
export CFLAGS="$OLD_CFLAGS"
export LDSHARED="$OLD_LDSHARED"

popd
