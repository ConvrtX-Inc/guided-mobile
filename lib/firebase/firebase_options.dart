
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
///Firebase config
class DefaultFirebaseConfig {
  ///Firebase Optionss
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
          appId: '1:875562076914:ios:315a158d0d6173818b5e6b',
          apiKey: 'AIzaSyD1kAPIrkeTHM2OywqemU9pAUFVHbBfnk4',
          projectId: 'guided-convrtx',
          messagingSenderId: '875562076914',
          storageBucket: 'guided-convrtx.appspot.com',
          iosBundleId: 'com.canada.guided'
      );
    } else {
      // android
      return const FirebaseOptions(
        appId: '1:875562076914:android:6e7a7e74b67bbe578b5e6b',
        apiKey: 'AIzaSyBVIDD8tUu9aMW_ZZ4v1_0GQNrVDIS-Ovw',
        projectId: 'guided-convrtx',
        messagingSenderId: '875562076914',
        storageBucket: 'guided-convrtx.appspot.com',
      );
    }
  }
}