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
    apiKey: 'AIzaSyD6qZOnVFvX6w43wfuMO4Hc8qXK_bMv2-I',
    appId: '1:1013002772599:web:2aa67317bd3f5e9faee672',
    messagingSenderId: '1013002772599',
    projectId: 'app-challenge-df9ab',
    authDomain: 'app-challenge-df9ab.firebaseapp.com',
    storageBucket: 'app-challenge-df9ab.appspot.com',
    measurementId: 'G-NQXNWN1WH8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCopHofPwJoWzJtD4iM5rLRciD5uxf-B7g',
    appId: '1:1013002772599:android:685a0ad0e7ca4fbbaee672',
    messagingSenderId: '1013002772599',
    projectId: 'app-challenge-df9ab',
    storageBucket: 'app-challenge-df9ab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXHpjo55B110_kSbxkoCsFh4igvQ3T03E',
    appId: '1:1013002772599:ios:e661a2f7294bd791aee672',
    messagingSenderId: '1013002772599',
    projectId: 'app-challenge-df9ab',
    storageBucket: 'app-challenge-df9ab.appspot.com',
    iosClientId: '1013002772599-di3u41k06j0mo6t2t3bilrnj38qqttp6.apps.googleusercontent.com',
    iosBundleId: 'com.example.project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXHpjo55B110_kSbxkoCsFh4igvQ3T03E',
    appId: '1:1013002772599:ios:62331c8520250240aee672',
    messagingSenderId: '1013002772599',
    projectId: 'app-challenge-df9ab',
    storageBucket: 'app-challenge-df9ab.appspot.com',
    iosClientId: '1013002772599-9fgbf62n8sugq4hges7h4h2rb5c94vk1.apps.googleusercontent.com',
    iosBundleId: 'com.example.project.RunnerTests',
  );
}
