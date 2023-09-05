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
    apiKey: 'AIzaSyDy5jHBN5j_QqT3ZCSRl8ACxToFETUEq3U',
    appId: '1:1082793523777:web:2f943d88e268bcfbe124c0',
    messagingSenderId: '1082793523777',
    projectId: 'usingfirebase-ccaa7',
    authDomain: 'usingfirebase-ccaa7.firebaseapp.com',
    storageBucket: 'usingfirebase-ccaa7.appspot.com',
    measurementId: 'G-1TF3RV2S6T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMeQmfBs6EQOPGbE1BeLjAg4mg-yYl7BY',
    appId: '1:1082793523777:android:38d0bc1faf562957e124c0',
    messagingSenderId: '1082793523777',
    projectId: 'usingfirebase-ccaa7',
    storageBucket: 'usingfirebase-ccaa7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCr-F7ZgtgxRmrKZMEbomaq-uo8BH9PRVU',
    appId: '1:1082793523777:ios:956b650ea3999989e124c0',
    messagingSenderId: '1082793523777',
    projectId: 'usingfirebase-ccaa7',
    storageBucket: 'usingfirebase-ccaa7.appspot.com',
    androidClientId: '1082793523777-lk117bbp368avv15k48a0su0mv9572aj.apps.googleusercontent.com',
    iosClientId: '1082793523777-5j028vl7j0elumr4pe4q1tphk8h9i7um.apps.googleusercontent.com',
    iosBundleId: 'com.example.machineSideApm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCr-F7ZgtgxRmrKZMEbomaq-uo8BH9PRVU',
    appId: '1:1082793523777:ios:9de09161b48c91a4e124c0',
    messagingSenderId: '1082793523777',
    projectId: 'usingfirebase-ccaa7',
    storageBucket: 'usingfirebase-ccaa7.appspot.com',
    androidClientId: '1082793523777-lk117bbp368avv15k48a0su0mv9572aj.apps.googleusercontent.com',
    iosClientId: '1082793523777-kckppu0mk5bq4j6ff3bo22p848p38964.apps.googleusercontent.com',
    iosBundleId: 'com.example.machineSideApm.RunnerTests',
  );
}