import 'dart:convert';
import 'package:http/http.dart' as http;

enum LoginResult {
  success,
  invalidPhoneNumberOrPassword,
  phoneNumberNotExist,
  error,
}

abstract class AbstractController{
  String? errorMessage="";

  Future<void> sendNotification(String fCMToken, String message) async{


    var data={
      'to' : fCMToken,
      'priority' : 'high',
      'notification' : {
        'title' : 'Kid Cruiser',
        'body' : message,
      }
    };
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'Authorization' : 'key=AAAARt2NEEI:APA91bFZ8y9epSNDxM0308FqhwJrp1fX7_ZLgzMc9fTxytsbUF2N4z-SdGz2iLrdV7XeDqCqmLNey8fajwESWfrq9w3sEC0GT3BU77rWbfPWGUnMJIL_IXRtMDkbvThNSYPXGwHtaGyN',

        }
    );
  }

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

}