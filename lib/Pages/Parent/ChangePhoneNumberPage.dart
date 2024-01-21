import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Input/InputController.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';
import 'package:mobile_dev/Pages/Parent/ParentBase.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ChangePhoneNumberPage extends StatefulWidget {
  @override
  _ChangePhoneNumberPage createState() => _ChangePhoneNumberPage();
}

class _ChangePhoneNumberPage extends State<ChangePhoneNumberPage> {
  ParentController parentController = ParentController();
  InputController inputController = InputController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showVerificationCodeInput = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  late String _verificationId;

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
                  child: Form(
                    key: _formKey,
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
                        buildInputLabel("Enter Current PhoneNumber"),
                        buildInputField(
                          context: context,
                          controller:
                          inputController.phoneNumberController,
                          validator: parentController.validatePhoneNumber,
                        ),

                        SizedBox(height: 16.0),
                        buildInputLabel("Enter New PhoneNumber"),
                        buildInputField(
                          context: context,
                          controller:
                          inputController.changephonenumber,
                          validator: parentController.validatePhoneNumber,
                        ),
                        SizedBox(height: 32.0),
                        Center(

                          child: ElevatedButton(

                            onPressed: () async {
                              if (_formKey.currentState?.validate() ??
                                  false) {
                                // Synchronous validation passed
                                String? existenceError = await parentController
                                    .checkExistPhone(
                                    inputController.phoneNumberController
                                        .text);
                                print(existenceError);
                                if (existenceError == null) {
                                  print("object");
                                  // No existing user, try to register
                                  String? phoennumbercheck = await parentController
                                      .checkExistPhone(
                                      inputController.changephonenumber
                                          .text);
                                  print(phoennumbercheck);
                                  if (phoennumbercheck==null) {
                                    // Registration failed, show dialog
                                    _showErrorDialog(
                                        context,"New PhoneNumber is exist already");
                                  } else if (phoennumbercheck!=null) {
                                    // print("HAMZAAAA");
                                    _verifyPhoneNumber(inputController.changephonenumber.text.toString());
                                    _showVerificationCodeDialog(context);
                                    /*  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhoneVerificationScreen(),
                                      ),
                                    );*/
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

  void _showVerificationCodeDialog(BuildContext context) {
    TextEditingController _verificationCodeController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Verification Code"),
          content: TextField(
            controller: _verificationCodeController,
            decoration: InputDecoration(
              labelText: "Verification Code",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                // Add your logic to handle verification code submission
                String enteredCode = _verificationCodeController.text;
                if (enteredCode.isEmpty) {
                  // Handle empty code case, maybe show an error
                } else {
                  // Proceed with the verification logic
                  Navigator.of(context).pop(); // Close the dialog after submission

                  // Optionally navigate or perform other actions
                  _submitVerificationCode(_verificationCodeController.text.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _verifyPhoneNumber( String phoneIn) async {
    // print( '========>> '+'+90' + _phoneController.text.toString());
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: Duration(seconds: 30),
      phoneNumber: '+9' + phoneIn,
      verificationCompleted: (PhoneAuthCredential credential) async {
        return;
        // Automatic handling of the verification process

      },
      verificationFailed: (FirebaseAuthException e) async{
        return;
        // Handle the error
      },
      codeSent: (String verificationId, int? resendToken) async{
        _verificationId=verificationId;


        return;
        // Update the UI to allow the user to enter the verification code
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) async{
        return;
        // Auto retrieval timeout
      },
    );
  }

  void _submitVerificationCode( String smscontrol) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smscontrol,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParentBase(),
        ),
      );
      // Phone number verified successfully
    } on FirebaseAuthException catch (e) {
      // Handle the error
    }
  }



}