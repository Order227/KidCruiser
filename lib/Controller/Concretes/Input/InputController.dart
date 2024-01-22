import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

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
  TextEditingController verificaitoncode = TextEditingController();

  static const String accountSid = 'AC8d892422a71a92798344d5462e1dc338';
  static const String authToken = '316de76e179ebf10f2a15de1e71460e4';
  static const String serviceSid = '+16787234995';


  var sendotp;


    late TwilioFlutter twiliflutter;
  sendSms()
  {
    twiliflutter =TwilioFlutter(accountSid: accountSid,
        authToken: authToken,
        twilioNumber: serviceSid);

    var rnd = new Random();

    var digits = rnd.nextInt(900000) +100000;

    sendotp=digits;
    twiliflutter.sendSMS(toNumber: changephonenumber.text, messageBody: "Hello , This is your verification code : $digits");

  }

  verifycode()
  {
    if(sendotp.toString()==verificaitoncode.text)
      {
        print("SUCCESFULLL");
      }
    else
      {
        print("UNSUCCESFULL");
      }
  }


  Future<void> sendVerificationCode(String phoneNumber) async {
    var twilioFlutter = TwilioFlutter(
        accountSid: accountSid, authToken: authToken, twilioNumber: phoneNumber);

    await twilioFlutter.sendSMS(
        toNumber: phoneNumber,
        messageBody: 'Your verification code is: [CODE]');
  }


}