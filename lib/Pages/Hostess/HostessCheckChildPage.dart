import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Hostess/HostessController.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';
import 'package:mobile_dev/Entities/Concretes/Children.dart';
import 'package:mobile_dev/Pages/Hostess/HostessBasePage.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(HostessApp());
}

class HostessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostess Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HostessCheckChildPage(),
    );
  }
}

class HostessCheckChildPage extends StatefulWidget {
  @override
  _HostessCheckChildPageState createState() => _HostessCheckChildPageState();
}

class _HostessCheckChildPageState extends State<HostessCheckChildPage> {
  HostessController hostessController = HostessController();
  List<Children> childrenList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    childrenList = await hostessController.getChildren();
    childrenList.forEach((element) {
      print(element.name);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostess Screen"),
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
              ElevatedButton(
                onPressed: () async {
                  bool checkfinish = await hostessController
                      .canFinishcruise(childrenList);
                  print(checkfinish);
                  if (checkfinish) {
                    print(("CHECK"));
                    _showErrorDialog(context,
                        "You can not finish the Cruise.\nYou must drop off the chilren");
                    //Navigator.of(context).pop();
                  } else {
                    _showFinish(context,"You can Finish the cruise");
                    // Navigator.of(context).pop();

                  }

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
              ),
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
            color: _getChildColor(child.state!),
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
                        Text('${child.name} ${child.surname}',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 4),
                        Text('Status: ${child.state}',
                            style:
                            TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  ),
                  DropdownButton<String>(
                    value: child.state,
                    onChanged: (String? newValue) {
                      setState(() {
                        child.state = newValue!;

                        hostessController.updateChildren(child);
                        // Update the child's status in your data model
                        // For example, update hostessController.students data
                      });
                    },
                    items: <String>['YOLDA', 'EVDE', 'OKUL']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    icon: Icon(Icons.phone),
                    color: Colors.black,
                    onPressed: () async {
                      final phoneNumber = child.phoneNumber;
                      await launch('tel:$phoneNumber');
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /*Widget _buildFinishCruiseButton() {
    return ElevatedButton(
      onPressed: () async {
        bool checkfinish =
            await hostessController.canFinishcruise(childrenList);
        print(checkfinish);
        if (checkfinish) {
          print(("CHECK"));
          _showErrorDialog(
              "You can not finish the Cruise.\nYou must drop off the chilren");
          Navigator.of(context).pop();
        } else {
          _showFinish("Yu can Finish the cruise");
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HostessBasePage(),
            ),
          );
        }

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
  }*/

  Color _getChildColor(String status) {
    switch (status) {
      case "EVDE":
        return Color(0xFFFFB238);
      case "YOLDA":
        return Color(0xFF9c59b7);
      case "OKUL":
        return Color(0xFFe070b0);
      default:
        return Colors.grey;
    }
  }

  void _showErrorDialog(BuildContext context,String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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

  void _showFinish(BuildContext context,String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('SUCCESFULL'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HostessBasePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}