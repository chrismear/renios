#!/bin/bash

. $(dirname $0)/environment.sh

try $(dirname $0)/build-python.sh

echo 'Build done'
