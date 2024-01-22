import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Hostess/HostessController.dart';
import 'package:mobile_dev/Controller/Concretes/School/SchoolController.dart';
import 'package:mobile_dev/Pages/Home/HomePage.dart';
import 'package:mobile_dev/Pages/Hostess/AddChildRequest.dart';
import 'package:mobile_dev/Pages/Hostess/HostessCheckChildPage.dart';
import 'package:mobile_dev/Pages/Hostess/HostessProfilePage.dart';
import 'package:mobile_dev/Entities/Concretes/Children.dart'; // yeni *******************************************

class HostessBasePage extends StatefulWidget {
  @override
  HostessBasePageState createState() => HostessBasePageState();
}

class HostessBasePageState extends State<HostessBasePage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  HostessController hostessController = HostessController();
  SchoolController schoolController = SchoolController();
  List<DropdownMenuItem<String>> dropdownMenuItems = [];
  String? selectedSchool; 
  List<Children> childrenList = [];  // yeni *******************************************
  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }



  Future<void> fetchData() async {
    List<String> schoolList = await schoolController.getSchoolsForHostess(hostessController.hostess_.shuttleKey);
    childrenList = await hostessController.getPendingList();                     // yeni *******************************************
    List<DropdownMenuItem<String>> items = schoolList.map((String schoolName) {
      return DropdownMenuItem<String>(
        value: schoolName,
        child: Text(schoolName),
      );
    }).toList();

    items.insert(0, DropdownMenuItem<String>(
      value: null,
      child: Text("Select a School"),
    ));

    setState(() {
      dropdownMenuItems = items;
    });
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
                      if(selectedSchool!=null){
                        hostessController.setSelectedSchoold(selectedSchool);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HostessCheckChildPage()),
                        );
                      }else{
                        _showErrorDialog(
                            context,"You must select a school before starting cruise!");
                      }
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

                // ADD CHILD REQUESTS BUTTON
Positioned(
  top: MediaQuery.of(context).size.height * 0.08,
  width: MediaQuery.of(context).size.width * 0.31,
  child: Stack(
    children: [
      Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddChildRequestsScreen()),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.036),
                side: BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/person-icon.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ),

      // Red Dot Positioned on Top Right
      if (childrenList.length > 0)
        Positioned(
  left: MediaQuery.of(context).size.height * 0.09,
  height: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ),
    ],
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
                  bottom: MediaQuery.of(context).size.height * 0.62,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Image.asset(
                      'assets/output_image.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                ),

                // Profile Button
                Positioned(
                  right: (MediaQuery.of(context).size.width * 0.05) / 2,
                  top: MediaQuery.of(context).size.height * 0.09,
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

                //DROP DOWN

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.35,
                  left: MediaQuery.of(context).size.width * 0.35, // adjust the position as needed

                  child: Stack(
                    children: [
                      // White button as a background
                      ElevatedButton(
                        onPressed: () {}, // No functionality
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 177, 196, 166),
                          elevation: 0, // No shadow
                        ),
                        child: SizedBox(
                          height: 40, // Adjust the height as needed
                          width: 82, // Adjust the width as needed
                        ),
                      ),

                      // DropdownButton on top
                      DropdownButton<String>(
                        value: selectedSchool,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSchool = newValue;
                          });
                        },
                        items: dropdownMenuItems,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        underline: SizedBox(),
                        elevation: 2, // Adjust the elevation as needed
                        dropdownColor: Colors.white, // Set your desired background color
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showErrorDialog(BuildContext context,String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
    );
  }
}