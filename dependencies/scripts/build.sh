#!/bin/bash

. $(dirname $0)/utils.sh

RENIOSCOMPONENT=$1

if [ "X$RENIOSCOMPONENT" == "X" ]; then
  echo $(basename $0) "<component>"
  exit 1
fi

. $(dirname $0)/environment.sh

. $(dirname $0)/environment-debug.sh

try $(dirname $0)/build-$RENIOSCOMPONENT.sh

echo 'Debug build done.'

. $(dirname $0)/environment-release.sh

try $(dirname $0)/build-$RENIOSCOMPONENT.sh

echo 'Release build done.'
