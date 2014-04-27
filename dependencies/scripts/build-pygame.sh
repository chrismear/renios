#!/bin/bash

. $(dirname $0)/utils.sh

# Download pygame if necessary
if [ ! -f $CACHEROOT/pygame-${PYGAME_VERSION}release.tar.gz ]; then
  echo 'Downloading pygame source'
  curl http://www.pygame.org/ftp/pygame-${PYGAME_VERSION}release.tar.gz > $CACHEROOT/pygame-${PYGAME_VERSION}release.tar.gz
fi

# Clean any previous extractions,
rm -rf $TMPROOT/pygame-${PYGAME_VERSION}release
# then extract pygame source to cache directory
echo 'Extracting pygame source'
try tar -xzf $CACHEROOT/pygame-${PYGAME_VERSION}release.tar.gz 2>&1 >/dev/null
try mv pygame-${PYGAME_VERSION}release $TMPROOT

try pushd $TMPROOT/pygame-${PYGAME_VERSION}release

# Patch
echo 'Patching pygame source'
# Ordinary 'patch' command chokes on this patch, so use Git's patch application command
# instead.
# 
# Our current working directory is inside a gitignore'd directory, so although git-apply
# usually works outside of a Git working directory, it will do nothing if we try and
# run it here. Instead, make a new Git repository, apply the patch, and then remove
# the temporary repository.
try git init
try git apply $RENIOSDEPROOT/patches/pygame/pygame-$PYGAME_VERSION-renios.patch
try rm -rf .git

# Set environment variables for Python module cross-compile
OLD_CC="$CC"
OLD_CFLAGS="$CFLAGS"
OLD_LDSHARED="$LDSHARED"
export CC="$ARM_CC"
export CFLAGS="$ARM_CFLAGS"
export CFLAGS="$CFLAGS -I$BUILDROOT/include"
export LDSHARED="$RENIOSDEPROOT/scripts/liblink"

HOSTPYTHON="$RENIOSDEPROOT/tmp/Python-$PYTHON_VERSION/hostpython"

echo 'Configuring pygame source'
export RENIOS_IOS=1
try $HOSTPYTHON config.py 2>&1 >/dev/null

echo 'Building pygame'
try $HOSTPYTHON setup.py build_ext -g 2>&1 >/dev/null
rm -rdf iosbuild
try $HOSTPYTHON setup.py install --root iosbuild 2>&1 >/dev/null

echo "Linking and deduplicating pygame libraries"
rm -rf $BUILDROOT/lib/libpygame.a
bd=$TMPROOT/pygame-${PYGAME_VERSION}release/build/lib.macosx-*/pygame
try $RENIOSDEPROOT/scripts/biglink $BUILDROOT/lib/libpygame.a $bd
deduplicate $BUILDROOT/lib/libpygame.a

echo "Moving pygame build products into place"
# Strip away the large stuff
# find iosbuild/ | grep -E '*\.(py|pyc|so\.o|so\.a|so\.libs)$$' | xargs rm
rm -rdf "$BUILDROOT/python/lib/python2.7/site-packages/pygame"
# Copy to python for iOS installation
cp -R "iosbuild/usr/local/lib/python2.7/site-packages/pygame" "$BUILDROOT/python/lib/python2.7/site-packages"

rm -rdf "$BUILDROOT/include/pygame"
cp -R "iosbuild/usr/local/include/python2.7/pygame" "$BUILDROOT/include"

export CC="$OLD_CC"
export CFLAGS="$OLD_CFLAGS"
export LDSHARED="$OLD_LDSHARED"

popd # pygame

