// File: lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // ✅ Web Firebase configuration - NOW USING CONCRETE KEYS
      return const FirebaseOptions(
        apiKey: 'AIzaSyCZBC3isZu-r8imPHn6v_6t7JKJconVej8',
        authDomain: 'medijob-connect.firebaseapp.com',
        projectId: 'medijob-connect',
        storageBucket: 'medijob-connect.firebasestorage.app',
        messagingSenderId: '540058534324',
        appId: '1:540058534324:web:c9302a8a492ab1db9bb2e1',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
            'DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  // ⚠️ Android Firebase configuration - SHARED VALUES FILLED
  static const FirebaseOptions android = FirebaseOptions(
    // ❗ MUST REPLACE: Get from google-services.json
    apiKey: 'YOUR_ANDROID_API_KEY', 
    // ❗ MUST REPLACE: Get from Google Console (App ID for Android)
    appId: 'YOUR_ANDROID_APP_ID', 
    
    messagingSenderId: '540058534324',
    projectId: 'medijob-connect',
    storageBucket: 'medijob-connect.firebasestorage.app',
  );

  // ⚠️ iOS Firebase configuration - SHARED VALUES FILLED
  static const FirebaseOptions ios = FirebaseOptions(
    // ❗ MUST REPLACE: Get from GoogleService-Info.plist
    apiKey: 'YOUR_IOS_API_KEY', 
    // ❗ MUST REPLACE: Get from Google Console (App ID for iOS)
    appId: 'YOUR_IOS_APP_ID', 
    
    messagingSenderId: '540058534324',
    projectId: 'medijob-connect',
    storageBucket: 'medijob-connect.firebasestorage.app',
    
    // ❗ MUST REPLACE: Get from GoogleService-Info.plist (CLIENT_ID)
    iosClientId: 'YOUR_IOS_CLIENT_ID', 
    // ❗ MUST REPLACE: Must match your iOS Bundle ID (e.g., com.example.medijobconnect)
    iosBundleId: 'YOUR_IOS_BUNDLE_ID', 
  );
}
