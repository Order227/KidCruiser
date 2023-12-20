import 'package:flutter/cupertino.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';
import 'package:mobile_dev/Entities/Concretes/Children.dart';

class ChildrenProvider with ChangeNotifier {
  List<Children> _childrenList = [];
  ParentController parentController=ParentController();
  List<Children> get childrenList => _childrenList;

  Future<void> fetchChildren() async {
    this._childrenList=parentController.getChildren() as List<Children>;
    notifyListeners();
  }
}
