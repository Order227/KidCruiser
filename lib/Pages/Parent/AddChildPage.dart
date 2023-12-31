import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Input/InputController.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';
import 'package:mobile_dev/Controller/Concretes/School/SchoolController.dart';
import 'package:mobile_dev/Pages/Parent/ParentBase.dart';

class AddChildPage extends StatefulWidget {
  @override
  _AddChildPage createState() => _AddChildPage();
}

class _AddChildPage extends State<AddChildPage> {
  String? selectedSchool;
  ParentController parentController = ParentController();
  InputController inputController = InputController();
  SchoolController schoolController = SchoolController();
  List<DropdownMenuItem<String>> dropdownMenuItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<String> schoolList = await schoolController.getListFromDB();
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/output_image.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
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
                  stops: [0.0, 0.2, 0.5, 1.0],
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start, // Bu satır eklenmiştir
                children: [
                  Center(
                    child: Text(
                      "Add Child",

                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  buildInputLabel("Child Name"),
                  buildInputField(
                    controller: inputController.nameController,
                  ),
                  SizedBox(height: 16.0),
                  buildInputLabel("Child Surname"),
                  buildInputField(
                    controller: inputController.surnameController,
                  ),
                  SizedBox(height: 16.0),
                  buildInputLabel("Birth Date"),
                  buildInputField(
                    controller: inputController.birthDateController,
                  ),
                  SizedBox(height: 16.0),
                  buildInputLabel("Shuttle Code"),
                  buildInputField(
                    controller: inputController.shuttleCodeController,
                  ),
                  SizedBox(height: 16.0),
                  buildInputLabel("Select a School"),
                  buildInputField(
                    controller: null,
                    child: DropdownButton<String>(
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
                    ),
                  ),
                  SizedBox(height: 16.0),
                  buildElevatedButton(
                    onPressed: () async {
                      if (await parentController.addChild(
                          inputController, selectedSchool)) {
                        print("SUCCESS!");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ParentBase()),
                        );
                      } else {
                        print("Error");
                      }
                    },
                    label: "Add Child",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget buildInputField({
    required TextEditingController? controller,
    Widget? child,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6, // Yatay uzunluğu buradan kontrol edebilirsiniz
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: child ??
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            textAlign: TextAlign.start,
          ),
    );
  }

  Widget buildElevatedButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF66BB82),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}