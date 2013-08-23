#!/bin/bash

. $(dirname $0)/environment.sh

try $(dirname $0)/build-python.sh
try $(dirname $0)/build-sdl.sh
try $(dirname $0)/build-libpng.sh
try $(dirname $0)/build-libjpeg-turbo.sh
try $(dirname $0)/build-fribidi.sh
try $(dirname $0)/build-freetype.sh
try $(dirname $0)/build-sdl2_ttf.sh
try $(dirname $0)/build-sdl2_image.sh
try $(dirname $0)/build-libav.sh
try $(dirname $0)/build-pygame.sh
try $(dirname $0)/build-renpy.sh

echo 'Build done'
