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
    final applyLeaveFormProvider = Provider.of<ApplyLeaveFormProvider>(context);
    print(
        "How many times does i run \n ///////////////////\n/////////////////\n ///////////////////\n ///////////////////");

    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: const Text("My Leave"),
        actions: [
          InkWell(
            onTap: () {
              applyLeaveFormProvider.setFromDateErrorText("");
              applyLeaveFormProvider.setToDateErrorText("");
              applyLeaveFormProvider.setReasonErrorText("");
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        // overflow: Overflow.visible,
                        // alignment: Alignment.center,
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              height: 426,
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
                                            width: 50,
                                            height: 50,
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
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey, width: 2)),
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
                                        borderRadius: BorderRadius.circular(5),
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
                                        borderRadius: BorderRadius.circular(5),
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
                                  Material(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50),
                                    child: InkWell(
                                      // splashColor: Colors.white,
                                      onTap: () {
                                        validateApplyLeave(context);
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
                                  )
                                ],
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
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 2),
              ),
              height: 50,
              width: double.infinity,
              child:const Center(child: Text("hello")),
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
    final applyLeaveFormProvider =
        Provider.of<ApplyLeaveFormProvider>(context, listen: false);
    //conditions for fromDateController
    if (fromDateController.text.isEmpty) {
      applyLeaveFormProvider.setFromDateErrorText("*You must select a value.");
    } else if (fromDateController.text.length < 13) {
      applyLeaveFormProvider
          .setFromDateErrorText("*Selected Date should be after current date.");
    }
    //conditions for toDateController
    if (toDateController.text.isEmpty) {
      applyLeaveFormProvider.setToDateErrorText("*You must select a value.");
    } else if (toDateController.text.length < 13) {
      applyLeaveFormProvider.setToDateErrorText(
          "*Selected Date should be before date 06/05/2022.");
    }
    //conditions for reasonController
    if (reasonController.text.isEmpty) {
      applyLeaveFormProvider.setReasonErrorText("*You must select a value.");
    }
  }
}
