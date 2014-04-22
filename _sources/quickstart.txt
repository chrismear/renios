===============
Getting Started
===============

This page will help you get Ren'iOS installed, and show you how to build and run your first project.

Requirements
------------

1. A game written in :term:`Ren'Py` that you'd like to run on an iOS device!
2. A Mac running Mac OS X 10.8.4 (Mountain Lion) or later.
3. :term:`Xcode` 5.1.1 or later. This is `a free download from the Mac App Store <https://itunes.apple.com/gb/app/xcode/id497799835?mt=12>`_.

Installation
------------

1. Download the latest version of Ren'iOS from the `Ren'iOS releases page <https://github.com/chrismear/renios/releases>`_. (Look for the green button that says something like renios-|version|.tbz.)
2. Extract the download by double-clicking on it. This will create a folder named something like renios-|version|. It is possible your browser has automatically extracted the download for you, in which case the folder will already be there.

Packaging Instructions
----------------------

1. Open the *Terminal* app. This is found in Applications > Utilities > Terminal.
2. Change to the renios-|version| directory using `cd`. If you downloaded Ren'iOS following the instructions above, you can do this by typing the following command
   ::

      cd Downloads/renios*

   and pressing Return.

3. Find the `game` folder for your game. One easy way to do this is to run Ren'Py, select your game from the list on the left, and then choose 'game' from the 'Open Directory' list.

4. Back in the Terminal window, type the following::

   ./tools/create-xcode-project.sh "My Game"

   where ``My Game`` is the name of your game. Press space, but don't press Return yet!

5. Drag your `game` folder into the Terminal window. This will make Terminal type in the full path to your `game` directory automatically. You should end up with something like this::

   ./tools/create-xcode-project.sh "My Game" /Users/yourname/Documents/RenPyProjects/My\ Game/Game 

   Now you can press Return.

6. Ren'iOS will do its work, printing several lines of text. If all goes well, the last line you should see is "Copying in your game files".

Running your app
----------------

1. You now have an Xcode project. Find it by going to the renios-|version| folder, and looking in the folder called something like `app-my-game`. Double-click the blue Xcode document to open it in Xcode.

2. Near the top-left of the Xcode window, there is a drop-down menu where you can choose between 'iOS Device', 'iPad Simulator', and 'iPhone Simulator'. Choose one of the simulator options.

3. Press the 'Run' button in the top-left. Xcode will do some work, and after a short while you should see a new window open. This is the iOS simulator, and it will automatically launch your game.

Next steps
----------

Running on the simulator is one thing, but you are probably keen to see your game running on an actual iOS device. To find out more about how to set this up, read :doc:`/device`.

For further detailed instructions on how to use Ren'iOS, see :doc:`/tasks`.
