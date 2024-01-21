import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dev/DAOServices/PushNotificationService.dart';
import 'Pages/Home/HomePage.dart';



@pragma('vm-entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDfAWVlB6r-MK7nNGBftYSkqN5gir__QSg",
      appId: "1:304364720194:android:bacd9d16a1f7b5cf571ddb",
      messagingSenderId: "304364720194",
      projectId: "kid-cruiser-goat",
    ),
  );

  print(message.notification!.title.toString());
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDfAWVlB6r-MK7nNGBftYSkqN5gir__QSg",
      appId: "1:304364720194:android:bacd9d16a1f7b5cf571ddb",
      messagingSenderId: "304364720194",
      projectId: "kid-cruiser-goat",
    ),
  );
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  PushNotificationService pushNotificationService = PushNotificationService();

  pushNotificationService.requestNotificationPermission();
  pushNotificationService.firebaseInit();

  pushNotificationService.getDeviceToken().then((value) {
    print("DEVICE TOKEN: ${value}");
  });


  runApp(const MyApp());

}

class MyApp extends StatelessWidget  {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:   homePage(),
    );
  }
}
