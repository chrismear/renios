Ren'iOS
=======

Ren'iOS helps you package a [Ren'Py](http://www.renpy.org) game into an app that will run on iOS. It builds versions of Ren'Py and its dependencies that will run on iOS, and provides scripts to help you assemble these with your game into an Xcode project that will build for iOS.

You can download a pre-build binary distribution from here:

https://github.com/chrismear/renios/wiki/Downloads

**NOTE:** This is still very early, proof-of-concept code. There are known bugs and missing UI. It is not ready to use for a public release of a game.

Packaging Requirements
----------------------

To package your Ren'Py game and build it for iOS, you will need the binary distribution of Ren'iOS, and Xcode 4.5 or higher.

Packaging Instructions
----------------------

In the renios directory, run:

    ./tools/create-xcode-project MyGame /path/to/your/game/directory

where `MyGame` is the name of the app you want to create, and the path points to the `game` directory of your Ren'Py game.

This will produce an Xcode project in `app-mygame`. This should be ready to build and run on a device.

Build Requirements
------------------

If you want to use Ren'iOS to build Ren'Py and its dependencies from source, you will need the following software:

* Xcode
* Mercurial
* Cython

Build the software by changing into the `dependencies` directory, and running `./scripts/build.sh`. This will download and build Ren'Py and its dependencies.

License
-------

Some portions of Ren'iOS are based on works licensed under the LGPL (various versions). These portions are also licensed under the corresponding LGPL license, and are noted as such in the relevant files or in a 'LICENSE' file.

The rest of Ren'iOS is licensed under the [Modified BSD License](http://directory.fsf.org/wiki/License:BSD_3Clause).

Copyright 2012, 2013 Chris Mear <chris@feedmechocolate.com>
