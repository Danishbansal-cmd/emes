import 'package:flutter/material.dart';

class SignupFormProvider extends ChangeNotifier {
  String _firstNameError = "";
  String _lastNameError = "";
  String _mobileError = "";
  String _emailError = "";
  String _companyIDError = "";
  bool _mobileErrorBool = false,
      _emailErrorBool = false,
      _companyIDErrorBool = false;

  //
  //getters
  get getFirstNameError {
    return _firstNameError;
  }

  get getLastNameError {
    return _lastNameError;
  }

  get getMobileError {
    return _mobileError;
  }

  get getEmailError {
    return _emailError;
  }

  get getCompanyIDError {
    return _companyIDError;
  }

  get getMobileErrorBool {
    return _mobileErrorBool;
  }

  get getEmailErrorBool {
    return _emailErrorBool;
  }

  get getCompanyIDErrorBool {
    return _companyIDErrorBool;
  }

  //
  //setters
  setFirstNameError(String value) {
    if (value.isEmpty) {
      _firstNameError = "*You must enter a value.";
    } else {
      _firstNameError = "";
    }
    notifyListeners();
  }

  setLastNameError(String value) {
    if (value.isEmpty) {
      _lastNameError = "*You must enter a value.";
    } else {
      _lastNameError = "";
    }
    notifyListeners();
  }

  setMobileError(String value) {
    if (value.isEmpty) {
      _mobileError = "*You must enter a value.";
      _mobileErrorBool = true;
    } else {
      _mobileError = "";
    }
    notifyListeners();
  }

  setEmailError(String value) {
    if (value.isEmpty) {
      _emailError = "*You must enter a value.";
      _emailErrorBool = true;
    } else {
      _emailError = "";
    }
    notifyListeners();
  }

  setCompanyIDError(String value) {
    if (value.isEmpty) {
      _companyIDError = "*You must enter a value.";
      _companyIDErrorBool = true;
    } else {
      _companyIDError = "";
    }
    notifyListeners();
  }

  validateSignUpForm(String value1, String value2, String value3, String value4,
      String value5, BuildContext context) async {
    setFirstNameError(value1);
    setLastNameError(value2);
    setMobileError(value3);
    setEmailError(value4);
    setCompanyIDError(value5);
    if (value1.isNotEmpty &&
        value2.isNotEmpty &&
        getMobileErrorBool == false &&
        getEmailErrorBool == false &&
        getCompanyIDErrorBool == false) {
      getData(value1, value2, value3, value4, value5, context);
    }
  }

  getData(String value1, String value2, String value3, String value4,
      String value5, BuildContext context) {
        
      }
}
