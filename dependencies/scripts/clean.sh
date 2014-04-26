#!/bin/bash

. $(dirname $0)/utils.sh
. $(dirname $0)/environment.sh

try rm -rf $TMPROOT
try rm -rf $RENIOSDEPROOT/build
