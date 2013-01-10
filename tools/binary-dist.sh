#!/bin/bash

try () {
  "$@" || exit -1
}

VERSION=$1

if [ "X$VERSION" == "X" ]; then
  echo $(basename $0) "<version>"
  exit 1
fi

try mkdir renios-$VERSION
try mkdir renios-$VERSION/dependencies

try cp -a dependencies/build renios-$VERSION/dependencies/build
try cp -a template renios-$VERSION/template
try cp -a tools renios-$VERSION/tools

try tar -cvjf renios-$VERSION.tbz renios-$VERSION

