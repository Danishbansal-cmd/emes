import 'package:flutter/material.dart';

class ApplyLeaveFormProvider extends ChangeNotifier {
  String _fromDateErrorText = "";
  String _toDateErrorText = "";
  String _reasonErrorText = "";

  get getFromDateErrorText {
    return _fromDateErrorText;
  }

  get getToDateErrorText {
    return _toDateErrorText;
  }

  get getReasonErrorText {
    return _reasonErrorText;
  }

  setFromDateErrorText(String value) {
    _fromDateErrorText = value;
    notifyListeners();
  }

  setToDateErrorText(String value) {
    _toDateErrorText = value;
    notifyListeners();
  }

  setReasonErrorText(String value) {
    _reasonErrorText = value;
    notifyListeners();
  }
}
