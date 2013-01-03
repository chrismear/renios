#!/bin/bash

. $(dirname $0)/environment.sh

# Clone SDL if necessary
if [ ! -d $TMPROOT/SDL ] ; then
  echo 'Cloning SDL source'
  try pushd $TMPROOT
  try hg clone -u $SDL2_REVISION http://hg.libsdl.org/SDL SDL
  try cd SDL
  try popd
fi

pushd $TMPROOT/SDL
try hg revert --all
try hg purge
try hg up -r $SDL2_REVISION

echo 'Patching SDL source'
try patch -p1 < $RENIOSDEPROOT/patches/sdl2/sdl2-$SDL2_REVISION-compat.patch


pushd $TMPROOT/SDL/Xcode-iOS/SDL
try xcodebuild -project SDL.xcodeproj -target libSDL -configuration Debug -sdk iphoneos$SDKVER clean
try xcodebuild -project SDL.xcodeproj -target libSDL -configuration Debug -sdk iphoneos$SDKVER
popd

popd

# Yes, copy it over to a different name.
cp $TMPROOT/SDL/Xcode-iOS/SDL/build/Debug-iphoneos/libSDL2.a $BUILDROOT/lib/libSDL.a
rm -rdf $BUILDROOT/include/SDL
cp -a $TMPROOT/SDL/Xcode-iOS/SDL/build/Debug-iphoneos/usr/local/include $BUILDROOT/include/SDL

try mkdir -p $BUILDROOT/bin
try sed s:BUILDROOT:$BUILDROOT: <$RENIOSDEPROOT/src/sdl2/sdl-config >$BUILDROOT/bin/sdl-config
try chmod a+x $BUILDROOT/bin/sdl-config

mkdir -p $BUILDROOT/pkgconfig
cat>$BUILDROOT/pkgconfig/sdl2.pc<<EOF
# sdl pkg-config source file

prefix=$BUILDROOT
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: sdl2
Description: Simple DirectMedia Layer is a cross-platform multimedia library designed to provide low level access to audio, keyboard, mouse, joystick, 3D hardware via OpenGL, and 2D video framebuffer.
Version: 2.0.0
Requires:
Conflicts:
Libs: -L\${libdir}  -lSDLmain -lSDL   -Wl,-framework,Cocoa
Libs.private: \${libdir}/libSDL.a  -Wl,-framework,OpenGL  -Wl,-framework,Cocoa -Wl,-framework,ApplicationServices -Wl,-framework,Carbon -Wl,-framework,AudioToolbox -Wl,-framework,AudioUnit -Wl,-framework,IOKit
Cflags: -I\${includedir}/SDL -D_GNU_SOURCE=1 -D_THREAD_SAFE
EOF
