import 'package:flutter/cupertino.dart';

class InputController{
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController(text: '05');
  TextEditingController changephonenumber = TextEditingController(text: '05');
  TextEditingController changephonenumberconfirm = TextEditingController(text: '05');
  TextEditingController shuttleCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController newpasswordControllerconfirm = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController selectedSchoolController = TextEditingController();
}