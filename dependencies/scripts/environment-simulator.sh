# Find iOS SDK paths

export XCODEPATH=`xcode-select -print-path`
export SDKVER=`xcodebuild -showsdks | fgrep "iphonesimulator" | tail -n 1 | awk '{print $4}'`
export DEVROOT=$XCODEPATH/Platforms/iPhoneSimulator.platform/Developer
export IOSSDKROOT=$DEVROOT/SDKs/iPhoneSimulator$SDKVER.sdk
export TOOLCHAINROOT=$XCODEPATH/Toolchains/XcodeDefault.xctoolchain
export SDKBASENAME=iphonesimulator
export RENIOSARCH=i386
export RENIOSCPU=i386

if [ ! -d $DEVROOT ]; then
  echo "Unable to found the Xcode iPhoneSimulator.platform"
  echo
  echo "The path is automatically set from 'xcode-select -print-path'"
  echo " + /Platforms/iPhoneSimulator.platform/Developer"
  echo
  echo "Ensure 'xcode-select -print-path' is set."
  exit 1
fi

# Flags for ARM cross-compilation
export ARM_CC="$DEVROOT/usr/bin/i686-apple-darwin11-llvm-gcc-4.2"
export ARM_REAL_CC=$ARM_CC
export ARM_AR="$DEVROOT/usr/bin/ar"
export ARM_LD="$DEVROOT/usr/bin/ld"
export ARM_CFLAGS="-march=i386"
export ARM_CFLAGS="$ARM_CFLAGS -pipe -no-cpp-precomp"
export ARM_CFLAGS="$ARM_CFLAGS -isysroot $IOSSDKROOT"
export ARM_CFLAGS="$ARM_CFLAGS -miphoneos-version-min=$SDKVER"
export ARM_LDFLAGS="-isysroot $IOSSDKROOT"
# export ARM_LDFLAGS="$ARM_LDFLAGS -mios-simulator-version-min=$SDKVER"
export ARM_HOST="i686-apple-darwin"

export LIBAV_CONFIGURE_ARCH_CPU="--arch=$RENIOSARCH --cpu=$RENIOSCPU"
