import 'dart:convert';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ApplyLeavePage extends StatefulWidget {
  ApplyLeavePage({Key? key}) : super(key: key);

  @override
  State<ApplyLeavePage> createState() => _ApplyLeavePageState();
}

class _ApplyLeavePageState extends State<ApplyLeavePage> {
  //initializing text controller
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //intializing openleavebar getx controller
    final openLeaveBarController = Get.put(OpenLeaveBarController());
    //initializing applyleave getx controller
    final applyLeavePageController = Get.put(ApplyLeavePageController());
    final _textTheme = Theme.of(context).textTheme;
    print(
        "How many times does i run \n ///////////////////\n/////////////////\n ///////////////////\n ///////////////////");

    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: const Text("My Leave"),
        actions: [
          InkWell(
            onTap: () {
              fromDateController.text = "";
              toDateController.text = "";
              reasonController.text = "";
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
                                // height: 410,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.primary,
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
                                    //Apply Leave Form First's Row
                                    //and main heading Row
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
                                                    BorderRadius.circular(
                                                  30,
                                                ),
                                                // color: Colors.amber,
                                              ),
                                              width: 35,
                                              height: 35,
                                              child: Icon(
                                                Icons.close_rounded,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ).copyWith(right: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: TextField(
                                        cursorColor: Colors.grey,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          applyLeavePageController
                                              .setFromDateErrorText(value);
                                        },
                                        controller: fromDateController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          hintText: "Select From Date",
                                          border: InputBorder.none,
                                          suffixIcon: applyLeaveFormButtonsRow(
                                              controller: fromDateController),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        applyLeavePageController
                                            .getFromDateErrorText,
                                        style: _textTheme.headline6,
                                      ),
                                    ),
                                    //
                                    //
                                    //To Date Field
                                    const Text("To Date"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ).copyWith(right: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: TextField(
                                        textInputAction: TextInputAction.done,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        cursorColor: Colors.grey,
                                        onChanged: (value) {
                                          applyLeavePageController
                                              .setToDateErrorText(value);
                                        },
                                        controller: toDateController,
                                        decoration: InputDecoration(
                                          // labelText: "hello 1",
                                          hintText: "Select To Date",
                                          border: InputBorder.none,
                                          suffixIcon: applyLeaveFormButtonsRow(
                                              controller: toDateController),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        applyLeavePageController
                                            .getToDateErrorText,
                                        style: _textTheme.headline6,
                                      ),
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
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: TextField(
                                        cursorColor: Colors.grey,
                                        textInputAction: TextInputAction.done,
                                        maxLines: 5,
                                        minLines: 1,
                                        onChanged: (value) {
                                          applyLeavePageController
                                              .setReasonErrorText(
                                            value,
                                          );
                                        },
                                        controller: reasonController,
                                        decoration: const InputDecoration(
                                          // labelText: "hello 1",
                                          hintText: "Type Reason Here...",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        applyLeavePageController
                                            .getReasonErrorText,
                                        style: _textTheme.headline6,
                                      ),
                                    ),
                                    //
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //
                                    // Apply Leave Button
                                    Material(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50),
                                      child: InkWell(
                                        // splashColor: Colors.white,
                                        onTap: () {
                                          applyLeavePageController
                                              .validateApplyLeaveFormData(
                                            fromDateController.text,
                                            toDateController.text,
                                            reasonController.text
                                                .trim()
                                                .replaceAll('  ', ' ')
                                                .replaceAll('  ', ' '),
                                            context,
                                          );
                                          // setState(() {});
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
                                    ),
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
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 5),
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
                    final appliedLeavesData = snapshot.data as Map;
                    final appliedLeavesDataKeysList =
                        appliedLeavesData.keys.toList();

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
                            onNotification:
                                (OverscrollIndicatorNotification overScroll) {
                              overScroll.disallowGlow();
                              return true;
                            },
                            child: ListView.separated(
                              itemCount: appliedLeavesDataKeysList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    openLeaveBarController
                                        .setBoolValueToggle(index);
                                    openLeaveBarController
                                        .setTestingIndex(index);
                                  },
                                  child: Container(
                                    //this represents apply leave box
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          width: 1.5),
                                    ),
                                    // height: (openLeaveBarProvider
                                    //             .boolValue &&
                                    //         openLeaveBarProvider
                                    //                 .getIntTestingIndex ==
                                    //             index)
                                    //     ? 120
                                    //     : 54,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        //upper row which is always visible to the user
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //box to represent the dates
                                            //and the indicator
                                            Container(
                                              // color: Colors.grey,
                                              height: 50,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  //this indicator with two dots on its top and bottom
                                                  Constants.indicatorTracker(
                                                      appliedLeavesData[appliedLeavesDataKeysList[
                                                                          index]]
                                                                      [
                                                                      'ApplyForHoliday']
                                                                  ['status'] ==
                                                              "0"
                                                          ? Colors.amber
                                                          : appliedLeavesData[appliedLeavesDataKeysList[
                                                                              index]]
                                                                          [
                                                                          'ApplyForHoliday']
                                                                      [
                                                                      'status'] ==
                                                                  "1"
                                                              ? Colors.green
                                                              : Colors.red,
                                                      12),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  //dates column of the box
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(appliedLeavesData[
                                                                  appliedLeavesDataKeysList[
                                                                      index]][
                                                              'ApplyForHoliday']
                                                          ['on_date']),
                                                      Text(appliedLeavesData[
                                                                  appliedLeavesDataKeysList[
                                                                      index]][
                                                              'ApplyForHoliday']
                                                          ['to_date'])
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            //second box
                                            //box to represent the status and the button on the right
                                            Container(
                                              height: 50,
                                              child: Row(
                                                children: [
                                                  //status container
                                                  Container(
                                                    height: 30,
                                                    width: 90,
                                                    child: Center(
                                                      child: Text(
                                                        appliedLeavesData[appliedLeavesDataKeysList[
                                                                            index]]
                                                                        [
                                                                        'ApplyForHoliday']
                                                                    [
                                                                    'status'] ==
                                                                "0"
                                                            ? "Pending"
                                                            : appliedLeavesData[
                                                                                appliedLeavesDataKeysList[index]]
                                                                            [
                                                                            'ApplyForHoliday']
                                                                        [
                                                                        'status'] ==
                                                                    "1"
                                                                ? "Accepted"
                                                                : "Decline",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: appliedLeavesData[
                                                                          appliedLeavesDataKeysList[
                                                                              index]]
                                                                      [
                                                                      'ApplyForHoliday']
                                                                  ['status'] ==
                                                              "0"
                                                          ? Colors.amber
                                                          : appliedLeavesData[appliedLeavesDataKeysList[
                                                                              index]]
                                                                          [
                                                                          'ApplyForHoliday']
                                                                      [
                                                                      'status'] ==
                                                                  "1"
                                                              ? Colors.green
                                                              : Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    splashColor: Colors.blue,
                                                    onTap: () {
                                                      print(appliedLeavesData[
                                                                  appliedLeavesDataKeysList[
                                                                      index]][
                                                              'ApplyForHoliday']
                                                          ['reason']);
                                                      openLeaveBarController
                                                          .setBoolValueToggle(
                                                              index);
                                                      openLeaveBarController
                                                          .setTestingIndex(
                                                              index);
                                                    },
                                                    child: Obx(
                                                      () => SizedBox(
                                                        width: 40,
                                                        height: 40,
                                                        child: (openLeaveBarController
                                                                    .getBoolValue &&
                                                                openLeaveBarController
                                                                        .getIntTestingIndex ==
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
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        //second row
                                        //only visible on the tap of the upper box or row
                                        Row(
                                          children: [
                                            Obx(
                                              () => Visibility(
                                                visible: (openLeaveBarController
                                                            .getBoolValue &&
                                                        openLeaveBarController
                                                                .getIntTestingIndex ==
                                                            index)
                                                    ? true
                                                    : false,
                                                child: Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3,
                                                      ),
                                                      color: appliedLeavesData[
                                                                          appliedLeavesDataKeysList[
                                                                              index]]
                                                                      [
                                                                      'ApplyForHoliday']
                                                                  ['status'] ==
                                                              "0"
                                                          ? Colors.amber
                                                          : appliedLeavesData[appliedLeavesDataKeysList[
                                                                              index]]
                                                                          [
                                                                          'ApplyForHoliday']
                                                                      [
                                                                      'status'] ==
                                                                  "1"
                                                              ? Colors.green
                                                              : Colors.red,
                                                    ),
                                                    // height: 67,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 25,
                                                      vertical: 5,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text.rich(
                                                          TextSpan(
                                                              text: 'Reason:',
                                                              style: _textTheme
                                                                  .headline2!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                              children: <
                                                                  InlineSpan>[
                                                                const TextSpan(
                                                                    text:
                                                                        "   "),
                                                                TextSpan(
                                                                  text: appliedLeavesData[
                                                                              appliedLeavesDataKeysList[index]]
                                                                          [
                                                                          'ApplyForHoliday']
                                                                      [
                                                                      'reason'],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                )
                                                              ]),
                                                        ),
                                                        (appliedLeavesData[appliedLeavesDataKeysList[
                                                                            index]]
                                                                        [
                                                                        'ApplyForHoliday']
                                                                    [
                                                                    'admin_msg'] ==
                                                                "")
                                                            ? SizedBox.shrink()
                                                            : Text.rich(
                                                                TextSpan(
                                                                  text:
                                                                      'Admin Reply:',
                                                                  style: _textTheme
                                                                      .headline2!
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.black),
                                                                  children: <
                                                                      InlineSpan>[
                                                                    const TextSpan(
                                                                        text:
                                                                            "   "),
                                                                    TextSpan(
                                                                      text: appliedLeavesData[appliedLeavesDataKeysList[index]]
                                                                              [
                                                                              'ApplyForHoliday']
                                                                          [
                                                                          'admin_msg'],
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 15,
                                );
                              },
                            ),
                          );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget applyLeaveFormButtonsRow({required TextEditingController controller}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          child: IconButton(
            color: Colors.grey,
            padding: const EdgeInsets.only(bottom: 2, right: 0),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year,
                    DateTime.now().month + 2, DateTime.now().day),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.yellow,
                        onPrimary: Colors.black,
                        onSurface: Colors.green,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null && picked != DateTime.now()) {
                // setState(() {
                controller.text = (picked.day.toString().length == 1
                        ? "0" + picked.day.toString()
                        : picked.day.toString()) +
                    "/" +
                    (picked.month.toString().length == 1
                        ? "0" + picked.month.toString()
                        : picked.month.toString()) +
                    "/" +
                    picked.year.toString();
                // });
              }
            },
            icon: const Icon(Icons.calendar_month),
          ),
        ),
        SizedBox(
          width: 40,
          child: IconButton(
            color: Colors.grey,
            padding: const EdgeInsets.only(bottom: 2, right: 0),
            onPressed: () {
              controller.clear();
            },
            icon: const Icon(Icons.cancel),
          ),
        ),
      ],
    );
  }
}

class OpenLeaveBarController extends GetxController {
  RxBool _value = false.obs;
  RxInt _testingIndex = 0.obs;

  //getters and setters
  get getBoolValue {
    return _value.value;
  }

  get getIntTestingIndex {
    return _testingIndex.value;
  }

  setBoolValueToggle(int value) {
    if (_testingIndex.value == value && _value.value == true) {
      _value.value = false;
      // print("does i work or not");
    } else if (_testingIndex.value == value && _value.value == false) {
      _value.value = true;
    }
    // _value = true;

    if (_testingIndex.value != value && _value.value == false) {
      _value.value = true;
      // print("does i work or not second second second");
    }
  }

  setTestingIndex(int value) {
    _testingIndex.value = value;
  }
}

class AppliedLeavesProvider {
  static Future<Map> getAppliedLeaves() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String decodeData = sharedPreferences.getString("data") ?? "";
    // var data = jsonDecode(decodeData);
    var response = await http.get(
      Uri.parse(Constants.getCompanyURL + "/api/get_applied_leave/" + Constants.getStaffID),
    );
    var jsonData = jsonDecode(response.body);
    Map data2 = jsonData['data'];
    // if(jsonData['status' == 200]){
    //    data2 = jsonData['data'];
    // }

    return data2;
  }
}

class ApplyLeavePageController extends GetxController {
  RxString _fromDateErrorText = "".obs;
  RxBool _fromDateErrorBool = false.obs;
  RxString _toDateErrorText = "".obs;
  RxBool _toDateErrorBool = false.obs;
  RxString _reasonErrorText = "".obs;

  //getters and setters
  get getFromDateErrorText {
    return _fromDateErrorText.value;
  }

  get getToDateErrorText {
    return _toDateErrorText.value;
  }

  get getReasonErrorText {
    return _reasonErrorText.value;
  }

  get getFromDateErrorBool {
    return _fromDateErrorBool.value;
  }

  get getToDateErrorBool {
    return _toDateErrorBool.value;
  }

  setFromDateErrorText(String value) {
    RegExp calenderDate = RegExp(
        r'^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$');

    if (value.isEmpty) {
      _fromDateErrorText.value = "*You must select a value.";
      _fromDateErrorBool.value = true;
    } else if (!calenderDate.hasMatch(value)) {
      _fromDateErrorText.value = "*Selected Date should be after current date.";
      _fromDateErrorBool.value = true;
    } else {
      _fromDateErrorText.value = "";
      _fromDateErrorBool.value = false;
    }
  }

  setToDateErrorText(String value) {
    RegExp calenderDate = RegExp(
        r'^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$');
    if (value.isEmpty) {
      _toDateErrorText.value = "*You must select a value.";
      _toDateErrorBool.value = true;
    } else if (!calenderDate.hasMatch(value)) {
      _toDateErrorText.value =
          "*Selected Date should be before date 06/06/2022.";
      _toDateErrorBool.value = true;
    } else {
      _toDateErrorText.value = "";
      _toDateErrorBool.value = false;
    }
  }

  setReasonErrorText(String value) {
    if (value.isEmpty) {
      _reasonErrorText.value = "*You must select a value.";
    }
    // else if(value.length > 30){
    //   _reasonErrorText = "*Reason is too long.";
    // }
    else {
      _reasonErrorText.value = "";
    }
  }

  validateApplyLeaveFormData(
      String value1, String value2, String value3, BuildContext context) {
    setFromDateErrorText(value1);
    setToDateErrorText(value2);
    setReasonErrorText(value3);

    if (value1.isNotEmpty &&
        getFromDateErrorBool == false &&
        value2.isNotEmpty &&
        getToDateErrorBool == false &&
        value3.isNotEmpty) {
      applyLeaveData(value1, value2, value3, context);
    }
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
    Navigator.of(context).pop(true);
    if (jsonData['status'] == 200) {
      Constants.basicWidget(jsonData['message'], context);
    }
    if (jsonData['status'] == 401) {
      Constants.basicWidget(jsonData['message'], context);
    }
  }
}
