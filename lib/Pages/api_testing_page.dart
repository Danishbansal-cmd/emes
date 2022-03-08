import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TestingApi extends StatelessWidget {
  TestingApi({ Key? key }) : super(key: key);

  
  void prettyPrintJson(String input) {
  const JsonDecoder decoder = JsonDecoder();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final dynamic object = decoder.convert(input);
  final dynamic prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((dynamic element) => print(element));
}

  getData() async {
    Map data = {
      "email":"alanseeliger@hotmail.com",
      "password":"11d1",
      "companyID":"1111"
    };
    var response = await http.post(Uri.parse('http://trusecurity.emesau.com/dev/api/login'),body: data);
    var jsonData = jsonDecode(response.body);
    // prettyPrintJson(jsonData);
    print(jsonData);
    print("${jsonData['data']['setting']['APPNAME']}");
    if(jsonData['status'] == 200){
      jsonData['data'];
      print("logged in");
    }
    else{
      print("samaj ni aya pata ni ki hogya");
    }
    // print("response ${response.body}");
    // print("jsondata $jsonData");
  }


  @override
  Widget build(BuildContext context) {
    print("api testing");
    getData();
    return Container(
      
    );
  }
}

// some string or url needed to store
// http://trusecurity.emesau.com/dev