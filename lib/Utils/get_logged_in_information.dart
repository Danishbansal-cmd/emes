import 'dart:convert';
import 'package:emes/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetLoggedInUserInformation {
  static Future<List<String>> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(
        '${Constants.getCompanyURL}/api/get_loggedInUser/${sharedPreferences.getString("staffID")}'));
    var jsonData = jsonDecode(response.body);
    Constants.setFirstName(jsonData['data']['first_name']);
    Constants.setLastName(jsonData['data']['last_name']);
    Constants.setEmail(jsonData['data']['email']);
    Constants.setMobile(jsonData['data']['mobile']);
    if (jsonData["status"] == 200) {
      return [
        jsonData['data']['first_name'],
        jsonData['data']['last_name'],
        jsonData['data']['mobile'],
        jsonData['data']['email']
      ];
    }
    return [];
  }
}
