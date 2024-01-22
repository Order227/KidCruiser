import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_dev/Controller/Abstract/AbstractController.dart';
import 'package:mobile_dev/Controller/Concretes/Input/InputController.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';
import 'package:mobile_dev/DAOServices/MyFirebase.dart';
import 'package:mobile_dev/DAOServices/PushNotificationService.dart';
import 'package:mobile_dev/Entities/Concretes/Children.dart';
import 'package:mobile_dev/Entities/Concretes/Hostess.dart';





class HostessController extends AbstractController{

  static Hostess hostess = Hostess();
  Hostess hostess_ = hostess;
  MyFirebase myFirebase=MyFirebase();
  PushNotificationService pushNotificationService = PushNotificationService();
  Future<LoginResult> logIn(InputController inputController, FormState formState) async {
    if (!formState.validate()) {
      return LoginResult.error;
    }

    var phoneNumber = inputController.phoneNumberController.text;
    var password = inputController.passwordController.text;

    try {
      bool exists = await checkExistForLogIn(phoneNumber, password);
      if (exists) {
        return LoginResult.success;
      } else {
        return LoginResult.phoneNumberNotExist;
      }
    } catch (e) {
      //print("Error: $e");
      return LoginResult.error;
    }
  }

  Future<bool> checkExistForLogIn(String phoneNumber, String password) async {
    try {
      myFirebase.querySnapshot = await FirebaseFirestore.instance
          .collection('Hostess')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .where('password', isEqualTo: password)
          .get();

      if (myFirebase.querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data = myFirebase.querySnapshot.docs
            .elementAt(0)
            .data() as Map<String, dynamic>;
        // Assign values from Firestore document data to the fields

        hostess.surname = data['surname'];
        hostess.name = data['name'];
        hostess.password = data['password'];
        hostess.phoneNumber = data['phoneNumber'];
        hostess.students = data['child_list'];
        hostess.shuttleKey = data['shuttle_code'];
        hostess.selectedSchool = null;
      }

      return myFirebase.querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }


  Future<String?> checkUserExistence(String phoneNumber) async {
    try {
      var exists = await checkExistForRegister(phoneNumber);
      // print(exists);
      if (!exists) {
        // User already exists
        return "This phone number is already in use.";
      }
      return null; // User does not exist, return null
    } catch (e) {
      return "An error occurred during registration.";
    }
  }


  Future<bool> register(InputController inputController, FormState formState) async {
    if (formState.validate())
    {
      if (await checkExistForRegister(inputController.phoneNumberController.text)
        && await checkExistForShuttleCode(inputController.shuttleCodeController.text))
      {
        // Get the values from the text field controllers
        hostess.name = inputController.nameController.text;
        hostess.surname = inputController.surnameController.text;
        hostess.phoneNumber = inputController.phoneNumberController.text;
        hostess.password = inputController.passwordController.text;
        hostess.shuttleKey = inputController.shuttleCodeController.text;

        //DEGISECEK!!!
        myFirebase.querySnapshot = await FirebaseFirestore.instance.collection('Shuttle')
            .where('shuttle_code', isEqualTo: hostess.shuttleKey).get();

        var doc= myFirebase.querySnapshot.docs.first as dynamic;

        List<dynamic> childList = doc.data()['child_list'] as List<dynamic>;

        // Add the Parent object to Firestore
        await FirebaseFirestore.instance.collection('Hostess').add({
          'name': hostess.name,
          'surname': hostess.surname,
          'phoneNumber': hostess.phoneNumber,
          'password': hostess.password,
          'shuttle_code': hostess.shuttleKey,
          'child_list': childList,
          'pending_list' : [],
        });
      }
      else
      {
        print("NUMBER IS BEING USED BY ANOTHER USER");
        return false;
      }
      return true;
    }
    return false;
  }

  Future<String?> checkShuttleKeyExistence(String shuttleKey) async {
    try {
      // Query Firestore for the shuttle key
      var querySnapshot = await FirebaseFirestore.instance.collection('Shuttle')
          .where('shuttle_code', isEqualTo: shuttleKey)
          .get();

      // Check if any documents are returned
      if (querySnapshot.docs.isNotEmpty) {
        return null ; // Shuttle key exists
      } else {
        return "Entered shuttle key is not valid."; // Shuttle key does not exist
      }
    } catch (e) {
    //  print('Error checking shuttle key existence: $e');
      return 'Error checking shuttle key existence: $e'; // Return false in case of any error
    }
  }

  Future<bool> checkExistForRegister(String phoneNumber) async {
    try {
      myFirebase.querySnapshot = await FirebaseFirestore.instance
          .collection('Hostess')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (myFirebase.querySnapshot.docs.isNotEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<List<Children>> getPendingList() async{
    List<Children> pendingList = [];

    var shuttleKey = hostess_.shuttleKey;

    myFirebase.querySnapshot = await FirebaseFirestore.instance
        .collection('Hostess').where(
      'shuttle_code', isEqualTo: shuttleKey,
    ).get();

    var docID = myFirebase.querySnapshot.docs.first.id;

    var document = await FirebaseFirestore.instance
        .collection('Hostess')
        .doc(docID)
        .get();

    var data = document.data() as Map<String, dynamic>;

    List<dynamic> childKeys = [];

    childKeys = List<String>.from(data['pending_list']);

    for (var element in childKeys) {
      myFirebase.querySnapshot = await FirebaseFirestore.instance.collection('Children')
          .where('key', isEqualTo: element)
          .get();

      for (var documentSnapshot in myFirebase.querySnapshot.docs) {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data() as Map<String, dynamic>;

          var child = Children();
          child.key=data['key'];
          child.name = data['name'];
          child.surname = data['surname'];
          child.birthDate = data['birthDate'];
          child.state = data['state'];
          child.shuttleKey = data['shuttleKey'];
          child.school.school_name = data['school_name'];
          child.phoneNumber = data['parent_phone_number'];

          pendingList.add(child);
        }
      }
    }
    return pendingList;

  }

  Future<List<Children>> getChildren() async {
    List<Children> childrenList = [];
    var shuttleKey = hostess_.shuttleKey;

    myFirebase.querySnapshot = await FirebaseFirestore.instance
    .collection('Shuttle').where(
      'shuttle_code', isEqualTo: shuttleKey,
    ).get();

    var docID = myFirebase.querySnapshot.docs.first.id;

    var document = await FirebaseFirestore.instance
        .collection('Shuttle')
        .doc(docID)
        .get();

    var data = document.data() as Map<String, dynamic>;

    List<dynamic> childKeys = [];
    print("SELECTED: ${hostess.selectedSchool}");
    childKeys = List<String>.from(data[hostess.selectedSchool]);


    for (var element in childKeys) {
      myFirebase.querySnapshot = await FirebaseFirestore.instance.collection('Children')
          .where('key', isEqualTo: element)
          .get();

      for (var documentSnapshot in myFirebase.querySnapshot.docs) {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data() as Map<String, dynamic>;

          var child = Children();
          child.key=data['key'];
          child.name = data['name'];
          child.surname = data['surname'];
          child.birthDate = data['birthDate'];
          child.state = data['state'];
          child.shuttleKey = data['shuttleKey'];
          child.school.school_name = data['school_name'];
          child.phoneNumber = data['parent_phone_number'];

          childrenList.add(child);
        }
      }
    }
    return childrenList;
  }

  Future<void> updateChildren(Children children) async{
    myFirebase.querySnapshot= await FirebaseFirestore.instance.collection('Children')
        .where('key', isEqualTo: children.key).get();


    // Check if the document exists
    if (myFirebase.querySnapshot.docs.isNotEmpty) {
      // Get the document ID
      String documentId = myFirebase.querySnapshot.docs.first.id;

      // Update the 'state' field in the document
      await FirebaseFirestore.instance.collection('Children')
          .doc(documentId)
          .update({'state': children.state});

      var data = myFirebase.querySnapshot.docs.first;

      String fCMToken = data['parent_fCMToken'];

      sendNotification(fCMToken, "${children.name} ${children.surname}'s state is: ${children.state}");
    } else {
      print('No document found with the given key');
    }


  }

  void setSelectedSchoold(String? selectedSchool) {
    hostess.selectedSchool=selectedSchool;
  }

  Future<bool> checkExistForShuttleCode(String shuttleCode) async{
    myFirebase.querySnapshot = await FirebaseFirestore.instance
        .collection('Hostess')
        .where(
      'shuttle_code', isEqualTo: shuttleCode,
    ).get();

    if(myFirebase.querySnapshot.docs.isEmpty){
      return true;
    }

    return false;
  }

  Future<void> confirmChild(Children child) async{
    myFirebase.querySnapshot = await FirebaseFirestore.instance.collection('Children')
        .where(
      'key', isEqualTo: child.key,
    ).get();

    String documentId = myFirebase.querySnapshot.docs.first.id;

    // Update the 'state' field in the document
    await FirebaseFirestore.instance.collection('Children')
        .doc(documentId)
        .update({'is_active': true});


    myFirebase.querySnapshot = await FirebaseFirestore.instance
        .collection('Shuttle')
        .where('shuttle_code', isEqualTo: child.shuttleKey)
        .get();

    var docID = myFirebase.querySnapshot.docs.first.id;

    var document = await FirebaseFirestore.instance
        .collection('Shuttle')
        .doc(docID)
        .get();

// Retrieve the 'schools' field as a List<String>
    List<String> schools = [];
    if (document.exists && document.data() != null) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('schools') && data['schools'] is List) {
        schools = List<String>.from(data['schools']);
      }
    }
    print("school name: ${child.school.school_name}");
    if(schools.contains(child.school.school_name)){
      await FirebaseFirestore.instance.collection('Shuttle').doc(docID)
          .update({
        child.school.school_name!: FieldValue.arrayUnion([child.key]),
      });
    }

    await FirebaseFirestore.instance.collection('Shuttle').doc(docID).update({
      'child_list': FieldValue.arrayUnion([child.key])
    });


    myFirebase.querySnapshot = await FirebaseFirestore.instance
    .collection('Hostess').where(
      'shuttle_code', isEqualTo: child.shuttleKey,
    ).get();

    docID = myFirebase.querySnapshot.docs.first.id;

    await FirebaseFirestore.instance.collection('Hostess').doc(docID).update({
      'child_list': FieldValue.arrayUnion([child.key])
    });

    List<dynamic> pendingList = myFirebase.querySnapshot.docs.first['pending_list'];

    // Remove the child key from the 'pending_list'
    pendingList.remove(child.key);

    // Update the 'pending_list' array in the 'Hostess' document
    await FirebaseFirestore.instance.collection('Hostess')
        .doc(docID)
        .update({'pending_list': pendingList});




  }

