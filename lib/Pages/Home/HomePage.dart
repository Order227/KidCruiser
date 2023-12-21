import 'package:flutter/material.dart';
import 'package:mobile_dev/Pages/Select/login_select.dart';
import 'package:mobile_dev/Pages/Select/register_select.dart';



class homePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double topofbutton = screenSize.height * 0.6;
    double lefofbutton = screenSize.width * 0.05;
    double widthbutton = screenSize.width * 0.25;
    double heightbutton = screenSize.height * 0.1;
    double betweenbutton = screenSize.width * 0.1;
    return  Scaffold(
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
                  left: lefofbutton,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Sign In Button
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LogInSelect()),
                          );
                        },
                        icon: Icon(Icons.login),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0x6DFDFFEE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: Color(0x3F000000),
                          elevation: 4,
                        ),
                        label: Container(
                          width: widthbutton,
                          height: heightbutton / 1.5,
                          alignment: Alignment.center,
                          child: Text(
                            'SIGN IN',
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
                      SizedBox(width: betweenbutton),
                      // Sign Up Button
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterSelect()),
                          );

                          // Add your Sign In button logic here
                          // Add your Sign Up button logic here
                        },
                        icon: Icon(Icons.add_box_rounded),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0x6DFDFFEE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: Color(0x3F000000),
                          elevation: 4,
                        ),
                        label: Container(
                          width: widthbutton,
                          height: heightbutton / 1.5,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'SIGN UP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width*0.25,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.1,
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
      );

  }
}
