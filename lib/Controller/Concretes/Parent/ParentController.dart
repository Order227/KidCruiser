import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobile_dev/Controller/Abstract/AbstractController.dart';
import 'package:mobile_dev/Controller/Concretes/Input/InputController.dart';
import 'package:mobile_dev/DAOServices/MyFirebase.dart';
import 'package:mobile_dev/Entities/Concretes/Children.dart';
import 'package:mobile_dev/Entities/Concretes/Parent.dart';
import 'package:flutter/cupertino.dart';




class ParentController extends AbstractController {

  MyFirebase myFirebase = MyFirebase();
  static Parent parent = Parent();
  Parent parent_ = parent; // Since static field cannot be accessed from another page, i need to create
  // a non-static Parent object that copy of static Parent object;
  Children children = Children();


  Future<void> updateFCMTokenInDB() async{
    myFirebase.querySnapshot = await FirebaseFirestore.instance.collection('Parents')
        .where('phoneNumber', isEqualTo: parent.phoneNumber)
        .get();

    var docID = myFirebase.querySnapshot.docs.first.id;
    print("parent token ${parent.fCMToken}");
    await FirebaseFirestore.instance.collection('Parents').doc(docID).update({
      'fCMToken': parent.fCMToken});

    myFirebase.querySnapshot = await FirebaseFirestore.instance.collection('Children')
        .where('parent_phone_number', isEqualTo: parent.phoneNumber)
        .get();

    for(var childDoc in myFirebase.querySnapshot.docs){
      var docID = childDoc.id;
      await FirebaseFirestore.instance.collection('Children').doc(docID).update({
        'parent_fCMToken': parent.fCMToken
      });
    }
  }

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
          .collection('Parents')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .where('password', isEqualTo: password)
          .get();

