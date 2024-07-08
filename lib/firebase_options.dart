// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCFlqrgqJYLe_1bG0QMgAohh1uPkz18nf4',
    appId: '1:981857157729:web:86dbdeac40a3eb2878a020',
    messagingSenderId: '981857157729',
    projectId: 'quiz-app-dff15',
    authDomain: 'quiz-app-dff15.firebaseapp.com',
    storageBucket: 'quiz-app-dff15.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByEGOUAm28uVublyNPp7Q2ssDBoNvBmTY',
    appId: '1:981857157729:android:faaac3c6e81c04dc78a020',
    messagingSenderId: '981857157729',
    projectId: 'quiz-app-dff15',
    storageBucket: 'quiz-app-dff15.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-AL9pRE64b-3rNhR8u-Tj5zqignIHJg0',
    appId: '1:981857157729:ios:33447799199c2a2478a020',
    messagingSenderId: '981857157729',
    projectId: 'quiz-app-dff15',
    storageBucket: 'quiz-app-dff15.appspot.com',
    iosClientId: '981857157729-lj4ackm788k891l6tvo02pkc9ik51caf.apps.googleusercontent.com',
    iosBundleId: 'com.example.quizApp',
  );

}