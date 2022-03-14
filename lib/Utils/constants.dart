import 'package:flutter/material.dart';

class Constants {
  // static final Constants _constants = Constants._internal();
  // Constants._internal();

  static late String _firstName;
  static late String _lastName;
  static late String _email;
  static late String _mobile;
  static late String _staffID;
  static late Map _dataLogIN;
  static const String _shiftUrl =
      "http://trusecurity.emesau.com/dev/api/getshift";
  static const String _updateProfileUrl =
      "http://trusecurity.emesau.com/dev/api/update_profile";
  static const String _loggedINUserInformationUrl =
      "http://trusecurity.emesau.com/dev/api/get_loggedInUser";
  static const String _appliedLeavesUrl =
      "http://trusecurity.emesau.com/dev/api/get_applied_leave";

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
    _dataLogIN = value;
  }

  static setMobile(String value) {
    _mobile = value;
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
    return _dataLogIN;
  }

  static get getMobile {
    return _mobile;
  }

  static get getShiftUrl {
    return _shiftUrl;
  }

  static get getUpdateProfileUrl {
    return _updateProfileUrl;
  }

  static get getLoggedINUserInformationUrl {
    return _loggedINUserInformationUrl;
  }

  static get getAppliedLeavesUrl {
    return _appliedLeavesUrl;
  }

  // factory Constants() {
  //   return _constants;
  // }

  //
  //Day of Shifts

  static String nameOfDayOfShift(String value) {
    if (value == "1") {
      return "Monday";
    } else if (value == "2") {
      return "Tuesday";
    } else if (value == "3") {
      return "Wednesday";
    } else if (value == "4") {
      return "Thursday";
    } else if (value == "5") {
      return "Friday";
    } else if (value == "6") {
      return "Saturday";
    } else if (value == "0") {
      return "Sunday";
    }
    return "Error";
  }
}
