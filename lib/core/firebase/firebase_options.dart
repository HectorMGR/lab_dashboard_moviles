import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
class AppFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: 'AIzaSyCa0J5mCRDysAn3xCqSuC1DcCeFgdD5Z3U',
        appId: '1:566264148896:web:a81e89f1d948b5cb992ac5',
        messagingSenderId: '566264148896',
        projectId: 'barberly-dev-6aef2',
        authDomain: 'barberly-dev-6aef2.firebaseapp.com',
        storageBucket: 'barberly-dev-6aef2.firebasestorage.app',
      );
    }
    throw UnsupportedError(
      'This app is configured for web only.',
    );
  }
}