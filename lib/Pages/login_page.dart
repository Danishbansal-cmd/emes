import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  getData(Map data2) async {
    Map data = {
      "email": "alanseeliger@hotmail.com",
      "password": "111",
      "companyID": "1111"
    };
    var response = await http.post(
        Uri.parse('http://trusecurity.emesau.com/dev/api/login'),
        body: data2);
    var jsonData = jsonDecode(response.body);
    print(jsonData['data']['email']);
    print(jsonData['status']);

    if (jsonData['status'] == 200) {
      print("logged in");
    }
    if (jsonData['status'] == 401) {
      print("Wrong username or password you entered");
    } else {
      print("samaj ni aya pata ni ki hogya");
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late Map test;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.blue],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: Text("some logo"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
