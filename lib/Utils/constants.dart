import 'package:emes/Providers/accept_decline_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Constants {
  // static final Constants _constants = Constants._internal();
  // Constants._internal();

  static late String _firstName;
  static late String _lastName;
  static late String _email;
  static late String _mobile;
  static late String _staffID;
  static late Map _dataLogIN;
  static const String _shiftUrl =
      "http://trusecurity.emesau.com/dev/api/getshift";
  static const String _updateProfileUrl =
      "http://trusecurity.emesau.com/dev/api/update_profile";
  static const String _loggedINUserInformationUrl =
      "http://trusecurity.emesau.com/dev/api/get_loggedInUser";
  static const String _appliedLeavesUrl =
      "http://trusecurity.emesau.com/dev/api/get_applied_leave";
  static const String _applyLeaveUrl =
      "http://trusecurity.emesau.com/dev/api/apply_leave";
  static String _acceptShiftUrl =
      "http://trusecurity.emesau.com/dev/api/confirm_roster";
  static String _declineShiftUrl =
      "http://trusecurity.emesau.com/dev/api/decline_roster";
  static String _inboxPageUrl =
      "http://trusecurity.emesau.com/dev/api/get_new_message_noti/";

  //
  //setters
  static setFirstName(String value) {
    _firstName = value;
  }

  static setLastName(String value) {
    _lastName = value;
  }

  static setEmail(String value) {
    _email = value;
  }

  static setStaffID(String value) {
    _staffID = value;
  }

  static setData(Map value) {
    _dataLogIN = value;
  }

  static setMobile(String value) {
    _mobile = value;
  }

  //
  //getters
  static get getFirstName {
    return _firstName;
  }

  static get getLastName {
    return _lastName;
  }

  static get getStaffID {
    return _staffID;
  }

  static get getEmail {
    return _email;
  }

  static get getData {
    return _dataLogIN;
  }

  static get getMobile {
    return _mobile;
  }

  static get getShiftUrl {
    return _shiftUrl;
  }

  static get getUpdateProfileUrl {
    return _updateProfileUrl;
  }

  static get getLoggedINUserInformationUrl {
    return _loggedINUserInformationUrl;
  }

  static get getAppliedLeavesUrl {
    return _appliedLeavesUrl;
  }

  static get getApplyLeaveUrl {
    return _applyLeaveUrl;
  }

  static get getAcceptShiftUrl {
    return _acceptShiftUrl;
  }

  static get getDeclineShiftUrl {
    return _declineShiftUrl;
  }

  static get getInboxPageUrl {
    return _inboxPageUrl;
  }

  // factory Constants() {
  //   return _constants;
  // }

  //
  //Day of Shifts

  static String nameOfDayOfShift(String value) {
    if (value == "1") {
      return "Monday".substring(0,3);
    } else if (value == "2") {
      return "Tuesday".substring(0,3);
    } else if (value == "3") {
      return "Wednesday".substring(0,3);
    } else if (value == "4") {
      return "Thursday".substring(0,3);
    } else if (value == "5") {
      return "Friday".substring(0,3);
    } else if (value == "6") {
      return "Saturday".substring(0,3);
    } else if (value == "0") {
      return "Sunday".substring(0,3);
    }
    return "Error";
  }

  static Widget indicatorTracker(Color color, double value) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 4),
              height: 30,
              width: 7,
              color: color,
            ),
          ],
        ),
        Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                  maxHeight: 15, minHeight: 15, minWidth: 15, maxWidth: 15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(
              height: value.toDouble(),
            ),
            Container(
              constraints: const BoxConstraints(
                  maxHeight: 15, minHeight: 15, minWidth: 15, maxWidth: 15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Future basicWidget(String value, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(
            milliseconds: 1200,
          ),
          () {
            Navigator.of(context).pop(true);
          },
        );
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.primary,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
