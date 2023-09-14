import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDa7Lv0xx-qt41aB3tlMk5z7SDfeKZCksE",
            authDomain: "clone-1b5b4.firebaseapp.com",
            projectId: "clone-1b5b4",
            storageBucket: "clone-1b5b4.appspot.com",
            messagingSenderId: "183183604276",
            appId: "1:183183604276:web:54fc0cd0b3d09b6812a861",
            measurementId: "G-0GBVHVP393"));
  } else {
    await Firebase.initializeApp();
  }
}
