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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDB-o1-OAPm-epjOMpoeDJ1obCi_PZdDec',
    appId: '1:131817675071:web:b8504bb2010dfb9cc81b8a',
    messagingSenderId: '131817675071',
    projectId: 'control-concierge-agents',
    authDomain: 'control-concierge-agents.firebaseapp.com',
    storageBucket: 'control-concierge-agents.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXufI1WvxVox5Lu_JOwYN8jYG_fS00B0o',
    appId: '1:131817675071:android:96bbf1808ef6e2a0c81b8a',
    messagingSenderId: '131817675071',
    projectId: 'control-concierge-agents',
    storageBucket: 'control-concierge-agents.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeORQF2dOWjkxsKF7RxzXjZKYqgxYk-mE',
    appId: '1:131817675071:ios:20cacc8e2d6060f0c81b8a',
    messagingSenderId: '131817675071',
    projectId: 'control-concierge-agents',
    storageBucket: 'control-concierge-agents.appspot.com',
    iosBundleId: 'com.example.controlConciergeAgents',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeORQF2dOWjkxsKF7RxzXjZKYqgxYk-mE',
    appId: '1:131817675071:ios:20cacc8e2d6060f0c81b8a',
    messagingSenderId: '131817675071',
    projectId: 'control-concierge-agents',
    storageBucket: 'control-concierge-agents.appspot.com',
    iosBundleId: 'com.example.controlConciergeAgents',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDB-o1-OAPm-epjOMpoeDJ1obCi_PZdDec',
    appId: '1:131817675071:web:df02caf9650cbd2ac81b8a',
    messagingSenderId: '131817675071',
    projectId: 'control-concierge-agents',
    authDomain: 'control-concierge-agents.firebaseapp.com',
    storageBucket: 'control-concierge-agents.appspot.com',
  );

}