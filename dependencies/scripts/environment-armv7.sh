# Find iOS SDK paths

export SDKVER=`xcodebuild -showsdks | fgrep "iphoneos" | tail -n 1 | awk '{print $2}'`
export DEVROOT=`xcode-select -print-path`/Platforms/iPhoneOS.platform/Developer
export IOSSDKROOT=$DEVROOT/SDKs/iPhoneOS$SDKVER.sdk
export SDKBASENAME=iphoneos
export RENIOSARCH=armv7
export RENIOSCPU=cortex-a8

# TODO Figure out if we need to specify multiple cpus for armv7 (i.e. also include arm1176jzf-s)

if [ ! -d $DEVROOT ]; then
  echo "Unable to found the Xcode iPhoneOS.platform"
  echo
  echo "The path is automatically set from 'xcode-select -print-path'"
  echo " + /Platforms/iPhoneOS.platform/Developer"
  echo
  echo "Ensure 'xcode-select -print-path' is set."
  exit 1
fi

# Flags for ARM cross-compilation
export ARM_CC="$DEVROOT/usr/bin/arm-apple-darwin10-llvm-gcc-4.2"
export ARM_REAL_CC=$ARM_CC
export ARM_AR="$DEVROOT/usr/bin/ar"
export ARM_LD="$DEVROOT/usr/bin/ld"
export ARM_CFLAGS="-march=$RENIOSARCH -mcpu=$RENIOSCPU"
export ARM_CFLAGS="$ARM_CFLAGS -pipe -no-cpp-precomp"
export ARM_CFLAGS="$ARM_CFLAGS -isysroot $IOSSDKROOT"
export ARM_CFLAGS="$ARM_CFLAGS -miphoneos-version-min=$SDKVER"
export ARM_LDFLAGS="-isysroot $IOSSDKROOT"
export ARM_LDFLAGS="$ARM_LDFLAGS -miphoneos-version-min=$SDKVER"
export ARM_HOST="armv7-apple-darwin"

export LIBAV_CONFIGURE_ARCH_CPU="--arch=$RENIOSARCH --cpu=$RENIOSCPU"