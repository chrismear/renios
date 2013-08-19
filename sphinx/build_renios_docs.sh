#!/bin/bash

try () {
  "$@" || exit -1
}

try make html
try cp -a _build/html/* ../../renios-gh-pages/
echo "Now go to ../../renios-gh-pages and git commit and push."
