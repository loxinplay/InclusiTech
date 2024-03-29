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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCsBqJ438tTsxcMMuGzc3W2yDIJ2Vbq5eg',
    appId: '1:902762669828:web:2e01b0e198be5c9dee1251',
    messagingSenderId: '902762669828',
    projectId: 'messengercohort',
    authDomain: 'messengercohort.firebaseapp.com',
    storageBucket: 'messengercohort.appspot.com',
    measurementId: 'G-C3E92JM6PP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgvmhuxKROusCHF8KY6o5PrwVJgmTFzd4',
    appId: '1:902762669828:android:21acf0d4393fa11eee1251',
    messagingSenderId: '902762669828',
    projectId: 'messengercohort',
    storageBucket: 'messengercohort.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqAqtIS9-3mJVaNgfZMI71bhpxQwZ5ZN8',
    appId: '1:902762669828:ios:beefc8aa5019b25aee1251',
    messagingSenderId: '902762669828',
    projectId: 'messengercohort',
    storageBucket: 'messengercohort.appspot.com',
    iosBundleId: 'com.example.cohortMessenger',
  );
}
