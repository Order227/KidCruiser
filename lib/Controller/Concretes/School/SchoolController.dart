import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_dev/Controller/Abstract/AbstractController.dart';
import 'package:mobile_dev/DAOServices/MyFirebase.dart';

class SchoolController extends AbstractController{
  List<String> _schoolList = [];
  MyFirebase myFirebase = MyFirebase();

  List<String> get schoolList{
    return this._schoolList;
  }

  Future<List<String>> getListFromDB() async {
    try {
      myFirebase.querySnapshot =
      await FirebaseFirestore.instance.collection('School').get();
      this._schoolList = myFirebase.querySnapshot.docs
          .map((doc) => doc.get('school_name') as String)
          .toList();
      print("SCHOOLS1: " + this._schoolList.toString());
    } catch (e) {
      print('Error fetching school list: $e');
    }

    return this._schoolList;
  }


}