  Future<void> rejectChild(Children child) async{

    var fCMToken = myFirebase.querySnapshot.docs.first['parent_fCMToken'];
    String message = "${child.name} ${child.surname} isn't added to shuttle!";

    print("FCM,TOKEN: ${fCMToken}");

    sendNotification(fCMToken, message);

    myFirebase.querySnapshot = await FirebaseFirestore.instance.collection('Children')
        .where(
      'key', isEqualTo: child.key,
    ).get();

    String documentId = myFirebase.querySnapshot.docs.first.id;
    bool isActive = myFirebase.querySnapshot.docs.first['is_active'];
    // Update the 'state' field in the document

    if(isActive){
      return;
    }

    await FirebaseFirestore.instance.collection('Children')
        .doc(documentId).delete();

    myFirebase.querySnapshot = await FirebaseFirestore.instance
    .collection('Hostess')
    .where(
      'shuttle_code', isEqualTo: child.shuttleKey,
    ).get();

    String hostessDocumentId = myFirebase.querySnapshot.docs.first.id;

    // Get the current 'pending_list' array
    List<dynamic> pendingList = myFirebase.querySnapshot.docs.first['pending_list'];

    // Remove the child key from the 'pending_list'
    pendingList.remove(child.key);

    // Update the 'pending_list' array in the 'Hostess' document
    await FirebaseFirestore.instance.collection('Hostess')
        .doc(hostessDocumentId)
        .update({'pending_list': pendingList});


    myFirebase.querySnapshot = await FirebaseFirestore.instance.collection('Children')
        .where(
      'key', isEqualTo: child.key,
    ).get();




  }

