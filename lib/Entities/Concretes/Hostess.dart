import 'package:mobile_dev/Entities/Abstract/AbstractUser.dart';
import 'package:mobile_dev/Entities/Concretes/Children.dart';

class Hostess extends AbstractUser{
  String? _shuttleKey;
  List<dynamic> _students=[];

  void set shuttleKey(String? shuttleKey){
    this._shuttleKey=shuttleKey;
  }

  String? get shuttleKey{
    return this._shuttleKey;
  }

  void set students(List<dynamic> students){
    this._students=students;
  }

  List<dynamic> get students{
    return this._students;
  }

}