      if (myFirebase.querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data = myFirebase.querySnapshot.docs
            .elementAt(0)
            .data() as Map<String, dynamic>;
        // Assign values from Firestore document data to the fields

        parent.surname = data['surname'];
        parent.name = data['name'];
        parent.password = data['password'];
        parent.phoneNumber = data['phoneNumber'];
        parent.childList = data['child_list'];
        parent.fCMToken = await FirebaseMessaging.instance.getToken();
        updateFCMTokenInDB();
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
      if (await checkExistForRegister( inputController.phoneNumberController.text))
      {
        // Get the values from the text field controllers
        parent.name = inputController.nameController.text;
        parent.surname = inputController.surnameController.text;
        parent.phoneNumber = inputController.phoneNumberController.text;
        parent.password = inputController.passwordController.text;
        parent.fCMToken = await FirebaseMessaging.instance.getToken();
        parent.childList=[];

        // Add the Parent object to Firestore
        await FirebaseFirestore.instance.collection('Parents').add({
          'name': parent.name,
          'surname': parent.surname,
          'phoneNumber': parent.phoneNumber,
          'password': parent.password,
          'child_list': parent.childList,
          'fCMToken': parent.fCMToken,
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

  Future<bool> checkExistForRegister(String phoneNumber) async {
    try {
      myFirebase.querySnapshot = await FirebaseFirestore.instance
          .collection('Parents')
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

  Future<String ?> checkExistPhone(String phoneNumber) async {
    try {
      myFirebase.querySnapshot = await FirebaseFirestore.instance
          .collection('Parents')
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


  Future<String ?> checkExistPassword(String password) async {
    try {
      myFirebase.querySnapshot = await FirebaseFirestore.instance
          .collection('Parents')
          .where('password', isEqualTo: password)
          .get();

      if (myFirebase.querySnapshot.docs.isNotEmpty) {
        return null;
      }

      return "Incorrect Password!";
    } catch (e) {
      // print("Error: $e");
      return "ERROR";
    }
  }

  Future<bool> addChild(InputController inputController, String? selectedSchool,
      FormState formState) async {
    if (formState.validate()) {
      try {
        myFirebase.querySnapshot = await FirebaseFirestore.instance
            .collection('Shuttle')
            .where('shuttle_code',
            isEqualTo: inputController.shuttleCodeController.text)
            .get();
        if (myFirebase.querySnapshot.docs.isEmpty) {
          return false;
        }
        children.name = inputController.nameController.text;
        children.surname = inputController.surnameController.text;
        children.shuttleKey = inputController.shuttleCodeController.text;
        children.school.school_name = selectedSchool;
        children.phoneNumber = parent.phoneNumber;
        children.birthDate = inputController.birthDateController.text;
        children.key = children.hashTcID(inputController.birthDateController.text);

        if(await checkChildExist(children.hashTcID(inputController.birthDateController.text))){
          return false;
        }

        parent.childList.add(children.key);

        addChildToDB(inputController, selectedSchool);
        addChildToParentDB();
        addChildToShuttleDB();
        addChildToHostessDB();

      } catch (e) {
        print("Error: $e");
        return false;
      }

      return true;
    }
    return false;
  }

  Future<bool> checkChildExist(String key) async{
    try{
      myFirebase.querySnapshot = await FirebaseFirestore.instance.collection('Children')
          .where('key', isEqualTo: key).get();
      if(myFirebase.querySnapshot.docs.isEmpty){
        return false;
      }
    }catch (e) {
      print("Error: $e");
      return false;
    }


    return true;
  }

  Future<void> addChildToDB(
      InputController inputController, String? selectedSchool) async {
    await FirebaseFirestore.instance.collection('Children').add({
      'name': inputController.nameController.text,
      'surname': inputController.surnameController.text,
      'shuttleKey': inputController.shuttleCodeController.text,
      'school_name': selectedSchool,
      'parent_phone_number': parent.phoneNumber,
      'birthDate': inputController.birthDateController.text,
      'key': children.key,
      'state': "EVDE",
      'parent_fCMToken': parent.fCMToken,
      'is_active' : false,
    });
  }

  Future<void> addChildToHostessDB() async {
    myFirebase.querySnapshot = await FirebaseFirestore.instance
        .collection('Hostess')
        .where('shuttle_code', isEqualTo: children.shuttleKey)
        .get();

    var docID = myFirebase.querySnapshot.docs.first.id;

    await FirebaseFirestore.instance.collection('Hostess').doc(docID).update({
      'pending_list': FieldValue.arrayUnion([children.key])
    });

  }

  Future<void> addChildToShuttleDB() async {
    myFirebase.querySnapshot = await FirebaseFirestore.instance
        .collection('Shuttle')
        .where('shuttle_code', isEqualTo: children.shuttleKey)
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

    if(schools.contains(children.school.school_name)){
      await FirebaseFirestore.instance.collection('Shuttle').doc(docID)
          .update({
      children.school.school_name!: FieldValue.arrayUnion([children.key]),
      });
    }

    await FirebaseFirestore.instance.collection('Shuttle').doc(docID).update({
      'child_list': FieldValue.arrayUnion([children.key])
    });
  }

  Future<void> addChildToParentDB() async {
    myFirebase.querySnapshot = await FirebaseFirestore.instance
        .collection('Parents')
        .where('phoneNumber', isEqualTo: parent.phoneNumber)
        .get();

    var docID = myFirebase.querySnapshot.docs.first.id;

    await FirebaseFirestore.instance.collection('Parents').doc(docID).update({
      'child_list': FieldValue.arrayUnion([children.key])
    });
  }

  Future<List<Children>> getChildren() async {
    List<Children> childrenList = [];

    List<dynamic> childKeys = parent
        .childList; // parent.childList, parent nesnesinden alınan verilerdir

    for (var element in childKeys) {
      myFirebase.querySnapshot = await FirebaseFirestore.instance
          .collection('Children')
          .where('key', isEqualTo: element)
          .get();

      for (var documentSnapshot in myFirebase.querySnapshot.docs) {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data() as Map<String, dynamic>;

          var child = Children();
          child.name = data['name'];
          child.surname = data['surname'];
          child.birthDate = data['birthDate'];
          child.state = data['state'];
          child.shuttleKey = data['shuttleKey'];
          child.school.school_name = data['schoolName'];
          child.phoneNumber = data['parentPhoneNumber'];
          child.hostessName = await getHostessName(element);
          child.hostessSurName = await getHostessSurName(element);
          bool isActive = data['is_active'];
          if(isActive){
            childrenList.add(child);
          }

        }
      }
    }

    return childrenList;
  }

  Future<String?> getHostessName(String key) async {
    // Replace 'key' with the actual field name in your Firestore document
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Children')
        .where('key', isEqualTo: key)
        .get();

    if (querySnapshot.docs.isNotEmpty) {

      String? shuttleKey = querySnapshot.docs.first['shuttleKey'];

      if (shuttleKey != null) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Hostess')
            .where('shuttle_code', isEqualTo: shuttleKey)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          String? hostessName = querySnapshot.docs.first['name'];
          return hostessName;
        }
      }
    }

    return null; // Return null if the document or field is not found
  }

  Future<String?> getHostessSurName(String key) async {
    // Replace 'key' with the actual field name in your Firestore document
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Children')
        .where('key', isEqualTo: key)
        .get();

    if (querySnapshot.docs.isNotEmpty) {

      String? shuttleKey = querySnapshot.docs.first['shuttleKey'];

      if (shuttleKey != null) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Hostess')
            .where('shuttle_code', isEqualTo: shuttleKey)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          String? hostessSurName = querySnapshot.docs.first['surname'];
          return hostessSurName;
        }
      }
    }

    return null; // Return null if the document or field is not found
  }

  Future<void > updatePhoneNumber(String oldPhoneNumber, String newPhoneNumber) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Parents')
          .where('phoneNumber', isEqualTo: oldPhoneNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return ;
      }

      // Assuming there is only one document with this phone number
      // If there could be multiple, you'll need to decide how to handle that
      var doc = querySnapshot.docs.first;
      await FirebaseFirestore.instance
          .collection('Parents')
          .doc(doc.id)
          .update({'phoneNumber': newPhoneNumber});

      return ;
    } catch (e) {
      // print("Error: $e");
      return ;
    }
  }



}