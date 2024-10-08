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
    apiKey: 'AIzaSyCHnO1tqFsIk6xBTQN8t1KSbQsp60FjNug',
    appId: '1:792601770447:web:6df5a9aea81f4178687aba',
    messagingSenderId: '792601770447',
    projectId: 'finma-dbc70',
    // authDomain: 'finma-dbc70.firebaseapp.com',
    authDomain: 'auth.tailfur-find.com',
    storageBucket: 'finma-dbc70.appspot.com',
    measurementId: 'G-CSNCRPPEWN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5bbQqqZNkWsLDrYGFnJv-3dnvOIf6Syk',
    appId: '1:792601770447:android:707866465beb4575687aba',
    messagingSenderId: '792601770447',
    projectId: 'finma-dbc70',
    storageBucket: 'finma-dbc70.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOaFfNYux6b4MBN7R_hU-9SY0-8kWjE10',
    appId: '1:792601770447:ios:6334fc3755b14a69687aba',
    messagingSenderId: '792601770447',
    projectId: 'finma-dbc70',
    storageBucket: 'finma-dbc70.appspot.com',
    androidClientId:
        '792601770447-e2oq67qse0vnjf5hk57pnpdec4nd1luv.apps.googleusercontent.com',
    iosClientId:
        '792601770447-dch7tietave0kbcfton1janfsrm4e3l2.apps.googleusercontent.com',
    iosBundleId: 'com.finma.userapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOaFfNYux6b4MBN7R_hU-9SY0-8kWjE10',
    appId: '1:792601770447:ios:6334fc3755b14a69687aba',
    messagingSenderId: '792601770447',
    projectId: 'finma-dbc70',
    storageBucket: 'finma-dbc70.appspot.com',
    androidClientId:
        '792601770447-e2oq67qse0vnjf5hk57pnpdec4nd1luv.apps.googleusercontent.com',
    iosClientId:
        '792601770447-dch7tietave0kbcfton1janfsrm4e3l2.apps.googleusercontent.com',
    iosBundleId: 'com.finma.userapp',
  );
}
