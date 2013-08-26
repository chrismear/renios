# 0.3 / Unreleased

* [FEATURE] Tapping on a Ren'Py text input shows the iOS soft keyboard for interaction.
* [FEATURE] A two-finger tap is registered as a right-click (for bringing up the Ren'Py menu).
* [FEATURE] Ren'Py's 'screen variant' is set with 'touch' and 'tablet/phone' as appropriate.
* [FEATURE] Generated apps can now run in the iOS simulator as well as on a device.
* [FEATURE] Experimental support for rendering text in Retina resolution.
* [ENHANCEMENT] Documentation added.
* [ENHANCEMENT] Xcode project now includes template icons and launch images.
* [ENHANCEMENT] Use framebuffer render-to-texture, meaning that graphical glitches caused by having to use 'fast dissolve' are no longer present.
* [PERFORMANCE] Speed of app's first start-up improved by removing unnecessary file copying.
* [ENHANCEMENT] Mouse cursor is hidden by default.
* [ENHANCEMENT] Mouse position is reset to corner when no touches are happening.
* [ENHANCEMENT] Build scripts updated for Xcode 4.6.
* [ENHANCEMENT] Ren'Py and dependencies are now built in 'release' configuration as well as 'debug' configuration.
* [ENHANCEMENT] App binary now includes armv7s (native for iPhone 5 and iPad 4th generation) as well as armv7 architecture.
* [BUGFIX] Other apps' audio is now silenced while our app is active.
* [BUGFIX] create_xcode_project.sh now handles special characters in the game source directory.
* [BUGFIX] create_xcode_project.sh now handles special characters and spaces in game names.
* Ren'iOS is now licensed under LGPL 2.1 instead of LGPL 3. 

# 0.2 / 2013-01-10

* [FEATURE] Patches for Ren'Py and its dependencies to run on iOS.
* [FEATURE] A system for building Ren'Py 6.14 and its dependencies for iOS.
* [FEATURE] A tool to package a Ren'Py game into an Xcode iOS app project.
