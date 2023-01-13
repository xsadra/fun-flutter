# PicoGram

Sharing Image and Video

## Setup the project
- [Setup Firebase](https://firebase.google.com/docs/flutter/setup?platform=ios)
    - [Install the Firebase CLI](https://firebase.google.com/docs/cli#setup_update_cli)
- [Create a new facebook app](https://developers.facebook.com/apps/)
- Enable Facebook Authentication in firebase console
- Setup Facebook Login in facebook developers page
  - Setup IOS
    - Add your Bundle Identifier
    - Enable Single Sign On for Your App
    - Configure Your info.plist
    - [Do the missed steps from here](https://facebook.meedu.app/docs/5.x.x/ios)
  - Setup Android
    - Import the Facebook SDK
    - Tell Us about Your Android Project
    - Add Your Development and Release Key Hashes
    - Enable Single Sign On for Your App
    - Edit Your Resources and Manifest
    - [Do the missed steps from here: add <queries> ](https://facebook.meedu.app/docs/5.x.x/android)
- [Setup Google Sign In](https://pub.dev/packages/google_sign_in)

After that, you can run the project. During the Implementing `GoogleSignIn` step, you need to enable Google Sign In in firebase console.
In order to do that you need to download the latest configuration file for both  for Android and IOS. IF IT IS NOT ALREADY DONE.
- [Authenticate Using Google Sign-In on Android](https://firebase.google.com/docs/auth/android/google-signin?authuser=0&hl=en)
- [Authenticate Using Google Sign-In on Apple Platforms](https://firebase.google.com/docs/auth/ios/google-signin?authuser=0&hl=en)

Note: Don't forget to add the SHA-1 key for the debug and release mode.

## Helps
- [Failed to list Firebase projects](https://stackoverflow.com/questions/57941289/how-do-i-solve-error-failed-to-list-firebase-projects-see-firebase-debug-log)
- [Change Android minSdkVersion](https://stackoverflow.com/questions/52060516/flutter-how-to-change-android-minsdkversion-in-flutter-project)
