import 'package:emes/Pages/home_page.dart';
import 'package:emes/Pages/login_page.dart';
import 'package:emes/Routes/routes.dart';
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
      Navigator.pushNamed(context, MyRoutes.homePageRoute);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}