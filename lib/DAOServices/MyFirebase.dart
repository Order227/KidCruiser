// main.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class MyFirebase{

  late QuerySnapshot querySnapshot;

  void initilaize () async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDfAWVlB6r-MK7nNGBftYSkqN5gir__QSg",
        appId: "1:304364720194:android:bacd9d16a1f7b5cf571ddb",
        messagingSenderId: "304364720194",
        projectId: "kid-cruiser-goat",
      ),
    );
    await Firebase.initializeApp();
  }
  


}