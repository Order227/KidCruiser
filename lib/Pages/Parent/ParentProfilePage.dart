import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';
import 'package:mobile_dev/Pages/Parent/ChangePasswordPage.dart';
import 'package:mobile_dev/Pages/Parent/ParentBase.dart';
import 'package:mobile_dev/Pages/Parent/changePhoneNumberPage.dart';

class ParentProfilePage extends StatelessWidget {
  ParentController parentController = ParentController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  Color(0xDBFFFBFB),
                  Color(0xF1C6B8C6),
                  Color(0xF3D8D6C2),
                  Color(0xFFDBCFC4),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 100.0,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '${parentController.parent_.name} ${parentController.parent_.surname}', // Kullanıcı adınızı dinamik olarak değiştirebilirsiniz
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // ParentBase'deki stil ile uyumlu renk
                    ),
                  ),
                  SizedBox(height: 10.0),

                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangePhoneNumberPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFEFFEE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      shadowColor: Color(0x3F000000),
                      elevation: 4,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.black,
                              size: 50.0,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Change Phone',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFEFFEE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      shadowColor: Color(0x3F000000),
                      elevation: 4,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.password,
                              color: Colors.black,
                              size: 50.0,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Change Password',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ParentBase()),
              );
            },
          ),
        ),
      ),
    );
  }
}