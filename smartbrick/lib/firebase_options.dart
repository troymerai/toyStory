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
    apiKey: 'AIzaSyB2TXhAkFKYd_FpiBiTRm5gk7RxKOYiBD4',
    appId: '1:98189055342:web:20d32b054041e430ca5d7f',
    messagingSenderId: '98189055342',
    projectId: 'm1-smartbrick',
    authDomain: 'm1-smartbrick.firebaseapp.com',
    storageBucket: 'm1-smartbrick.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASgLRLMtYTc9264t_biWucbZNyqH1bDGY',
    appId: '1:98189055342:android:681bfdf46914d4fcca5d7f',
    messagingSenderId: '98189055342',
    projectId: 'm1-smartbrick',
    storageBucket: 'm1-smartbrick.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJIszwkwAvYfSRp64iybkf5QRZ2Pp1xJo',
    appId: '1:98189055342:ios:74080344eea9ba77ca5d7f',
    messagingSenderId: '98189055342',
    projectId: 'm1-smartbrick',
    storageBucket: 'm1-smartbrick.appspot.com',
    iosClientId: '98189055342-v5mlibb0rbnhg06hp5t98cepjjv78ndt.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartbrick',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDJIszwkwAvYfSRp64iybkf5QRZ2Pp1xJo',
    appId: '1:98189055342:ios:74080344eea9ba77ca5d7f',
    messagingSenderId: '98189055342',
    projectId: 'm1-smartbrick',
    storageBucket: 'm1-smartbrick.appspot.com',
    iosClientId: '98189055342-v5mlibb0rbnhg06hp5t98cepjjv78ndt.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartbrick',
  );
}
