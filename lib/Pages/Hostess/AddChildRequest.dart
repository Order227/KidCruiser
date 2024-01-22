import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Hostess/HostessController.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';
import 'package:mobile_dev/Entities/Concretes/Children.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(AddChildRequestsApp());
}

class AddChildRequestsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Child Requests Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddChildRequestsScreen(),
    );
  }
}

class AddChildRequestsScreen  extends StatefulWidget {
  @override
  _AddChildRequestsScreenState createState() => _AddChildRequestsScreenState();
}

class _AddChildRequestsScreenState extends State<AddChildRequestsScreen> {
  HostessController hostessController = HostessController();
  List<Children> childrenList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    childrenList = await hostessController.getPendingList();
    childrenList.forEach((element) {print(element.name);});
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Child Request Screen"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
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
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: childrenList.length,
                  itemBuilder: (context, index) {
                    return _buildChildContainer(childrenList[index]);
                  },
                ),
              ),
              _buildFinishCruiseButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChildContainer(Children child) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        bool isEditing = true; // Tracks if edit mode is active

        return Container(
          margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${child.name} ${child.surname}', style: TextStyle(fontSize: 20)),
                        SizedBox(height: 4),
                        Text('School: ${child.school}, Shuttle Key: ${child.shuttleKey}', style: TextStyle(fontSize: 16, color: Colors.black54)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      // ACCEPT BUTTON
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            hostessController.updateChildren(child);
                            // Update the child's status in your data model
                            // For example, update hostessController.students data
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.green, // Change color as needed
                          side: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        child: Image.asset(
                          'assets/tick-icon.png', // Replace with the actual path to your tick icon
                          width: 24,  // Adjust the width as needed
                          height: 24,  // Adjust the height as needed
                        ),
                      ),
                      SizedBox(width: 8), // Add some spacing between the buttons

                      // REJECT BUTTON
                      ElevatedButton(
                        onPressed: () {
                          // Handle the reject action
                          setState(() {
                            hostessController.updateChildren(child);
                            // Update the child's status in your data model
                            // For example, update hostessController.students data
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          //primary: Colors.red, // Change color as needed
                          side: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        child: Image.asset(
                          'assets/cross-icon.png', // Replace with the actual path to your cross icon
                          width: 24,  // Adjust the width as needed
                          height: 24,  // Adjust the height as needed
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }



  Widget _buildFinishCruiseButton() {
    return ElevatedButton(
      onPressed: () {
        // Implement logic for Finish Cruise button
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF77474),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        'Finish Cruise',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}