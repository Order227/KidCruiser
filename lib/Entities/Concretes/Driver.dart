import 'package:mobile_dev/Entities/Abstract/AbstractUser.dart';

class Driver extends AbstractUser{
  String? _shuttleKey;

  void set shuttleKey(String? shuttleKey){
    this._shuttleKey=shuttleKey;
  }

  String? get shuttleKey{
    return this._shuttleKey;
  }
}