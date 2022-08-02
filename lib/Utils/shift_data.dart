import 'dart:convert';
import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShiftData {
  //making into singleton class
  static final ShiftData _shiftData = ShiftData._internal();
  ShiftData._internal();

  factory ShiftData() {
    return _shiftData;
  }
  String _preUrl = '';
  String _nextUrl = '';

  Future<Map<dynamic, dynamic>> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String decodeData = sharedPreferences.getString("data") ?? "";
    var data = jsonDecode(decodeData);
    var response = await http.post(Uri.parse(Constants.getCompanyURL + '/api/getshift'), body: {
      "staff_id": data['id']
    } // need to use Constants.getStaffID in place of "8"
        );
    var jsonData = jsonDecode(response.body);
    Constants.setStaffID(data['id']);
    Map<dynamic, dynamic> data2 = jsonData['data'];
    setPreUrl(data2['preUrl']);
    setNextUrl(data2['nextUrl']);
    return data2;
  }

  Future<Map<dynamic, dynamic>> getPreviousData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String decodeData = sharedPreferences.getString("data") ?? "";
    var data = jsonDecode(decodeData);
    var response = await http.post(Uri.parse(getPreUrl), body: {
      "staff_id": data['id']
    } // need to use Constants.getStaffID in place of "8"
        );
    var jsonData = jsonDecode(response.body);
    Constants.setStaffID(data['id']);
    Map<dynamic, dynamic> data2 = jsonData['data'];
    setPreUrl(data2['preUrl']);
    setNextUrl(data2['nextUrl']);
    return data2;
  }

  Future<Map<dynamic, dynamic>> getNextData() async {
    print("to seee");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String decodeData = sharedPreferences.getString("data") ?? "";
    var data = jsonDecode(decodeData);
    var response = await http.post(Uri.parse(getNextUrl), body: {
      "staff_id": "8"
    } // need to use Constants.getStaffID in place of "8"
        );
    var jsonData = jsonDecode(response.body);
    Constants.setStaffID(data['id']);
    Map<dynamic, dynamic> data2 = jsonData['data'];
    setPreUrl(data2['preUrl']);
    setNextUrl(data2['nextUrl']);
    return data2;
  }

  //
  //setters and getters
  setPreUrl(String value) {
    _preUrl = value;
  }

  setNextUrl(String value) {
    _nextUrl = value;
  }

  get getPreUrl {
    return _preUrl;
  }

  get getNextUrl {
    return _nextUrl;
  }
}
