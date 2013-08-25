=========
Packaging
=========

Debug vs Release
----------------

Ren'iOS ships with 'debug' and 'release' versions of Ren'Py and its support libraries. Xcode will mostly take care of this for you automatically, using 'debug' versions when you're running your game on your own test device, and using 'release' versions when you archive the project ready for sending to other people or submitting to the App Store.

If you want to build and run the 'release' version on your test device, you need to manually tell Xcode to do this:

1. From the menu bar, choose Product > Scheme > Edit Scheme....
2. From the left-hand pane, choose 'Run'.
3. In the right-hand pane, select the 'Info' tab.
4. From 'Build Configuration', select 'Release'.
5. Press 'OK'.

Now when you choose Product > Run, or use the 'Run' button in the toolbar, the 'release' versions will be used.
