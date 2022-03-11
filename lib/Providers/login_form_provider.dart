import 'dart:convert';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Pages/home_page.dart';
import 'package:emes/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormProvider extends ChangeNotifier {
  String _usernameError = "";
  String _passwordError = "";
  String _companyIDError = "";

  get getUsernameError {
    return _usernameError;
  }

  get getPasswordError {
    return _passwordError;
  }

  get getCompanyIDError {
    return _companyIDError;
  }

  setUsernameError(String value) {
    if (value.isEmpty) {
      _usernameError = "*You must enter a value.";
    } else {
      _usernameError = "";
    }
    notifyListeners();
  }

  setPasswordError(String value) {
    if (value.isEmpty) {
      _passwordError = "*You must enter a value.";
    } else {
      _passwordError = "";
    }
    notifyListeners();
  }

  setCompanyIDError(String value) {
    if (value.isEmpty) {
      _companyIDError = "*You must enter a value.";
    } else {
      _companyIDError = "";
    }
    notifyListeners();
  }

  getData(
      String value1, String value2, String value3, BuildContext context) async {
    var response = await http.post(
      Uri.parse('http://trusecurity.emesau.com/dev/api/login'),
      body: {
        "email": value1,
        "password": value2,
        "companyID": value3,
      },
    );
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData = jsonDecode(response.body);
    String sharedData = jsonEncode(jsonData['data']);
    if (jsonData['status'] == 200) {
      print("Signed In Successfully.");
      Constants.setFirstName(jsonData['data']['first_name']);
      Constants.setLastName(jsonData['data']['last_name']);
      Constants.setEmail(jsonData['data']['email']);
      Constants.setStaffID(jsonData['data']['id']);
      Constants.setData(jsonData['data']);
      sharedPreferences.setString("token", jsonData['data']['token']);
      sharedPreferences.setString("staffID",jsonData['data']['id']);
      sharedPreferences.setString("data", sharedData);
      Navigator.pushReplacementNamed(
        context,
        MyRoutes.homePageRoute,
        // arguments: HomePageArguments(
        //     jsonData['data']['first_name'],
        //     jsonData['data']['last_name'],
        //     jsonData['data']['email'],
        //     jsonData['data']['id'],
        //     ),
      );
    }
    if (jsonData['status'] == 401) {
      print("Wrong Username or Password You entered.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wrong Username or Password You entered."),
        ),
      );
    }
    // else{
    //   print("Something Went Wrong.");
    // }
  }

  validateApplyLeave(
      String value1, String value2, String value3, BuildContext context) async {
    setUsernameError(value1);
    setPasswordError(value2);
    setCompanyIDError(value3);
    // if(value1.isEmpty){
    //   setUsernameError("*You must enter a value.");
    // }
    // if(value2.isEmpty){
    //   setPasswordError("*You must enter a value.");
    // }
    // if(value3.isEmpty){
    //   setCompanyIDError("*You must enter a value.");
    // }
    if (value1.isNotEmpty && value2.isNotEmpty && value3.isNotEmpty) {
      getData(value1, value2, value3, context);
    }
  }
}
