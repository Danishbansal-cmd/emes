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
  acceptShift(String value, BuildContext context) async {
    var response = await http.post(Uri.parse(Constants.getAcceptShiftUrl),
        body: {"rosterInfo": value});
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 200) {
      print("messsage ${jsonData['message']}");
      Constants.basicWidget(jsonData['message'], context);
    }
    if (jsonData['status'] == 401) {
      Constants.basicWidget(jsonData['message'], context);
    }
  }

  //
  //decline Shift function
  declineShift(String shiftId, String workDate, String startDate,
      String endDate, String message, BuildContext context) async {
    var response = await http.post(
      Uri.parse(Constants.getDeclineShiftUrl),
      body: {
        "sval": jsonEncode(
          {
            "rosterInfo": ["$shiftId:$workDate:${Constants.getStaffID}"],
            "start_date": startDate,
            "end_date": endDate,
            "user_id": Constants.getStaffID
          },
        ),
        "sad_message": message,
      },
    );
    var jsonData = jsonDecode(response.body);
    Navigator.of(context).pop();
    if (jsonData['status'] == 200) {
      Constants.basicWidget(jsonData['message'], context);
    }
    if (jsonData['status'] == 401) {
      Constants.basicWidget(jsonData['message'], context);
    }
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

