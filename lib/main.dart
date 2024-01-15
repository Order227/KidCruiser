import 'package:flutter/material.dart';
import 'package:mobile_dev/DAOServices/MyFirebase.dart';
import 'Pages/Home/HomePage.dart';

void main() {
  MyFirebase fb=MyFirebase();
  fb.initilaize();
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
