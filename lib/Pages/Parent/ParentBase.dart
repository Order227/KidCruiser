import 'package:flutter/material.dart';
import 'package:mobile_dev/Pages/LogIn/ParentLoginPage.dart';
import 'package:mobile_dev/Pages/Parent/CheckChild.dart';
import 'package:mobile_dev/Pages/Parent/AddChildPage.dart';

void main() {
  runApp(ParentBase());
}

class ParentBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double topofbutton = screenSize.height * 0.45;
    double lefofbutton = screenSize.width * 0.1;
    double rightofbutton = screenSize.width * 0.15;
    double widthbutton = screenSize.width * 0.25;
    double heightbutton = screenSize.height * 0.1;
    double betweenbutton = screenSize.width * 0.1;

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
                  Color(0xFFDBCFC4)
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset("assets/output_image.png"),
                  ),
                ),
                Positioned(
                  top: topofbutton,
                  left: 3 * lefofbutton,
                  child: Column(
                    children: [
                      Positioned(
                        top: topofbutton,
                        left: lefofbutton,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddChildPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(
                                0xFFFEFFEE), // Set the background color of the button
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(30.0), // Set the radius
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
                                    Icons.add,
                                    color: Colors
                                        .black, // Set your desired icon color
                                    size: 50.0, // Set your desired icon size
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    "Add Child",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                      12.0, // Set your desired text size
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Positioned(
                        top: topofbutton,
                        left: lefofbutton,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CheckChild()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(
                                0xFFFEFFEE), // Set the background color of the button
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(30.0), // Set the radius
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
                                    Icons.accessibility_outlined,
                                    color: Colors
                                        .black, // Set your desired icon color
                                    size: 50.0, // Set your desired icon size
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    "Check Child",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                      12.0, // Set your desired text size
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: (topofbutton / 0.45) * 0.13,
                  left: lefofbutton * 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInParent()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Color(0x3F000000),
                      elevation: 4,
                    ),
                    child: Container(
                      width: widthbutton * 2,
                      height: heightbutton / 1.5,
                      alignment: Alignment.center,
                      child: Text(
                        'Go Back',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width * 0.25,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Text(
                        'KidCruiser\nVersion 1.0.0\n Order 227 Team',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}