import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Input/InputController.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';

class ChangePhoneNumberPage extends StatelessWidget {
  ParentController parentController = ParentController();
  InputController inputController = InputController();

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
            child: Builder(
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Change Phone Number",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      buildInputLabel("Enter New Phone Number"),
                      buildInputField(
                        context: context,
                        controller:
                        inputController.phoneNumberController,
                        validator: parentController.validatePhoneNumber,
                      ),
                      SizedBox(height: 16.0),
                      buildInputLabel("Confirm New Phone Number"),
                      buildInputField(
                        context: context,
                        controller:
                        inputController.phoneNumberController,
                        validator: parentController.validatePhoneNumber,
                      ),
                      SizedBox(height: 16.0),
                      buildInputLabel("Enter Old Phone Number"),
                      buildInputField(
                        context: context,
                        controller:
                        inputController.phoneNumberController,
                        validator: parentController.validatePhoneNumber,
                      ),
                      SizedBox(height: 32.0),
                      buildElevatedButton(
                        context: context,
                        onPressed: () async {

                        },
                        label: "Change Phone Number",
                      ),
                    ],
                  ),
                );
              },
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
    required BuildContext context,
    required TextEditingController? controller,
    required String? Function(String?)? validator,
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
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget buildElevatedButton({
    required BuildContext context,
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