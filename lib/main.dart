import 'package:flutter/material.dart';
import 'package:mobile_dev/DAOServices/MyFirebase.dart';
import 'package:mobile_dev/Pages/Parent/ChildrenProvider.dart';
import 'package:provider/provider.dart';
import 'Pages/Home/HomePage.dart';

void main() {
  MyFirebase fb=MyFirebase();
  fb.initilaize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:homePage(),
    );
  }
}
