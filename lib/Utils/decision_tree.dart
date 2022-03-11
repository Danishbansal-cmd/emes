import 'dart:convert';

import 'package:emes/Pages/home_page.dart';
import 'package:emes/Pages/login_page.dart';
import 'package:emes/Routes/routes.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/get_logged_in_information.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DecisionTree extends StatefulWidget {
  const DecisionTree({ Key? key }) : super(key: key);

  @override
  State<DecisionTree> createState() => _DecisionTreeState();
}

class _DecisionTreeState extends State<DecisionTree> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLogInStatus();
  }

  checkLogInStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null){
      Navigator.pushNamed(context, MyRoutes.loginPageRoute);
    }else {
      String decodeData = sharedPreferences.getString("data") ?? "";
      var data = jsonDecode(decodeData);
      // Constants.setFirstName(data['first_name']);
      // Constants.setLastName(data['last_name']);
      // Constants.setEmail(data['email']);
      Constants.setStaffID(data['id']);
      GetLoggedInUserInformation.getData();
      Navigator.pushNamed(context, MyRoutes.homePageRoute);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}