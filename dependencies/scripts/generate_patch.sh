#!/bin/bash

try () {
  "$@" || exit -1
}

LIBRARY=$1
VERSION=$2

if [ "X$LIBRARY" == "X" ]; then
  echo $(basename $0) "<library> <version>"
  exit 1
fi

if [ "X$VERSION" == "X" ]; then
  echo $(basename $0) "<library> <version>"
  exit 1
fi

try pushd $(dirname $0)/../../../renios-$LIBRARY
try git diff $LIBRARY-$VERSION renios-$LIBRARY-$VERSION > ../renios/dependencies/patches/$LIBRARY/$LIBRARY-$VERSION-renios.patch
try popd
