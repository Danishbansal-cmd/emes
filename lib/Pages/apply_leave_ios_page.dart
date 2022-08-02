import 'dart:convert';

import 'package:emes/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class ApplyLeaveIosPage extends StatefulWidget {
  const ApplyLeaveIosPage({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveIosPage> createState() => _ApplyLeaveIosPageState();
}

class _ApplyLeaveIosPageState extends State<ApplyLeaveIosPage> {
  //initializing controller
  TextEditingController applyLeaveReasonController = TextEditingController();

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final maxlines = 3;
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Apply Leave"),
        ),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _DatePickerItem(
                  children: <Widget>[
                    Text("From Date"),
                    CupertinoButton(
                      child: Text(
                        '${fromDate.day}/${fromDate.month}/${fromDate.year}',
                        style: const TextStyle(
                          color: CupertinoColors.activeBlue,
                          fontSize: 22.0,
                        ),
                      ),
                      onPressed: () {
                        _showDatePickerDailog(
                          child: CupertinoDatePicker(
                            dateOrder: DatePickerDateOrder.mdy,
                            maximumDate: DateTime(DateTime.now().year,
                                DateTime.now().month + 2, DateTime.now().day),
                            minimumDate: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
                            // This is called when the user changes the date.
                            onDateTimeChanged: (DateTime newDate) {
                              setState(() {
                                fromDate = newDate;
                              });
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
                _DatePickerItem(
                  children: <Widget>[
                    Text("To Date"),
                    CupertinoButton(
                      child: Text(
                        '${toDate.day}/${toDate.month}/${toDate.year}',
                        style: const TextStyle(
                          color: CupertinoColors.activeBlue,
                          fontSize: 22.0,
                        ),
                      ),
                      onPressed: () {
                        _showDatePickerDailog(
                            child: CupertinoDatePicker(
                          dateOrder: DatePickerDateOrder.mdy,
                          maximumDate: DateTime(DateTime.now().year,
                              DateTime.now().month + 2, DateTime.now().day),
                          minimumDate: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          // This is called when the user changes the date.
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              toDate = newDate;
                            });
                          },
                        ));
                      },
                    )
                  ],
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: CupertinoColors.inactiveGray,
                        width: 0.0,
                      ),
                      bottom: BorderSide(
                        color: CupertinoColors.inactiveGray,
                        width: 0.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      height: maxlines * 24.0 + 30,
                      width: double.infinity,
                      child: CupertinoTextField(
                        textInputAction: TextInputAction.done,
                        maxLines: maxlines,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        enableInteractiveSelection: false,
                        controller: applyLeaveReasonController,
                        cursorColor: CupertinoColors.activeOrange,
                        placeholder: "Enter your Reason",
                        suffix: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            applyLeaveReasonController.clear();
                          },
                          child: const Icon(
                            CupertinoIcons.clear_circled_solid,
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          // border: Border.all(
                          //   color: CupertinoColors.lightBackgroundGray,
                          //   width: 2,
                          // ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  width: double.infinity,
                  child: CupertinoButton(
                    child: Text("Apply Leave"),
                    onPressed: () {
                      if (fromDate == toDate) {
                        _showCupertinoAlertDialog(
                          child: const Text("Both dates cannot be same"),
                        );
                      } else if (fromDate.isAfter(toDate)) {
                        _showCupertinoAlertDialog(
                          child:
                              const Text("From date cannot be after to date"),
                        );
                      } else if (applyLeaveReasonController.text.isNotEmpty) {
                        applyLeaveData(
                            (fromDate.day.toString().length == 1
                                    ? "0" + fromDate.day.toString()
                                    : fromDate.day.toString()) +
                                "/" +
                                (fromDate.month.toString().length == 1
                                    ? "0" + fromDate.month.toString()
                                    : fromDate.month.toString()) +
                                "/" +
                                fromDate.year.toString(),
                            (toDate.day.toString().length == 1
                                    ? "0" + toDate.day.toString()
                                    : toDate.day.toString()) +
                                "/" +
                                (toDate.month.toString().length == 1
                                    ? "0" + toDate.month.toString()
                                    : toDate.month.toString()) +
                                "/" +
                                toDate.year.toString(),
                            applyLeaveReasonController.text,
                            context);
                      }
                    },
                    color: CupertinoColors.activeBlue,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePickerDailog({required Widget child}) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(top: false, child: child),
        );
      },
    );
  }

  void _showCupertinoAlertDialog({required Widget child}) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Note"),
          content: child,
          actions: [
            CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future applyLeaveData(
      String value1, String value2, String value3, BuildContext context) async {
    var response = await http.post(
      Uri.parse(Constants.getCompanyURL + "/api/apply_leave"),
      body: {
        "user_id": Constants.getStaffID,
        "on_date": value1,
        "to_date": value2,
        "reason": value3
      },
    );

    var jsonData = jsonDecode(response.body);
    print("ondate $value1");
    print("todate $value2");
    print(Constants.getStaffID);
    print("message ${jsonData['message']}");
    if (jsonData['status'] == 200) {
      _showCupertinoAlertDialog(child: Text(jsonData['message']));
    }
    if (jsonData['status'] == 401) {
      _showCupertinoAlertDialog(child: Text(jsonData['message']));
    }
  }
}

// This class simply decorates a row of widgets.
class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
