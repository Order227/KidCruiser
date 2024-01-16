import 'package:flutter/material.dart';
import 'package:mobile_dev/Pages/Home/HomePage.dart';
import 'package:mobile_dev/Pages/Hostess/HostessProfilePage.dart';
import 'package:mobile_dev/Pages/hostess/CheckChild.dart';


class HostessBasePage extends StatefulWidget {
  @override
  HostessBasePageState createState() => HostessBasePageState();
}

class HostessBasePageState extends State<HostessBasePage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {

          return false;
        },

    child: Scaffold(
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
          child: Stack(
            children: [
              // START CRUISE button
              Positioned(
                left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.5) / 2,
                top: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.07) / 2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HostessScreen()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: ShapeDecoration(
                      color: Color(0xFF66BB82),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.036),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text for the button
                        Text(
                          'Start Cruise',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        SizedBox(width: 8),  // Add some space between the logo and text
                        // Add your logo here
                        Image.asset(
                          'assets/Road_alt_fill.png', // Replace with the actual path to your logo
                          width: 24,  // Adjust the width as needed
                          height: 24,  // Adjust the height as needed
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // LOG OUT Button
              Positioned(
                left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.472) / 2,
                top: MediaQuery.of(context).size.height * 0.792,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => homePage()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.472,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFFBBBB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.036),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'LOG OUT',
                        style: TextStyle(
                          color: Color(0xFF0C0B0B),
                          fontSize: MediaQuery.of(context).size.width * 0.056,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // LOGO HEADER
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image.asset(
                    'assets/output_image.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
              ),

              // Profile Button
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HostessProfilePage()),
                    );
                  },
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