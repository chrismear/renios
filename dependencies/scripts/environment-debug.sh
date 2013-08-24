# Set up build locations
export BUILDROOT="$RENIOSDEPROOT/build/debug"
export DESTROOT="$RENIOSDEPROOT/tmp/root/debug"

# Release or debug?
export ARM_CFLAGS="$ARM_CFLAGS -O0 -g"

# create build directories if not found
try mkdir -p $BUILDROOT
try mkdir -p $BUILDROOT/include
try mkdir -p $BUILDROOT/lib
try mkdir -p $DESTROOT
