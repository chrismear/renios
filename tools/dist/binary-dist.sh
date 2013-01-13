#!/bin/bash

try () {
  "$@" || exit -1
}

VERSION=$1

if [ "X$VERSION" == "X" ]; then
  echo $(basename $0) "<version>"
  exit 1
fi

try rm -rf dist/renios-$VERSION
try mkdir -p dist/renios-$VERSION
try mkdir -p dist/renios-$VERSION/dependencies

try cp -a dependencies/build dist/renios-$VERSION/dependencies/build
try cp -a template dist/renios-$VERSION/template
try cp -a tools dist/renios-$VERSION/tools

try pushd dist
try tar -cvjf renios-$VERSION.tbz renios-$VERSION
try popd
