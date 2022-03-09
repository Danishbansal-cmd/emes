import 'dart:convert';
import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShiftData{
  static late String _currentShift;
  static late String _preUrl;
  static late String _nextUrl;

  static Future<Map<dynamic, dynamic>> getData() async {
    var response = await http.post(
      Uri.parse(Constants.getShiftUrl),body: {"staff_id":"8"} // need to use Constants.getStaffID in place of "8"
    );
    var jsonData = jsonDecode(response.body);
    Map<dynamic, dynamic> data = jsonData['data'];
    ShiftData.setCurrentShift(data['currentShift']);
    ShiftData.setPreUrl(data['preUrl']);
    ShiftData.setNextUrl(data['nextUrl']);
    // print("jsonData $jsonData");
    return data;
  }

  

  //
  //setters
  static setCurrentShift(String value) {
    _currentShift = value;
  }
  static setPreUrl(String value) {
    _preUrl = value;
  }
  static setNextUrl(String value) {
    _nextUrl = value;
  }
  //
  //getters
  static get getCurrentShift {
    return _currentShift;
  }
  static get getPreUrl{
    return _preUrl;
  }
  static get getNextUrl {
    return _nextUrl;
  }
}