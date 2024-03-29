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
    apiKey: 'AIzaSyDqIYZmJl3K88Qt6tqaUw_s2IOXvB3JIeI',
    appId: '1:452212228606:web:ca00f0b7f258ee065940af',
    messagingSenderId: '452212228606',
    projectId: 'thraa-najd-app',
    authDomain: 'thraa-najd-app.firebaseapp.com',
    storageBucket: 'thraa-najd-app.appspot.com',
    measurementId: 'G-4YKCDZ12D9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1DZis6PlnOF8PWvYl-4C7SP_4DOgvKHg',
    appId: '1:452212228606:android:c4aa18a6807c24935940af',
    messagingSenderId: '452212228606',
    projectId: 'thraa-najd-app',
    storageBucket: 'thraa-najd-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJEhPgT0AgDm-ubESWknJheyvKmyAnkU8',
    appId: '1:452212228606:ios:044d566be0d171f85940af',
    messagingSenderId: '452212228606',
    projectId: 'thraa-najd-app',
    storageBucket: 'thraa-najd-app.appspot.com',
    iosBundleId: 'com.example.thraaNajdApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJEhPgT0AgDm-ubESWknJheyvKmyAnkU8',
    appId: '1:452212228606:ios:dcbd004daf01d3975940af',
    messagingSenderId: '452212228606',
    projectId: 'thraa-najd-app',
    storageBucket: 'thraa-najd-app.appspot.com',
    iosBundleId: 'com.example.thraaNajdApp.RunnerTests',
  );
}
