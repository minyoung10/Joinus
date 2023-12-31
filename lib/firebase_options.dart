// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDUi-7XScpqTHezuMOYSS1rX-MVFAf98TY',
    appId: '1:282524074619:web:b555cf4e69fac7d6e198de',
    messagingSenderId: '282524074619',
    projectId: 'fire-cd56d',
    authDomain: 'fire-cd56d.firebaseapp.com',
    storageBucket: 'fire-cd56d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgMOi7SaoMZ49or7CCMesO9ZnFY72CJmQ',
    appId: '1:282524074619:android:afc0618e523f2705e198de',
    messagingSenderId: '282524074619',
    projectId: 'fire-cd56d',
    storageBucket: 'fire-cd56d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAN50evNNBZ9EVJOjjyAmgiTbIk2YdvP14',
    appId: '1:282524074619:ios:536a00639abc0fe0e198de',
    messagingSenderId: '282524074619',
    projectId: 'fire-cd56d',
    storageBucket: 'fire-cd56d.appspot.com',
    iosClientId: '282524074619-h4i2rusi97n5ghsgiuepvhsqu8de0i1e.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAN50evNNBZ9EVJOjjyAmgiTbIk2YdvP14',
    appId: '1:282524074619:ios:1cc96de662ca3cf0e198de',
    messagingSenderId: '282524074619',
    projectId: 'fire-cd56d',
    storageBucket: 'fire-cd56d.appspot.com',
    iosClientId: '282524074619-h4vs2pmv6995ntvme5tfppdebsrk4ds6.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication4.RunnerTests',
  );
}
