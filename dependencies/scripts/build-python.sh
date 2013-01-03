#!/bin/bash

# From https://github.com/kivy/kivy-ios

# credit to:
# http://randomsplat.com/id5-cross-compiling-python-for-embedded-linux.html
# http://latenitesoft.blogspot.com/2008/10/iphone-programming-tips-building-unix.html

. $(dirname $0)/environment.sh

# Download Python if necessary
if [ ! -f $CACHEROOT/Python-$PYTHON_VERSION.tar.bz2 ]; then
  echo 'Downloading Python source'
  curl http://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.bz2 > $CACHEROOT/Python-$PYTHON_VERSION.tar.bz2
fi

# Clean any previous extractions,
rm -rf $TMPROOT/Python-$PYTHON_VERSION
# then extract Python source to cache directory
echo 'Extracting Python source'
try tar -xjf $CACHEROOT/Python-$PYTHON_VERSION.tar.bz2
try mv Python-$PYTHON_VERSION $TMPROOT
try pushd $TMPROOT/Python-$PYTHON_VERSION

# Patch and do custom compile set-up
echo 'Patching Python source'
try patch -p1 < $RENIOSDEPROOT/patches/python/Python-$PYTHON_VERSION-ssize-t-max.patch
try patch -p1 < $RENIOSDEPROOT/patches/python/Python-$PYTHON_VERSION-dynload.patch

try cp $RENIOSDEPROOT/src/python/ModulesSetup Modules/Setup.local
try cp $RENIOSDEPROOT/src/python/_scproxy.py Lib/_scproxy.py

echo 'Building for native machine'
try ./configure CC="clang -Qunused-arguments -fcolor-diagnostics"
try make python.exe Parser/pgen
try mv python.exe hostpython
try mv Parser/pgen Parser/hostpgen
try make distclean

echo 'Building for iOS'
try patch -p1 < $RENIOSDEPROOT/patches/python/Python-$PYTHON_VERSION-xcompile.patch
export CPPFLAGS="-I$SDKROOT/usr/lib/gcc/arm-apple-darwin11/4.2.1/include/ -I$SDKROOT/usr/include/"
export CPP="$CCACHE /usr/bin/cpp $CPPFLAGS"
export MACOSX_DEPLOYMENT_TARGET=

# make a link to a differently named library for who knows what reason
mkdir extralibs||echo "foo"
ln -s "$SDKROOT/usr/lib/libgcc_s.1.dylib" extralibs/libgcc_s.10.4.dylib || echo "sdf"

try cp $RENIOSDEPROOT/src/python/ModulesSetup Modules/Setup.local

try ./configure CC="$ARM_CC" LD="$ARM_LD" \
  CFLAGS="$ARM_CFLAGS" \
  LDFLAGS="$ARM_LDFLAGS -Lextralibs/" \
  --disable-toolbox-glue \
  --host=armv7-apple-darwin \
  --prefix=/python \
    --without-doc-strings

try make HOSTPYTHON=./hostpython HOSTPGEN=./Parser/hostpgen \
     CROSS_COMPILE_TARGET=yes

try make install HOSTPYTHON=./hostpython CROSS_COMPILE_TARGET=yes prefix="$BUILDROOT/python"

try mv -f $BUILDROOT/python/lib/libpython2.7.a $BUILDROOT/lib/

deduplicate $BUILDROOT/lib/libpython2.7.a

echo "Starting reducing python 2.7"

try rm -rf $BUILDROOT/python/embed/include/python2.7
try mkdir -p $BUILDROOT/python/embed/include/python2.7
try cp $BUILDROOT/python/include/python2.7/pyconfig.h $BUILDROOT/python/embed/include/python2.7/pyconfig.h

try cd $BUILDROOT/python/lib/python2.7
find . -iname '*.pyc' | xargs rm
find . -iname '*.py' | xargs rm
find . -iname 'test*' | xargs rm -rf
rm -rf *test* lib* wsgiref bsddb curses idlelib hotshot || true
try cd ..
rm -rf pkgconfig || true

echo "Compressing to python27.zip"
try pushd $BUILDROOT/python/lib/python2.7
rm config/libpython2.7.a config/python.o config/config.c.in config/makesetup
mv config ..
mv site-packages ..
zip -r ../python27.zip *
rm -rf *
mv ../config .
mv ../site-packages .
popd
