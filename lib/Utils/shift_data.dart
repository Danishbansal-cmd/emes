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
    Map<dynamic, dynamic> data2 = jsonData['data'];
    ShiftData.setCurrentShift(data2['currentShift']);
    ShiftData.setPreUrl(data2['preUrl']);
    ShiftData.setNextUrl(data2['nextUrl']);
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
    Map<dynamic, dynamic> data2 = jsonData['data'];
    ShiftData.setCurrentShift(data2['currentShift']);
    ShiftData.setPreUrl(data2['preUrl']);
    print("preurl ${ShiftData.getPreUrl}");
    ShiftData.setNextUrl(data2['nextUrl']);
    // print("jsonData $jsonData");
    return data2;
  }
  static Future<Map<dynamic, dynamic>> getNextData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String decodeData = sharedPreferences.getString("data") ?? "";
    var data = jsonDecode(decodeData);
    var response = await http.post(Uri.parse(ShiftData.getNextUrl), body: {
      "staff_id": data['id']
    } // need to use Constants.getStaffID in place of "8"
        );
    var jsonData = jsonDecode(response.body);
    Map<dynamic, dynamic> data2 = jsonData['data'];
    ShiftData.setCurrentShift(data2['currentShift']);
    ShiftData.setPreUrl(data2['preUrl']);
    print("nexturl ${ShiftData.getNextUrl}");
    ShiftData.setNextUrl(data2['nextUrl']);
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
