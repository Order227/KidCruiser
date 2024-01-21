import 'package:mobile_dev/Entities/Abstract/AbstractUser.dart';
import 'Children.dart';

class Parent extends AbstractUser {
  String? _shuttleKey;
  String? _fCMToken;
  List<dynamic> _childList = [];

  Parent(){

  }

  Parent.withParameters(String? name, String? surname, String? password, String? shuttleKey, String? phoneNumber){
    super.name=name;
    super.surname=surname;
    super.password=password;
    super.phoneNumber=phoneNumber;
    this.shuttleKey=shuttleKey;
  }

  // Getter for shuttleKey
  String? get shuttleKey {
    return _shuttleKey;
  }

  // Setter for shuttleKey
  set shuttleKey(String? value) {
    _shuttleKey = value;
  }

  String? get fCMToken {
    return _fCMToken;
  }

  // Setter for shuttleKey
  set fCMToken(String? fCMToken) {
    _fCMToken = fCMToken;
  }

  // Getter for childList
  List<dynamic> get childList {
    return _childList;
  }

  // Setter for childList
  set childList(List<dynamic> value) {
    _childList = value;
  }

  @override
  String toString() {
    return 'Parent { phoneNumber: $phoneNumber, password: $password, surname: $surname, name: $name, shuttleCode: $shuttleKey, childList: $childList }';
  }
}