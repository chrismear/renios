export RENIOSBUILDCONFIGURATION=Release

# Set up build locations
export BUILDROOT="$RENIOSDEPROOT/build/$SDKBASENAME-$RENIOSARCH/release"
export DESTROOT="$RENIOSDEPROOT/tmp/root/$SDKBASENAME-$RENIOSARCH/release"

# Release or debug?
export ARM_CFLAGS="$ARM_CFLAGS -O3"

# create build directories if not found
try mkdir -p $BUILDROOT
try mkdir -p $BUILDROOT/include
try mkdir -p $BUILDROOT/lib
try mkdir -p $DESTROOT
