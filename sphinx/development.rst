======================
Development of Ren'iOS
======================

Build Requirements
------------------

If you want to use Ren'iOS to build Ren'Py and its dependencies from source, you will need the following software:

* `Xcode <https://itunes.apple.com/gb/app/xcode/id497799835?mt=12>`_ with command line developer tools installed
* `Cython <http://cython.org>`_
* `Mercurial <http://mercurial.selenic.com>`_ with the 'purge' extension enabled
* `nasm  <http://www.nasm.us>`_
* `autoconf <http://www.gnu.org/software/autoconf/>`_
* `automake <http://www.gnu.org/software/automake/>`_
* `libtool <http://www.gnu.org/software/libtool/libtool.html>`_

To install Xcode's command line developer tools, first install the Xcode application, then run:

   ::

      xcode-select --install

Cython can be installed by running:

   ::

      sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments easy_install cython


All the other software can be installed from their standard installers/source downloads. But an
easier solution, if you have `Homebrew <http://brew.sh>`_ installed, is to run:

   ::

      brew install mercurial nasm autoconf automake libtool

Finally, to enable Mercurial's 'purge' extension, add this to `~/.hgrc`:

   ::

      [extensions]
      purge =

Building
--------

Build the software by changing into the `dependencies` directory, and running `./scripts/build.sh all`. This will download and build Ren'Py and its dependencies.
