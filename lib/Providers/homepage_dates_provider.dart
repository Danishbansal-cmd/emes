import 'package:flutter/material.dart';

class HomepageDatesProvider extends ChangeNotifier{
  String _start_date = "";
  String _end_date = "";
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
  setStartDate2(String value){
    _start_date = value;
  }
  setEndDate2(String value){
    _end_date = value;
  }

  //
  //builders
  buildStartDate(){
    _start_date = getStartDate();
    notifyListeners();
  }
  buildEndDate(){
    _end_date = getEndDate();
    notifyListeners();
  }
}
