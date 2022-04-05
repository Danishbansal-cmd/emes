import 'dart:convert';

import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AcceptOrDeclineStatus extends ChangeNotifier {
  String _declineReasonErrorText = "";
  String _acceptButtonText = "";
  String _declineButtonText = "";
  //
  //accept Shift function
  acceptShift(List value, Function callback, BuildContext context) async {
    print("am i here");
    if (value.isNotEmpty) {
      print("am i here2");
      http.Response response;
      // ignore: prefer_typing_uninitialized_variables
      var jsonData;
      print("length ${value.length}");
      for (var i = 0; i < value.length; i++) {
        print("i $i");
        print("am i here3");
        await http.post(Uri.parse(Constants.getAcceptShiftUrl),
            body: {"rosterInfo": value[i]}).then((value) {jsonData = jsonDecode(value.body);print("iamvalue ${jsonData}");});
        
        if (jsonData['status'] == 200) {
          print("messsage ${jsonData['message']}");
          // Constants.basicWidget(jsonData['message'], context);
        }
        if (jsonData['status'] == 401) {
          // Constants.basicWidget(jsonData['message'], context);
        }
      }
    }
    if (value.isNotEmpty) {
      print("am i here is called 4");
      // value.clear();
      callback();
    }
  }

  //
  //decline Shift function
  declineShift(List value, String startDate, String endDate, String message,
      Function callback, BuildContext context) async {
    http.Response response;
    // ignore: prefer_typing_uninitialized_variables
    var jsonData;
    for (var i = 0; i < value.length; i++) {
      response = await http.post(
        Uri.parse(Constants.getDeclineShiftUrl),
        body: {
          "sval": jsonEncode(
            {
              "rosterInfo": ["${value[i]}"],
              "start_date": startDate,
              "end_date": endDate,
              "user_id": Constants.getStaffID
            },
          ),
          "sad_message": message,
        },
      );
      jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        // Constants.basicWidget(jsonData['message'], context);
      }
      if (jsonData['status'] == 401) {
        // Constants.basicWidget(jsonData['message'], context);
      }
    }
    if (value.isNotEmpty) {
      print("am i here is called 4");
      callback();
    }
    // Navigator.of(context).pop();
  }

  //
  //getters
  get getDeclineReasonErrorText {
    return _declineReasonErrorText;
  }

  // get getDeclineButtonText {
  //   return _declineButtonText;
  // }

  // get getAcceptButtonText {
  //   return _acceptButtonText;
  // }

  //
  //setters
  setDeclineReasonErrorText(String value) {
    if (value.isEmpty) {
      _declineReasonErrorText = "*You must give a reason.";
    } else {
      _declineReasonErrorText = "";
    }
    notifyListeners();
  }

  // setDeclineButtonText(String value) {
  //   if (value == "2") {
  //     _declineButtonText = "Declined";
  //   } else {
  //     _declineButtonText = "Decline";
  //   }
  //   notifyListeners();
  // }

  // setAcceptButtonText(String value) {
  //   if (value == "1") {
  //     _acceptButtonText = "Accepted";
  //   } else {
  //     _acceptButtonText = "Accept";
  //   }
  //   notifyListeners();
  // }

}
