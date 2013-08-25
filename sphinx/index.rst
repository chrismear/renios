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

Source code and issue tracking is here:

https://github.com/chrismear/renios

**NOTE:** This is still very early, proof-of-concept code. There are known bugs and missing UI. It is not ready to use for a public release of a game.

Contents:

.. toctree::
   :maxdepth: 2

   packaging
   development
   license

Packaging Requirements
----------------------

To package your Ren'Py game and build it for iOS, you will need the binary distribution of Ren'iOS, and `Xcode 4.5 <https://itunes.apple.com/gb/app/xcode/id497799835?mt=12>`_ or higher.

Packaging Instructions
----------------------

In the renios directory, run::

    ./tools/create-xcode-project MyGame /path/to/your/game/directory

where ``MyGame`` is the name of the app you want to create, and the path points to the ``game`` directory of your Ren'Py game.

This will produce an Xcode project in ``app-mygame``. This should be ready to build and run on a device.
