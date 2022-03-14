import 'dart:convert';

import 'package:emes/Utils/constants.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApplyLeavePage extends StatelessWidget {
  ApplyLeavePage({Key? key}) : super(key: key);

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    // final applyLeaveFormProvider = Provider.of<ApplyLeaveFormProvider>(context);
    // final openLeaveBarProvider = Provider.of<OpenLeaveBarProvider>(context);
    // bool arrowOpenButton = false;
    // int testingIndex;
    print(
        "How many times does i run \n ///////////////////\n/////////////////\n ///////////////////\n ///////////////////");

    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: const Text("My Leave"),
        actions: [
          InkWell(
            onTap: () {
              // applyLeaveFormProvider.setFromDateErrorText("");
              // applyLeaveFormProvider.setToDateErrorText("");
              // applyLeaveFormProvider.setReasonErrorText("");
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: [
                          NotificationListener<OverscrollIndicatorNotification>(
                            onNotification:
                                (OverscrollIndicatorNotification overScroll) {
                              overScroll.disallowGlow();
                              return true;
                            },
                            child: SingleChildScrollView(
                              child: Container(
                                // width: MediaQuery.of(context).size.width,
                                height: 420,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20)
                                    .copyWith(top: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //
                                    //
                                    //Apply Leave Form First's Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Apply Leave",
                                          style: _textTheme.headline1,
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            splashColor: Colors.grey,
                                            onTap: () {
                                              // Future.delayed(Duration(seconds: 2));
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                // color: Colors.amber,
                                              ),
                                              width: 35,
                                              height: 35,
                                              child: const Icon(
                                                Icons.close_rounded,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //
                                    //
                                    //From Date Field
                                    const Text("From Date"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: TextField(
                                          controller: fromDateController,
                                          decoration: const InputDecoration(
                                            // labelText: "hello 1",
                                            hintText: "Select From Date",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Consumer<ApplyLeaveFormProvider>(
                                      builder: (context,
                                          appLevelApplyLeaveFormProvider, _) {
                                        return Text(
                                          appLevelApplyLeaveFormProvider
                                              .getFromDateErrorText,
                                          style: _textTheme.headline6,
                                        );
                                      },
                                    ),
                                    //
                                    //
                                    //To Date Field
                                    const Text("To Date"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      child: Center(
                                        child: TextField(
                                          controller: toDateController,
                                          decoration: const InputDecoration(
                                            // labelText: "hello 1",
                                            hintText: "Select To Date",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Consumer<ApplyLeaveFormProvider>(
                                      builder: (context,
                                          appLevelApplyLeaveFormProvider, _) {
                                        return Text(
                                          appLevelApplyLeaveFormProvider
                                              .getToDateErrorText,
                                          style: _textTheme.headline6,
                                        );
                                      },
                                    ),
                                    //
                                    //
                                    //Reason Field
                                    const Text("Reason"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 100,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      child: TextField(
                                        controller: reasonController,
                                        decoration: const InputDecoration(
                                          // labelText: "hello 1",
                                          hintText: "Type Reason Here...",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Consumer<ApplyLeaveFormProvider>(
                                      builder: (context,
                                          appLevelApplyLeaveFormProvider, _) {
                                        return Text(
                                          appLevelApplyLeaveFormProvider
                                              .getReasonErrorText,
                                          style: _textTheme.headline6,
                                        );
                                      },
                                    ),
                                    //
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //
                                    // Apply Leave Button
                                    Consumer<ApplyLeaveFormProvider>(
                                      builder: (context, applyLeaveFormProvider,
                                          child) {
                                        return Material(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: InkWell(
                                            // splashColor: Colors.white,
                                            onTap: () {
                                              // RegExp calenderDate = RegExp(
                                              //     r'^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$');
                                              // //
                                              // //conditions for fromDateController
                                              // if (fromDateController
                                              //     .text.isEmpty) {
                                              //   applyLeaveFormProvider
                                              //       .setFromDateErrorText(
                                              //           "*You must select a value.");
                                              // } else if (!calenderDate.hasMatch(
                                              //     fromDateController.text)) {
                                              //   applyLeaveFormProvider
                                              //       .setFromDateErrorText(
                                              //           "*Selected Date should be after current date.");
                                              // }
                                              // //
                                              // //conditions for toDateController
                                              // if (toDateController
                                              //     .text.isEmpty) {
                                              //   applyLeaveFormProvider
                                              //       .setToDateErrorText(
                                              //           "*You must select a value.");
                                              // } else if (!calenderDate.hasMatch(
                                              //     toDateController.text)) {
                                              //   applyLeaveFormProvider
                                              //       .setToDateErrorText(
                                              //           "*Selected Date should be before date 06/06/2022.");
                                              // }
                                              // //
                                              // //conditions for reasonController
                                              // if (reasonController
                                              //     .text.isEmpty) {
                                              //   applyLeaveFormProvider
                                              //       .setReasonErrorText(
                                              //           "*You must select a value.");
                                              // }
                                              applyLeaveFormProvider
                                                  .validateApplyLeaveFormData(
                                                      fromDateController.text,
                                                      toDateController.text,
                                                      reasonController.text);
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 35,
                                              child: const Center(
                                                child: Text(
                                                  "Apply Leave",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              width: 60,
              child: Center(child: Icon(Icons.add_circle_outline_outlined)),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 5),
          child: FutureBuilder(
              future: AppliedLeavesProvider.getAppliedLeaves(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occured',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final appliedLeavesData = snapshot.data as List;

                    return appliedLeavesData.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 90,
                                color: Colors.blue,
                              ),
                              const Text("No Leaves Found"),
                              Text(snapshot.data['message']),
                            ],
                          )
                        : NotificationListener<OverscrollIndicatorNotification>(
                          onNotification: (OverscrollIndicatorNotification overScroll){
                            overScroll.disallowGlow();
                            return true;
                          },
                          child: ListView.separated(
                              itemCount: appliedLeavesData.length,
                              itemBuilder: (context, index) {
                                return Consumer<OpenLeaveBarProvider>(
                                  builder: (context, openLeaveBarProvider, _) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                      ),
                                      height: (openLeaveBarProvider.boolValue &&
                                              openLeaveBarProvider
                                                      .intTestingIndex ==
                                                  index)
                                          ? 100
                                          : 50,
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            color: Colors.red,
                                            height: 50,
                                            child: Column(children: [
                                              Text(appliedLeavesData[index][
                                                                  'ApplyForHoliday']
                                                              ['on_date']),
                                                              const SizedBox(height: 5,),
                                                              Text(appliedLeavesData[index][
                                                                  'ApplyForHoliday']
                                                              ['to_date'])
                                            ],),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                height: 30,
                                                child: Center(
                                                  child: Text(
                                                    appliedLeavesData[index][
                                                                  'ApplyForHoliday']
                                                              ['status'] ==
                                                          "0"
                                                      ? "Pending"
                                                      : appliedLeavesData[index][
                                                                      'ApplyForHoliday']
                                                                  ['status'] ==
                                                              "1"
                                                          ? "Accepted"
                                                          : "Decline",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: appliedLeavesData[index][
                                                                  'ApplyForHoliday']
                                                              ['status'] ==
                                                          "0"
                                                      ? Colors.amber
                                                      : appliedLeavesData[index][
                                                                      'ApplyForHoliday']
                                                                  ['status'] ==
                                                              "1"
                                                          ? Colors.green
                                                          : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                splashColor: Colors.blue,
                                                onTap: () {
                                                  openLeaveBarProvider
                                                      .setBoolValueToggle(index);
                                                  openLeaveBarProvider
                                                      .setTestingIndex(index);
                                                },
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: (openLeaveBarProvider
                                                              .boolValue &&
                                                          openLeaveBarProvider
                                                                  .intTestingIndex ==
                                                              index)
                                                      ? const Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          size: 24,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          size: 16,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                        );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}

class ApplyLeaveFormProvider extends ChangeNotifier {
  String _fromDateErrorText = "";
  bool _fromDateErrorBool = false;
  String _toDateErrorText = "";
  bool _toDateErrorBool = false;
  String _reasonErrorText = "";

  get getFromDateErrorText {
    return _fromDateErrorText;
  }

  get getToDateErrorText {
    return _toDateErrorText;
  }

  get getReasonErrorText {
    return _reasonErrorText;
  }

  setFromDateErrorText(String value) {
    RegExp calenderDate = RegExp(
        r'^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$');

    if (value.isEmpty) {
      _fromDateErrorText = "*You must select a value.";
      _fromDateErrorBool = true;
    } else if (!calenderDate.hasMatch(value)) {
      _fromDateErrorText = "*Selected Date should be after current date.";
      _fromDateErrorBool = true;
    } else {
      _fromDateErrorText = "";
      _fromDateErrorBool = false;
    }
    notifyListeners();
  }

  setToDateErrorText(String value) {
    RegExp calenderDate = RegExp(
        r'^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$');
    if (value.isEmpty) {
      _toDateErrorText = "*You must select a value.";
      _toDateErrorBool = true;
    } else if (!calenderDate.hasMatch(value)) {
      _toDateErrorText = "*Selected Date should be before date 06/06/2022.";
      _toDateErrorBool = true;
    } else {
      _toDateErrorText = "";
      _toDateErrorBool = false;
    }
    notifyListeners();
  }

  setReasonErrorText(String value) {
    if (value.isEmpty) {
      _reasonErrorText = "*You must select a value.";
    } else {
      _reasonErrorText = "";
    }
    notifyListeners();
  }

  validateApplyLeaveFormData(String value1, String value2, String value3) {
    setFromDateErrorText(value1);
    setToDateErrorText(value2);
    setReasonErrorText(value3);

    // if(value1.isNotEmpty && )
  }
}

class OpenLeaveBarProvider extends ChangeNotifier {
  bool _value = false;
  late int _testingIndex = 0;

  get boolValue {
    return _value;
  }

  get intTestingIndex {
    return _testingIndex;
  }

  setBoolValueToggle(int value) {
    if (_testingIndex == value && _value == true) {
      _value = false;
      print("does i work or not");
    } else if (_testingIndex == value && _value == false) {
      _value = true;
    }
    // _value = true;

    if (_testingIndex != value && _value == false) {
      _value = true;
      print("does i work or not second second second");
    }
    notifyListeners();
  }

  setTestingIndex(int value) {
    _testingIndex = value;
    notifyListeners();
  }
}

class AppliedLeavesProvider extends ChangeNotifier {
  static Future<List> getAppliedLeaves() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String decodeData = sharedPreferences.getString("data") ?? "";
    // var data = jsonDecode(decodeData);
    var response = await http.get(
      Uri.parse(Constants.getAppliedLeavesUrl + "/" + Constants.getStaffID),
    );
    var jsonData = jsonDecode(response.body);
    List data2 = jsonData['data'];
    // if(jsonData['status' == 200]){
    //    data2 = jsonData['data'];
    // }

    return data2;
  }
}