  Future<String ?> checkExistPhone(String phoneNumber) async {
    try {
      myFirebase.querySnapshot = await FirebaseFirestore.instance
          .collection('Hostess')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (myFirebase.querySnapshot.docs.isNotEmpty) {
        return null;
      }

      return "Phone number doesn't exist";
    } catch (e) {
      // print("Error: $e");
      return "ERROR";
    }
  }


  Future<String ?> checkExistPassword(String password,String name,String surname) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Hostess')
          .where('name', isEqualTo: name)
          .where('surname', isEqualTo: surname)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return null;
      }

      return "Incorrect Password!";
    } catch (e) {
      // print("Error: $e");
      return "ERROR";
    }
  }


  Future<void > updatePhoneNumber(String oldPhoneNumber, String newPhoneNumber) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Hostess')
          .where('phoneNumber', isEqualTo: oldPhoneNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return ;
      }

      // Assuming there is only one document with this phone number
      // If there could be multiple, you'll need to decide how to handle that
      var doc = querySnapshot.docs.first;
      await FirebaseFirestore.instance
          .collection('Hostess')
          .doc(doc.id)
          .update({'phoneNumber': newPhoneNumber});

      return ;
    } catch (e) {
      // print("Error: $e");
      return ;
    }
  }


  Future<void > updatePassword(String oldPassword, String newPassword,String name,String surname) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Hostess')
          .where('surname', isEqualTo: surname)
          .where('name', isEqualTo: name)
          .where('password', isEqualTo: oldPassword)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return ;
      }

      // Assuming there is only one document with this phone number
      // If there could be multiple, you'll need to decide how to handle that
      print("CONTROLL");
      var doc = querySnapshot.docs.first;
      await FirebaseFirestore.instance
          .collection('Hostess')
          .doc(doc.id)
          .update({'password': newPassword});

      return ;
    } catch (e) {
      // print("Error: $e");
      return ;
    }
  }

    Future<bool> canFinishcruise(  List<Children> childrenList) async
    {
      try
      {
        bool check=false;

        childrenList.forEach((element){
          print(element.state);
          if (element.state=="YOLDA")
            check=true;
        });
        return check;
      }
      catch(e)
      {
        return false;
      }
      return false;
    }

}