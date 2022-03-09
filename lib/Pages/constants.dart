import 'package:flutter/material.dart';

class Constants {
  static final Constants _constants = Constants._internal();
  Constants._internal();

  static late final String _firstName;
  static late final String _lastName;
  static late final String _email;
  static late final String _staffID;
  static late final Map _data;

  //getters
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
  //setters
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

  factory Constants() {
    return _constants;
  }
}
