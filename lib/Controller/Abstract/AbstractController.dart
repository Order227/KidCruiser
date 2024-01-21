import 'package:twilio_flutter/twilio_flutter.dart';

enum LoginResult {
  success,
  invalidPhoneNumberOrPassword,
  phoneNumberNotExist,
  error,
}

abstract class AbstractController{
  String? errorMessage="";

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Name must contain only letters';
    }
    return null;
  }

  String? validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Surname cannot be empty';
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Surname must contain only letters';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (!RegExp(r'^05\d{9}$').hasMatch(value)) {
      return '0-(5xx)-xxx-xxxx';
    }
    return null;
  }


  String? validateShuttleKey(String? value) {
    if (value == null || value.isEmpty) {
      return 'Shuttle key cannot be empty';
    }
    // Add additional pattern matching if your shuttle key has a specific format
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$').hasMatch(value)) {
      return 'At least one lowercase, one \nuppercase letter and one number is required';
    }
    return null;
  }

  Future<void> sendVerificationCode(String phoneNumber, String verificationCode) async {
    TwilioFlutter twilioFlutter=TwilioFlutter(accountSid: 'ACd90a8ccf53f8f61aaf80b18be4a81ef9', authToken: '25c4a583009bf2a6f789fe45cae7f2ed', twilioNumber: '+12019037039');
    try {
      await twilioFlutter.sendSMS(
        toNumber: phoneNumber,
        messageBody: 'Your verification code is: $verificationCode',
      );
      print('SMS sent successfully');
    } catch (e) {
      print('Error sending SMS: $e');
    }
  }


}