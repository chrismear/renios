.. Ren'iOS documentation master file, created by
   sphinx-quickstart on Sun Jan 13 13:44:33 2013.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

===============================
Ren'iOS |version| Documentation
===============================

Ren'iOS helps you package a `Ren'Py <http://www.renpy.org>`_ game into an app that will run on iOS. It builds versions of Ren'Py and its dependencies that will run on iOS, and provides scripts to help you assemble these with your game into an Xcode project that will build for iOS.

You can download a pre-built binary distribution from here:

https://github.com/chrismear/renios/wiki/Downloads

**NOTE:** This is still very early, proof-of-concept code. There are known bugs and missing UI. It is not ready to use for a public release of a game.

Packaging Requirements
----------------------

To package your Ren'Py game and build it for iOS, you will need the binary distribution of Ren'iOS, and Xcode 4.5 or higher.

Packaging Instructions
----------------------

In the renios directory, run::

    ./tools/create-xcode-project MyGame /path/to/your/game/directory

where ``MyGame`` is the name of the app you want to create, and the path points to the ``game`` directory of your Ren'Py game.

This will produce an Xcode project in ``app-mygame``. This should be ready to build and run on a device.

Build Requirements
------------------

If you want to use Ren'iOS to build Ren'Py and its dependencies from source, you will need the following software:

* Xcode
* Mercurial
* Cython

Build the software by changing into the `dependencies` directory, and running `./scripts/build.sh`. This will download and build Ren'Py and its dependencies.

License
-------

Some portions of Ren'iOS are based on works licensed under the LGPL (various versions). Therefore these portions are also licensed under the LGPL.

Because of these portions which must be licensed under an LGPL, the single license that applies to Ren'iOS taken as a whole is the LGPL Version 3.

In addition to that license, those portions of Ren'iOS that are not required to be licensed under the LGPL are also individually licensed under the `MIT (Expat) license <http://directory.fsf.org/wiki/License:Expat>`_.

Each file/directory in Ren'iOS contains a permissions notice that indicates which license(s) apply to that file/directory.

An application binary that you build using Ren'iOS should not itself need to be licensed under the LGPL.

Copyright 2012, 2013 Chris Mear <chris@feedmechocolate.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
