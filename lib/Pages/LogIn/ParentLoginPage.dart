import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Input/InputController.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';
import 'package:mobile_dev/Entities/Concretes/Parent.dart';
import 'package:mobile_dev/Pages/Home/HomePage.dart';
import 'package:mobile_dev/Pages/Parent/ParentBase.dart';

import '../../Controller/Abstract/AbstractController.dart';
import '../Select/login_select.dart';

//import '../hostess/hostess_base.dart';

class LogInParent extends StatefulWidget {
  @override
  _hostes_loginState createState() => _hostes_loginState();
}

class _hostes_loginState extends State<LogInParent> {
  InputController inputController = InputController();
  ParentController parentController = ParentController();
  bool _isObscured = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /*
  @overrideLogInParent
  void dispose() {
    inputController.dispose();
    parentLoginController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double topofbutton = screenSize.height * 0.45;
    double lefofbutton = screenSize.width * 0.1;
    double rightofbutton = screenSize.width * 0.15;
    double widthbutton = screenSize.width * 0.25;
    double heightbutton = screenSize.height * 0.1;
    double betweenbutton = screenSize.width * 0.1;
    return Scaffold(
      body: Container(
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
            stops: [0.0, 0.2, 0.5, 1.0],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                // Background Image
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.011,
                  top: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset(
                    'assets/output_image.png',
                    width: MediaQuery.of(context).size.width * 0.986,
                    height: MediaQuery.of(context).size.height * 0.498,
                  ),
                ),

                // Sign In Button
                Positioned(
                  top: (topofbutton / 0.45) * 0.66,
                  left: lefofbutton * 3,
                  child: ElevatedButton(
                    onPressed: () async {
                      var result = await parentController.logIn(inputController, _formKey.currentState!);

                      if (result == LoginResult.success) {
                        // Navigate to the next page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ParentBase()),
                        );
                      } else if (result == LoginResult.phoneNumberNotExist) {
                        // Show an error message for non-existent phone number
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "ERROR!",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  // Replace with your desired color
                                ),
                              ),
                              //backgroundColor: Colors.red,
                              content: Text("Phone number does not exist.",style: TextStyle(fontSize: 15),),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Handle other errors
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "ERROR!",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  // Replace with your desired color
                                ),
                              ),
                              content: Text("Invalid phone number or password!",style: TextStyle(fontSize: 15),),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),

                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Color(0x3F000000),
                      elevation: 4,
                    ),
                    child: Container(
                      width: widthbutton,
                      height: heightbutton / 3,
                      alignment: Alignment.center,
                      child: Text(
                        'Sign In',
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

                // Input Field
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.12,
                  top: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    children: [
                      // Phone NUmber Input Field

                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Phone Number',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: TextFormField(
                                // obscureText: tr,
                                controller:
                                    inputController.phoneNumberController,
                                validator: parentController.validatePhoneNumber,
                                //controller: inputController.phoneNumberController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,// Add an outline border
                                  hintText: '0-(5xx)-xxx-xxxx',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Password',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              // Make sure the height can accommodate the error message
                              height: MediaQuery.of(context).size.height * 0.1, // Adjusted height
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: TextFormField(
                                obscureText: _isObscured,
                                controller: inputController.passwordController,
                                validator: parentController.validatePassword,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorStyle: TextStyle( // Adjust the style of error text
                                      fontSize: 10, // Smaller font size
                                      height: 0.7, // Tighter line height
                                    ),
                                    errorMaxLines: 3, // Allow error text to take up to 3 lines
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscured ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscured = !_isObscured;
                                        });
                                      },
                                    )
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // return back button
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.02,
                  top: MediaQuery.of(context).size.height * 0.05,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFF222222)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInSelect()),
                      );
                    },
                  ),
                ),

                // SIGN IN HEADER
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 231,
                          child: Text(
                            'SIGN IN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF775555),
                              fontSize: 32,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        Container(
                          width: 339,
                          height: 1,
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
