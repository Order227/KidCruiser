import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
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
                      validator: parentController.validateName

                    ),
                    SizedBox(height: 16.0),
                    buildInputLabel("Child Surname"),
                    buildInputField(
                      controller: inputController.surnameController,
                        validator: parentController.validateSurname
                    ),
                    SizedBox(height: 16.0),
                    buildInputLabel("Birth Date"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6, // Control the width here
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            // Format and set the date in controller
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            inputController.birthDateController.text = formattedDate;
                          }
                        },
                        child: AbsorbPointer( // Prevents keyboard from showing
                          child: TextField(
                            controller: inputController.birthDateController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Birth Date", // Placeholder
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height: 16.0),
                    buildInputLabel("Shuttle Code"),
                    buildInputField(
                      controller: inputController.shuttleCodeController,
                        validator: parentController.validateShuttleKey
                    ),
                    SizedBox(height: 16.0),
                    buildInputLabel("Select a School"),
                    buildInputField_(
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
                        bool userConfirmed = await _showVerificationCodeDialog(context);

                        bool registrationSuccess=false;
                        if(userConfirmed){
                          registrationSuccess = await parentController.addChild(
                              inputController, selectedSchool,_formKey.currentState!);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ParentBase()),
                          );
                        }
                        if (!registrationSuccess) {

                          print("ssh: ${userConfirmed}");
                          // Registration failed, show dialog
                          _showErrorDialog(
                              "Adding Child is failed. Please try again.");
                        }
                        },
                      label: "Add Child",
                    ),
                  ],
                ),
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

    required TextEditingController controller,
    String? Function(String?)? validator, // Adding validator parameter
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String hintText = "",
    Widget? suffixIcon,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText, // Optional: placeholder text
          border: InputBorder.none,
          suffixIcon: suffixIcon, // Optional: add a suffix icon if needed
        ),
        textAlign: TextAlign.start,
        obscureText: obscureText, // Optional: for password fields
        keyboardType: keyboardType, // Optional: to specify input type
        validator: validator, // Attach the validator function
      ),
    );
  }

  Widget buildInputField_({
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
  void _showErrorDialog(String message) {
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

  Future<bool> _showVerificationCodeDialog(BuildContext context) async {
    bool userConfirmed = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure to add child?"),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog with false
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // User confirmed, close the dialog with true
                userConfirmed=true;
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    return userConfirmed;
  }
}