import 'Shuttle.dart';

class School {
  String? _school_name;
  String? _school_id;
  List<Shuttle> _shuttle_list = [];

  String? get school_name{
    return _school_name;
  }

  set school_name(String? value){
    _school_name = value;
  }

  String? get school_id{
    return _school_id;
  }

  set school_id(String? value){
    _school_id = value;
  }

  List<Shuttle> get shuttle_list{
    return _shuttle_list;
  }

  set shuttle_list(List<Shuttle> value){
    _shuttle_list = value;
  }
}
