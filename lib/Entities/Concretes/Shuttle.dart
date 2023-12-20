import 'package:mobile_dev/Entities/Concretes/Driver.dart';
import 'package:mobile_dev/Pages/Register/HostessRegisterPage.dart';

import 'Hostess.dart';

class Shuttle{
  String? plate_number;
  String? school_id;
  late Driver driver;
  late Hostess hostess;

  Shuttle(){
    this.plate_number="";
  }
}