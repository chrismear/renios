# Find iOS SDK paths

export XCODEPATH=`xcode-select -print-path`
export SDKVER=`xcodebuild -showsdks | fgrep "iphoneos" | tail -n 1 | awk '{print $2}'`
export DEVROOT=$XCODEPATH/Platforms/iPhoneOS.platform/Developer
export IOSSDKROOT=$DEVROOT/SDKs/iPhoneOS$SDKVER.sdk
export TOOLCHAINROOT=$XCODEPATH/Toolchains/XcodeDefault.xctoolchain
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
export ARM_CC=$(xcrun -find -sdk iphoneos clang)
export ARM_REAL_CC=$ARM_CC
export ARM_AR=$(xcrun -find -sdk iphoneos ar)
export ARM_LD=$(xcrun -find -sdk iphoneos ld)
export ARM_CFLAGS="-arch $RENIOSARCH"
export ARM_CFLAGS="$ARM_CFLAGS -pipe -no-cpp-precomp"
export ARM_CFLAGS="$ARM_CFLAGS -isysroot $IOSSDKROOT"
export ARM_CFLAGS="$ARM_CFLAGS -miphoneos-version-min=$SDKVER"
export ARM_LDFLAGS="-arch $RENIOSARCH -isysroot $IOSSDKROOT"
export ARM_LDFLAGS="$ARM_LDFLAGS -miphoneos-version-min=$SDKVER"
export ARM_HOST="armv7-apple-darwin"

export LIBAV_CONFIGURE_ARCH_CPU="--arch=$RENIOSARCH --cpu=$RENIOSCPU"
