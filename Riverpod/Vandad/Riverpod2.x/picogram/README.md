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

## Helps
- [Failed to list Firebase projects](https://stackoverflow.com/questions/57941289/how-do-i-solve-error-failed-to-list-firebase-projects-see-firebase-debug-log)
- [Change Android minSdkVersion](https://stackoverflow.com/questions/52060516/flutter-how-to-change-android-minsdkversion-in-flutter-project)
