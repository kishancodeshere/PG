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
    apiKey: 'AIzaSyBO-fLZIs7MzjRT4Rr2Qt0A20cAqWuaMS4',
    appId: '1:748825828140:web:d9c37a1bcc1644c65baa89',
    messagingSenderId: '748825828140',
    projectId: 'pg-guide-92695',
    authDomain: 'pg-guide-92695.firebaseapp.com',
    storageBucket: 'pg-guide-92695.appspot.com',
    measurementId: 'G-DFF1RM0C4F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEMyRZzGS2wGFFwlp6_q6By19Cs1nfohw',
    appId: '1:748825828140:android:9ad1a43c9f1798eb5baa89',
    messagingSenderId: '748825828140',
    projectId: 'pg-guide-92695',
    storageBucket: 'pg-guide-92695.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtGxl6EvOPXq7idMhhilQDIiQTW-KXEoI',
    appId: '1:748825828140:ios:6b597d80d19e07915baa89',
    messagingSenderId: '748825828140',
    projectId: 'pg-guide-92695',
    storageBucket: 'pg-guide-92695.appspot.com',
    iosBundleId: 'com.example.pg',
  );
}
