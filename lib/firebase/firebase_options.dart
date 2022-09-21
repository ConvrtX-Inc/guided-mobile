
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
///Firebase config
class DefaultFirebaseConfig {
  ///Firebase Optionss
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
          appId: '1:159579065895:ios:250b69cc9efaf3afc80802',
          apiKey: 'AIzaSyD7ZtG4KTVXyaEFEDF727O8qepDm5nWhtU',
          projectId: 'guided-dev-app',
          messagingSenderId: '159579065895',
          storageBucket: 'guided-dev-app.appspot.com',
          iosBundleId: 'com.canada.guided'
      );
    } else {
      // android
      return const FirebaseOptions(
        appId: '1:159579065895:android:68a1a1f7ab881780c80802',
        apiKey: 'AIzaSyBL4i_4Xkq3G5Yd-1M0YHtQynB6OhOHHko',
        projectId: 'guided-dev-app',
        messagingSenderId: '159579065895',
        storageBucket: 'guided-dev-app.appspot.com',
      );
    }
  }
}
