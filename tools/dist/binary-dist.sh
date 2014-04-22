#!/bin/bash

try () {
  "$@" || exit -1
}

VERSION=$1

if [ "X$VERSION" == "X" ]; then
  echo $(basename $0) "<version>"
  exit 1
fi

# TODO Don't assume we're running from the renios root directory

# Regenerate docs
try pushd sphinx
try make html
try popd

try rm -rf dist/renios-$VERSION

try mkdir -p dist/renios-$VERSION
try mkdir -p dist/renios-$VERSION/dependencies/build

try cp -a sphinx/_build/html dist/renios-$VERSION/doc
try cp -a dependencies/build/debug dist/renios-$VERSION/dependencies/build/debug
try cp -a dependencies/build/release dist/renios-$VERSION/dependencies/build/release
try cp -a template dist/renios-$VERSION/template
try cp -a tools dist/renios-$VERSION/tools
try cp -a README.md dist/renios-$VERSION/README.md
try cp -a LICENSE.md dist/renios-$VERSION/LICENSE.md
try cp -a CHANGELOG.md dist/renios-$VERSION/CHANGELOG.md

try pushd dist
try tar -cvjf renios-$VERSION.tbz renios-$VERSION
try popd
