import 'package:emes/Providers/apply_leave_form_provider.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                                              // validateApplyLeave(context);
                                              RegExp calenderDate = RegExp(
                                                  r'^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$');
                                              //conditions for fromDateController
                                              if (fromDateController
                                                  .text.isEmpty) {
                                                applyLeaveFormProvider
                                                    .setFromDateErrorText(
                                                        "*You must select a value.");
                                              } else if (!calenderDate.hasMatch(
                                                  fromDateController.text)) {
                                                applyLeaveFormProvider
                                                    .setFromDateErrorText(
                                                        "*Selected Date should be after current date.");
                                              }
                                              //conditions for toDateController
                                              if (toDateController
                                                  .text.isEmpty) {
                                                applyLeaveFormProvider
                                                    .setToDateErrorText(
                                                        "*You must select a value.");
                                              } else if (!calenderDate.hasMatch(
                                                  toDateController.text)) {
                                                applyLeaveFormProvider
                                                    .setToDateErrorText(
                                                        "*Selected Date should be before date 06/06/2022.");
                                              }
                                              //conditions for reasonController
                                              if (reasonController
                                                  .text.isEmpty) {
                                                applyLeaveFormProvider
                                                    .setReasonErrorText(
                                                        "*You must select a value.");
                                              }
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(
            itemBuilder: (context, index) => Consumer<OpenLeaveBarProvider>(
              builder: (context, openLeaveBarProvider, _) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  height: (openLeaveBarProvider.boolValue &&
                          openLeaveBarProvider.intTestingIndex == index)
                      ? 100
                      : 50,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.red,
                        height: 50,
                        child: Center(
                          child: Text("some text"),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: 30,
                            child: Center(
                              child: Text(
                                "Display Status",
                                style: _textTheme.headline1,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                                borderRadius: BorderRadius.circular(50),
                                splashColor: Colors.blue,
                                onTap: () {
                                  // arrowOpenButton = true;
                                  // testingIndex = index;

                                  openLeaveBarProvider
                                      .setBoolValueToggle(index);
                                  openLeaveBarProvider.setTestingIndex(index);
                                  print(
                                      " i am bool value ${openLeaveBarProvider.boolValue}");
                                },
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: (openLeaveBarProvider.boolValue &&
                                          openLeaveBarProvider
                                                  .intTestingIndex ==
                                              index)
                                      ? const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 24,
                                        )
                                      : const Icon(
                                          Icons.arrow_forward_ios_rounded,
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
            ),
            itemCount: 50,
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
          ),
        ),
      ),
    );
  }

  void validateApplyLeave(BuildContext context) {
    // final applyLeaveFormProvider =
    //     Provider.of<ApplyLeaveFormProvider>(context, listen: false);
    //regex for date
    // RegExp calenderDate = RegExp(
    //     r'^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$');
    // //conditions for fromDateController
    // if (fromDateController.text.isEmpty) {
    //   applyLeaveFormProvider.setFromDateErrorText("*You must select a value.");
    // } else if (!calenderDate.hasMatch(fromDateController.text)) {
    //   applyLeaveFormProvider
    //       .setFromDateErrorText("*Selected Date should be after current date.");
    // }
    // //conditions for toDateController
    // if (toDateController.text.isEmpty) {
    //   applyLeaveFormProvider.setToDateErrorText("*You must select a value.");
    // } else if (!calenderDate.hasMatch(toDateController.text)) {
    //   applyLeaveFormProvider.setToDateErrorText(
    //       "*Selected Date should be before date 06/06/2022.");
    // }
    // //conditions for reasonController
    // if (reasonController.text.isEmpty) {
    //   applyLeaveFormProvider.setReasonErrorText("*You must select a value.");
    // }
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
