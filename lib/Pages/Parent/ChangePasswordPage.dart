import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Input/InputController.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';

import 'ParentBase.dart';

class ChangePasswordPage extends StatelessWidget {
  ParentController parentController = ParentController();
  InputController inputController = InputController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showVerificationCodeInput = false;

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
          Form(
            key: _formKey,
            child: Center(
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
                            "Change Password",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        buildInputLabel("Enter Current Password"),
                        buildInputField(
                          context: context,
                          controller:
                          inputController.passwordController,
                          validator: parentController.validatePassword,
                        ),
                        SizedBox(height: 16.0),
                        buildInputLabel("Enter New Password"),
                        buildInputField(
                          context: context,
                          controller:
                          inputController.newpasswordController,
                          validator: parentController.validatePassword,
                        ),
                        SizedBox(height: 16.0),
                        buildInputLabel("Confirm New Password"),
                        buildInputField(
                          context: context,
                          controller: inputController.newpasswordControllerconfirm,
                          validator: (value) {
                            // First, check if the entered value meets your password criteria
                            String? basicValidation = parentController.validatePassword(value);
                            if (basicValidation != null) {
                              // If basic validation fails, return the error message
                              return basicValidation;
                            }
                            // Then, check if the new password and confirm new password match
                            if (value != inputController.newpasswordController.text) {
                              return 'Passwords do not match';
                            }
                            // If everything is fine, return null
                            return null;
                          },
                        ),
                        SizedBox(height: 32.0),
                        Center(
            
                          child: ElevatedButton(
            
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ??
                                  false) {
                                // Synchronous validation passed
                                String? existenceError = await parentController
                                    .checkExistPassword(
                                    inputController.passwordController
                                        .text);
                                print(existenceError);
                                if (existenceError == null) {
                                  print("object");
                                  // No existing user, try to register
                                  String? phoennumbercheck = await parentController
                                      .checkExistPassword(
                                      inputController.newpasswordController
                                          .text);
                                  print(phoennumbercheck);
                                  if (phoennumbercheck==null) {
                                    // Registration failed, show dialog
                                    _showErrorDialog(
                                        context,"New password can not same as old one");
                                  } else if (phoennumbercheck!=null) {
                                    // print("HAMZAAAA");

                                    _showVerificationCodeInput = true;


                                    // Trigger AlertDialog for verification code input
                                    if (_showVerificationCodeInput) {
                                      Future.delayed(Duration.zero, () =>
                                          changedPassword(
                                              context));
                                    }
                                    /*
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LogInParent(),
                                        ),
                                      );*/
                                    // Registration success, proceed further
                                  }
                                } else {
                                  // Existing user, show error dialog
                                  _showErrorDialog(context,existenceError!);
                                }
                              }
                            },
                            child: Text("Change"),
                          ),
            
                        ),
                      ],
                    ),
                  );
                },
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

  void changedPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Completed'),
            content: Text("Password has Changed"),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParentBase(),
                    ),
                  );
                },
              ),
            ],
          ),
    );
  }

}