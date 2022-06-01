import 'dart:convert';
import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShiftData {
  static late String _currentShift;
  static late String _preUrl;
  static late String _nextUrl;

  static Future<Map<dynamic, dynamic>> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String decodeData = sharedPreferences.getString("data") ?? "";
    var data = jsonDecode(decodeData);
    var response = await http.post(Uri.parse(Constants.getShiftUrl), body: {
      "staff_id": data['id']
    } // need to use Constants.getStaffID in place of "8"
        );
    var jsonData = jsonDecode(response.body);
    Constants.setStaffID(data['id']);
    Map<dynamic, dynamic> data2 = jsonData['data'];
    ShiftData.setCurrentShift(data2['currentShift']);
    ShiftData.setPreUrl(data2['preUrl']);
    ShiftData.setNextUrl(data2['nextUrl']);
    print("previous Shift ${ShiftData.getPreUrl}");
    print("current Shift ${ShiftData.getCurrentShift}");
    print("next Shift ${ShiftData.getNextUrl}");
    print("break 0000000000000000000000000000");
    // print("nexturl ${ShiftData.getNextUrl}");
    // print("jsonData $jsonData");
    return data2;
  }
  static Future<Map<dynamic, dynamic>> getPreviousData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String decodeData = sharedPreferences.getString("data") ?? "";
    var data = jsonDecode(decodeData);
    var response = await http.post(Uri.parse(ShiftData.getPreUrl), body: {
      "staff_id": data['id']
    } // need to use Constants.getStaffID in place of "8"
        );
    var jsonData = jsonDecode(response.body);
    Constants.setStaffID(data['id']);
    Map<dynamic, dynamic> data2 = jsonData['data'];
    ShiftData.setCurrentShift(data2['currentShift']);
    ShiftData.setPreUrl(data2['preUrl']);
    ShiftData.setNextUrl(data2['nextUrl']);
    print("previous Shift ${ShiftData.getPreUrl}");
    print("current Shift ${ShiftData.getCurrentShift}");
    print("next Shift ${ShiftData.getNextUrl}");
    print("break 111111111111111111111111111111111");
    print("jsonDataofpreviousdata $jsonData");
    return data2;
  }
  static Future<Map<dynamic, dynamic>> getNextData() async {
    print("to seee");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String decodeData = sharedPreferences.getString("data") ?? "";
    var data = jsonDecode(decodeData);
    var response = await http.post(Uri.parse(ShiftData.getNextUrl), body: {
      "staff_id": "8"
    } // need to use Constants.getStaffID in place of "8"
        );
    var jsonData = jsonDecode(response.body);
    Constants.setStaffID(data['id']);
    Map<dynamic, dynamic> data2 = jsonData['data'];
    ShiftData.setCurrentShift(data2['currentShift']);
    ShiftData.setPreUrl(data2['preUrl']);
    ShiftData.setNextUrl(data2['nextUrl']);
    print("previous Shift ${ShiftData.getPreUrl}");
    print("current Shift ${ShiftData.getCurrentShift}");
    print("next Shift ${ShiftData.getNextUrl}");
    print("break 222222222222222222222222222222222222");
    print("jsonDataofnextdata $jsonData");
    // print("jsonData $jsonData");
    return data2;
    
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

  static get getPreUrl {
    return _preUrl;
  }

  static get getNextUrl {
    return _nextUrl;
  }
}
