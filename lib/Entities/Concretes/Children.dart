import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:mobile_dev/Entities/Abstract/AbstractUser.dart';
import 'package:mobile_dev/Entities/Concretes/School.dart';

class Children extends AbstractUser{
  School _school=School();
  String? _shuttleKey;
  String? _hostessName;
  String? _hostessSurName;
  late String _key;
  String? _birthDate;
  String? _state;

  String? _parentPhoneNumber;
// Define a constructor with named parameters
  Children({
    String? name,
    String? surname,
    String? phoneNumber,
    String? password,
    String? hostessName,
    String? shuttleKey,
    String? birthDate,
    String? state,
    String? carPlateNumber,
    String? parentPhoneNumber,
  }) {
    this.name = name;
    this.surname = surname;
    super.phoneNumber = phoneNumber;
    this._hostessName = hostessName;
    this.password = password;
    this.shuttleKey = shuttleKey;
    this.birthDate = birthDate;
    _state = state;

    _parentPhoneNumber = parentPhoneNumber;
  }

  String? get state => _state;

  set state(String? state) => _state = state;


  String hashTcID(String tcKimlikNo) {
    String text=super.name!+super.surname!+tcKimlikNo;
    var bytes = utf8.encode(text); // TC Kimlik Numarasını Byte'a Dönüştür
    var digest = sha256.convert(bytes);  // SHA-256 Hash'ini Hesapla
    return digest.toString();            // Hash'i String Olarak Döndür
  }

  String? get hostessSurName{
    return this._hostessSurName;
  }

  set hostessSurName(String? value) {
    _hostessSurName = value;
  }


  String? get hostessName{
    return this._hostessName;
  }

  set hostessName(String? value) {
    _hostessName = value;
  }

  String? get birthDate{
    return this._birthDate;
  }

  void set birthDate(String? value) {
    _birthDate = value;
  }

  void set key(String key){
    this._key=key;
  }

  String get key{
    return this._key;
  }

  School get school{
    return this._school;
  }

  void set school(School school){
    this._school=school;
  }

  String? get shuttleKey{
    return this._shuttleKey;
  }

  void set shuttleKey(String? shuttleKey){
    this._shuttleKey=shuttleKey;
  }

  String? get parentPhoneNumber{
    return this._parentPhoneNumber;
  }

  set parentPhoneNumber(String? value) {
    _parentPhoneNumber = value;
  }
}