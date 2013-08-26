#!/bin/bash

try () {
  "$@" || exit -1
}

APPNAME=$1
SRCDIR=$2
# Keep only alphanumeric characters, and turn spaces into hyphens.
APPID=$(echo $APPNAME | tr -cd '[:alnum:] ' | tr ' ' '-')
TEMPLATEDIR=$(dirname 0)/template
APPDIR=$(dirname 0)/app-$APPID
DEPBUILDROOT=$(dirname 0)/dependencies/build

if [ "X$APPNAME" == "X" ]; then
  echo $(basename $0) "<appname> <source directory>"
  exit 1
fi

if [ "X$SRCDIR" == "X" ]; then
  echo $(basename $0) "<appname> <source directory>"
  exit 1
fi

echo "Creating $APPDIR directory"
try mkdir $APPDIR

echo "Copying templates"
try cp -a $TEMPLATEDIR/* $APPDIR/

echo "Customising template filenames"
try mv $APPDIR/template/template-Info.plist $APPDIR/template/$APPID-Info.plist
try mv $APPDIR/template $APPDIR/$APPID
try mv $APPDIR/template.xcodeproj $APPDIR/$APPID.xcodeproj

echo "Customising template code"
try find $APPDIR -type f -exec sed -i '' "s/##APPID##/$APPID/g" {} \;
try find $APPDIR -type f -exec sed -i '' "s/##APPNAME##/$APPNAME/g" {} \;

echo "Copying in support files"
# Python files from 'release' build are identical to those from 'debug' build.
try cp -a $DEPBUILDROOT/release/renpy/common $APPDIR/$APPID/scripts/
try cp -a $DEPBUILDROOT/release/renpy/renpy $APPDIR/$APPID/scripts/

echo "Copying in your game files"
try cp -a "$SRCDIR" $APPDIR/$APPID/scripts/game
