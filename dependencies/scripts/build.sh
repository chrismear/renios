#!/bin/bash

. $(dirname $0)/environment.sh

try $(dirname $0)/build-python.sh
try $(dirname $0)/build-sdl.sh
try $(dirname $0)/build-libpng.sh
try $(dirname $0)/build-pygame.sh
try $(dirname $0)/build-renpy.sh

echo 'Build done'
