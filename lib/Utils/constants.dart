import 'package:flutter/material.dart';

class Constants {
  static final Constants _constants = Constants._internal();
  Constants._internal();

  static late final String _firstName;
  static late final String _lastName;
  static late final String _email;
  static late final String _staffID;
  static late final Map _data;
  static final String _shiftUrl = "http://trusecurity.emesau.com/dev/api/getshift";
  
  //
  //setters
  static setFirstName(String value) {
    _firstName = value;
  }

  static setLastName(String value) {
    _lastName = value;
  }

  static setEmail(String value) {
    _email = value;
  }

  static setStaffID(String value) {
    _staffID = value;
  }

  static setData(Map value) {
    _data = value;
  }


  

  //
  //getters
  static get getFirstName {
    return _firstName;
  }

  static get getLastName {
    return _lastName;
  }

  static get getStaffID {
    return _staffID;
  }

  static get getEmail {
    return _email;
  }

  static get getData {
    return _data;
  }

  static get getShiftUrl {
    return _shiftUrl;
  }

  factory Constants() {
    return _constants;
  }
}
