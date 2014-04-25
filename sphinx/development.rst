======================
Development of Ren'iOS
======================

Build Requirements
------------------

If you want to use Ren'iOS to build Ren'Py and its dependencies from source, you will need the following software:

* `Xcode <https://itunes.apple.com/gb/app/xcode/id497799835?mt=12>`_
* `Cython <http://cython.org>`_
* `Mercurial <http://mercurial.selenic.com>`_ with the 'purge' extension enabled
* `nasm  <http://www.nasm.us>`_
* `autoconf <http://www.gnu.org/software/autoconf/>`_
* `automake <http://www.gnu.org/software/automake/>`_

If you have `Homebrew <http://brew.sh>`_ installed, you can get everything except Xcode and Cython by running:

   ::

      brew install mercurial nasm autoconf automake

Cython can be installed by running:

   ::

      sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments easy_install cython


Build the software by changing into the `dependencies` directory, and running `./scripts/build.sh all`. This will download and build Ren'Py and its dependencies.
