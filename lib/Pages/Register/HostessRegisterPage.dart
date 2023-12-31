import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Hostess/HostessController.dart';
import 'package:mobile_dev/Controller/Concretes/Input/InputController.dart';
import 'package:mobile_dev/Pages/LogIn/HostessLoginPage.dart';

class HostessRegister extends StatefulWidget {
  @override
  _HostessRegisterState createState() => _HostessRegisterState();
}

class _HostessRegisterState extends State<HostessRegister> {
  bool _isObscured = true;
  bool _isObscured_ = true;
  HostessController hostessRegisterController = HostessController();
  InputController inputController = InputController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _nameError;
  String? _surnameError;
  String? _phoneNumberError;
  String? _shuttleCodeError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/output_image.png',
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
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: 80),
                                SizedBox(
                                  width: 231,
                                  child: Text(
                                    'SIGN UP',
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
                          SizedBox(height: screenHeight * 0.02),
                          buildCustomInputField(
                            inputController.nameController,
                            "Enter Name",
                            hostessRegisterController.validateName,
                            TextInputType.text,
                            errorText: _nameError,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                          buildCustomInputField(
                            inputController.surnameController,
                            "Enter Surname",
                            hostessRegisterController.validateSurname,
                            TextInputType.text,
                            errorText: _surnameError,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                          buildCustomInputField(
                            inputController.phoneNumberController,
                            "Enter Phone number",
                            hostessRegisterController.validatePhoneNumber,
                            TextInputType.datetime,
                            errorText: _phoneNumberError,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                          buildCustomInputField(
                            inputController.shuttleCodeController,
                            "Enter Shuttle Code",
                            hostessRegisterController.validateShuttleKey,
                            TextInputType.text,
                            errorText: _shuttleCodeError,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
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
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  decoration: ShapeDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: TextFormField(
                                    obscureText: _isObscured,
                                    controller: inputController.passwordController,
                                    validator:
                                    hostessRegisterController.validatePassword,
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        contentPadding:
                                        EdgeInsets.only(left: 20.0, top: 20.0),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscured
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscured = !_isObscured;
                                            });
                                          },
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Confirm Password',
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
                                    obscureText: _isObscured_,
                                    controller:
                                    inputController.confirmpasswordController,
                                    validator: (value) {
                                      if (value !=
                                          inputController.passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null; // Return null if the entered password is valid
                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        contentPadding:
                                        EdgeInsets.only(left: 20.0, top: 20.0),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscured_
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscured_ = !_isObscured_;
                                            });
                                          },
                                        ),
                                        helperText: "Re-enter your password"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Positioned(
                            bottom: 0,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    if (await hostessRegisterController.register(
                                        inputController, _formKey.currentState!)) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LogInHostess(),
                                        ),
                                      );
                                    }
                                  } else {
                                    setState(() {
                                      _nameError = hostessRegisterController
                                          .validateName(
                                          inputController.nameController.text);
                                      _surnameError = hostessRegisterController
                                          .validateSurname(
                                          inputController.surnameController.text);
                                      _phoneNumberError =
                                          hostessRegisterController.validatePhoneNumber(
                                              inputController.phoneNumberController.text);
                                      _shuttleCodeError = hostessRegisterController
                                          .validateShuttleKey(
                                          inputController.shuttleCodeController.text);
                                      _passwordError = hostessRegisterController
                                          .validatePassword(
                                          inputController.passwordController.text);
                                      _confirmPasswordError = hostessRegisterController
                                          .validatePassword(
                                          inputController.confirmpasswordController.text);
                                    });
                                  }
                                },
                                child: Text("Register"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomInputField(
      TextEditingController x_controller,
      String labelText,
      String? Function(String?)? x_validator,
      TextInputType keyboardType,
      {bool isObscured = false,
        VoidCallback? onPressed,
        String? errorText,
        double? screenWidth,
        double? screenHeight}) {
    return Container(
      width: screenWidth! * 0.6,
      height: screenHeight! * 0.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.04,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: screenWidth * 0.6,
            height: screenHeight * 0.08,
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: TextFormField(
              controller: x_controller,
              validator: x_validator,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20.0, bottom: 5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}