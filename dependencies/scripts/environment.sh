#!/bin/bash

# From https://github.com/kivy/kivy-ios

# Set up build locations
export RENIOSDEPROOT="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"
export TMPROOT="$RENIOSDEPROOT/tmp"
export CACHEROOT="$RENIOSDEPROOT/cache"

# create build directories if not found
try mkdir -p $CACHEROOT
try mkdir -p $TMPROOT

# Versions

export PYTHON_VERSION=2.7.3
export RENPY_VERSION=6.14.1
export PYGAME_VERSION=1.9.1
export FREETYPE_VERSION=2.3.12
export FRIBIDI_VERSION=0.19.2
export SDL_REVISION=45187a87d35b
export SDL2_TTF_REVISION=15fdede47c58
export SDL2_IMAGE_REVISION=4a8d59cbf927
export LIBAV_VERSION=0.7.6
