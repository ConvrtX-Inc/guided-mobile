
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
///Firebase config
class DefaultFirebaseConfig {
  ///Firebase Optionss
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
          appId: '1:875562076914:web:8c5f5afb1b62d9918b5e6b',
          apiKey: 'AIzaSyCIag8Y1v3gmGnF55sGh4ocFnZq6qsEnKM',
          projectId: 'guided-convrtx',
          messagingSenderId: '875562076914',
          storageBucket: 'guided-convrtx.appspot.com',
          iosBundleId: 'com.canada.guided'
      );
    } else {
      // android
      return const FirebaseOptions(
        appId: '1:875562076914:web:8c5f5afb1b62d9918b5e6b',
        apiKey: 'AIzaSyCIag8Y1v3gmGnF55sGh4ocFnZq6qsEnKM',
        projectId: 'guided-convrtx',
        messagingSenderId: '875562076914',
        storageBucket: 'guided-convrtx.appspot.com',
      );
    }
  }
}