import 'dart:convert';

import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetLoggedInUserInformation {
  static Future<Map<dynamic,dynamic>> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse('${Constants.getLoggedINUserInformationUrl}/${sharedPreferences.getString("staffID")}')
    );
    var jsonData = jsonDecode(response.body);
    Constants.setFirstName(jsonData['data']['first_name']);
      Constants.setLastName(jsonData['data']['last_name']);
      Constants.setEmail(jsonData['data']['email']);
      Constants.setStaffID(jsonData['data']['id']);
      Constants.setMobile(jsonData['data']['mobile']);
    return jsonData;
  }
}