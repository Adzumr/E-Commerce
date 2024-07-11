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
    apiKey: 'AIzaSyA_z6UOobtVgEeBQUk5TC5a9XljX4CiJ8c',
    appId: '1:1054186683527:web:99e6e82575c76a3c0dcc22',
    messagingSenderId: '1054186683527',
    projectId: 'e-store-78528',
    authDomain: 'e-store-78528.firebaseapp.com',
    storageBucket: 'e-store-78528.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGlMpWIBy33_cCnQCU8pL31icr3bbAqg8',
    appId: '1:1054186683527:android:59da52fae61b5dce0dcc22',
    messagingSenderId: '1054186683527',
    projectId: 'e-store-78528',
    storageBucket: 'e-store-78528.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBwl91JW60mKwNZeYOVRlyllR1nQ-XXpw',
    appId: '1:1054186683527:ios:cb54f0c83de77bbb0dcc22',
    messagingSenderId: '1054186683527',
    projectId: 'e-store-78528',
    storageBucket: 'e-store-78528.appspot.com',
    iosBundleId: 'com.ecommerce.adzumr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBwl91JW60mKwNZeYOVRlyllR1nQ-XXpw',
    appId: '1:1054186683527:ios:6299bf419654aabc0dcc22',
    messagingSenderId: '1054186683527',
    projectId: 'e-store-78528',
    storageBucket: 'e-store-78528.appspot.com',
    iosBundleId: 'com.example.commerceApp.RunnerTests',
  );
}