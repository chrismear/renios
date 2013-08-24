# Set up build locations
export BUILDROOT="$RENIOSDEPROOT/build/release"
export DESTROOT="$RENIOSDEPROOT/tmp/root/release"

# Release or debug?
export ARM_CFLAGS="$ARM_CFLAGS -O3"

# create build directories if not found
try mkdir -p $BUILDROOT
try mkdir -p $BUILDROOT/include
try mkdir -p $BUILDROOT/lib
try mkdir -p $DESTROOT
