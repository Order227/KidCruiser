abstract class AbstractUser {
  String? _name;
  String? _surname;
  String? _phoneNnumber;
  String? _password;

  String? get name{
    return _name;
  }

  set name(String? value) {
    _name = value;
  }

  String? get surname{
    return _surname;
  }

  set surname(String? value){
    _surname = value;
  }

  String? get phoneNumber{
    return _phoneNnumber;
  }

  set phoneNumber(String? value){
    _phoneNnumber = value;
  }

  String? get password{
    return this._password;
  }

  void set password(String? password){
    this._password=password;
  }
}
