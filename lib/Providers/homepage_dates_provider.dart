import 'package:flutter/material.dart';

class HomepageDatesProvider extends ChangeNotifier{
  late String _start_date;
  late String _end_date;
  static final HomepageDatesProvider _homepageDates = HomepageDatesProvider._internal();
  HomepageDatesProvider._internal();
  factory HomepageDatesProvider() {
    return _homepageDates;
  }
  //
  //getters
  get getStartDate{
    return _start_date;
  }get getEndDate{
    return _end_date;
  }
  //
  //setters
  setStartDate(String value){
    _start_date = value;
    notifyListeners();
  }
  setEndDate(String value){
    _end_date = value;
    notifyListeners();
  }
}
