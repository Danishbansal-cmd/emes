import 'dart:convert';
import 'package:emes/Pages/api_testing_page.dart';
import 'package:emes/Pages/checkin_checkout_page.dart';
import 'package:emes/Pages/home_page.dart';
import 'package:emes/Providers/accept_decline_provider.dart';
import 'package:emes/Utils/configure_platform.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController declineShiftReasonController = TextEditingController();
  double shiftContainerHeight = 75;
  String startDate = "";
  String endDate = "";
  //applevel controller initialize
  final controller = Get.put(AcceptDeclineController());

  final ShiftData _shiftData = ShiftData();
  final ConfigurePlatform _configurePlatform = ConfigurePlatform();

  //function of callback
  //need to call from another page
  callback() {
    setState(() {
      controller.idOfSelectedItemsList.clear();
      controller.selectedItemsList.clear();
      controller.ifAcceptedShiftIsSelected.clear();
      controller.ifDeclinedShiftIsSelected.clear();
    });
  }

  // @override
  //   void dispose() {
  //       super.dispose();
  //       controller.dispose();
  //    }

  @override
  Widget build(BuildContext context) {
    //initializing homepagedates getx controller
    final homepageDatesController = Get.put(HomepageDatesController());
    //initializing acceptordeclineshift getx controller
    final acceptOrDeclineStatusController =
        Get.put(AcceptOrDeclineStatusController());

    void setDateFunction(String value1, String value2) {
      homepageDatesController.setStartDate(value1);
      homepageDatesController.setEndDate(value2);
    }

    // @override
    // void initState() async {
    //   super.initState();
    //   // WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));

    // }

    Future.delayed(Duration.zero, () async {
      //your code goes here
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String decodeData = sharedPreferences.getString("data") ?? "";
      var data = jsonDecode(decodeData);
      final myFuture = http.post(
        Uri.parse(Constants.getCompanyURL + '/api/getshift'),
        body: {
          "staff_id": data['id'],
        },
      );
      myFuture.then(
        (value) => setDateFunction(
            (jsonDecode(value.body))['data']['start_date'],
            (jsonDecode(value.body))['data']['end_date']),
      );
    });

    final _textTheme = Theme.of(context).textTheme;
    final _colorScheme = Theme.of(context).colorScheme;

    bool _isIos = _configurePlatform.getConfigurePlatformBool;

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 5),
      color: _colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //upper list of the page
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: FutureBuilder(
                future: _shiftData.getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we get an error becuase of network
                    if (snapshot.hasError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          // Icon(
                          //   Icons.calendar_month_outlined,
                          //   size: 90,
                          //   color: Colors.blue,
                          // ),
                          FaIcon(
                            FontAwesomeIcons.calendarDays,
                            size: 70,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("No Shifts Found"),
                        ],
                      );

                      // if we get our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      final shiftData = snapshot.data['allShifts'] as Map;
                      final keyList = shiftData.keys.toList();
                      startDate = snapshot.data['start_date'];
                      endDate = snapshot.data['end_date'];

                      return shiftData.isEmpty
                          ? Column(
                              //if data is empty
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.calendarDays,
                                  size: 70,
                                  color: Colors.blue,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("No Shifts Found"),
                                Text(snapshot.data['shift_title']),
                              ],
                            )
                          : Material(
                              child: ListView.separated(
                                physics: (_isIos)
                                    ? const BouncingScrollPhysics()
                                    : const AlwaysScrollableScrollPhysics(),
                                //first list and if data is not empty
                                // shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const SizedBox.shrink();
                                },
                                itemCount: keyList.length,
                                itemBuilder: (context, index) {
                                  var moreShifts =
                                      shiftData[keyList[index]].length;
                                  var insideKeyList =
                                      shiftData[keyList[index]].keys;
                                  return Container(
                                    color: _colorScheme.background,
                                    height: (shiftContainerHeight * moreShifts +
                                            16 * (moreShifts))
                                        .toDouble(),
                                    child: ListView.separated(
                                      //nested second list
                                      physics: const ClampingScrollPhysics(),
                                      separatorBuilder: (context, index) {
                                        return const SizedBox.shrink();
                                      },
                                      itemBuilder: (context, index2) {
                                        //main box of the shift
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _colorScheme.primary,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              width: 1.5,
                                            ),
                                          ),
                                          height: shiftContainerHeight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //
                                              //checkbox button
                                              Obx(
                                                () => SizedBox(
                                                  width: 35,
                                                  child: Checkbox(
                                                    onChanged: (value) {
                                                      if (!controller
                                                          .selectedItemsList
                                                          .contains(
                                                              "$index$index2")) {
                                                        controller
                                                            .addSelectedItemsList(
                                                                "$index$index2");
                                                        controller
                                                            .addIdOfSelectedItemsList(
                                                                "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['user_id']}");
                                                        if (shiftData[keyList[
                                                                        index]][
                                                                    insideKeyList
                                                                            .toList()[
                                                                        index2]]
                                                                [
                                                                'confirmed_by_staff'] ==
                                                            "1") {
                                                          controller
                                                              .ifAcceptedShiftIsSelected
                                                              .add(true);
                                                        } else if (shiftData[
                                                                        keyList[
                                                                            index]]
                                                                    [
                                                                    insideKeyList
                                                                            .toList()[
                                                                        index2]]
                                                                [
                                                                'confirmed_by_staff'] ==
                                                            "2") {
                                                          controller
                                                              .ifDeclinedShiftIsSelected
                                                              .add(true);
                                                        }
                                                      } else if (controller
                                                          .selectedItemsList
                                                          .contains(
                                                              "$index$index2")) {
                                                        controller
                                                            .deleteSelectedItemsList(
                                                                "$index$index2");
                                                        controller
                                                            .deleteIdOfSelectedItemsList(
                                                                "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['user_id']}");
                                                        if (shiftData[keyList[
                                                                        index]][
                                                                    insideKeyList
                                                                            .toList()[
                                                                        index2]]
                                                                [
                                                                'confirmed_by_staff'] ==
                                                            "1") {
                                                          controller
                                                              .ifAcceptedShiftIsSelected
                                                              .remove(true);
                                                        } else if (shiftData[
                                                                        keyList[
                                                                            index]]
                                                                    [
                                                                    insideKeyList
                                                                            .toList()[
                                                                        index2]]
                                                                [
                                                                'confirmed_by_staff'] ==
                                                            "2") {
                                                          controller
                                                              .ifDeclinedShiftIsSelected
                                                              .remove(true);
                                                        }
                                                      }
                                                    },
                                                    value: controller
                                                        .selectedItemsList
                                                        .contains(
                                                            "$index$index2"),
                                                    shape: const CircleBorder(),
                                                  ),
                                                ),
                                              ),

                                              //
                                              //data to be represented
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    // controller.clickedItemValue
                                                    //     .value = index;
                                                    if (!controller
                                                        .selectedItemsList
                                                        .contains(
                                                            "$index$index2")) {
                                                      controller
                                                          .addSelectedItemsList(
                                                              "$index$index2");
                                                      controller
                                                          .addIdOfSelectedItemsList(
                                                              "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['user_id']}");
                                                      if (shiftData[keyList[
                                                                      index]][
                                                                  insideKeyList
                                                                          .toList()[
                                                                      index2]][
                                                              'confirmed_by_staff'] ==
                                                          "1") {
                                                        controller
                                                            .ifAcceptedShiftIsSelected
                                                            .add(true);
                                                      } else if (shiftData[
                                                                      keyList[
                                                                          index]]
                                                                  [
                                                                  insideKeyList
                                                                          .toList()[
                                                                      index2]][
                                                              'confirmed_by_staff'] ==
                                                          "2") {
                                                        controller
                                                            .ifDeclinedShiftIsSelected
                                                            .add(true);
                                                      }
                                                    } else if (controller
                                                        .selectedItemsList
                                                        .contains(
                                                            "$index$index2")) {
                                                      controller
                                                          .deleteSelectedItemsList(
                                                              "$index$index2");
                                                      controller
                                                          .deleteIdOfSelectedItemsList(
                                                              "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['user_id']}");
                                                      if (shiftData[keyList[
                                                                      index]][
                                                                  insideKeyList
                                                                          .toList()[
                                                                      index2]][
                                                              'confirmed_by_staff'] ==
                                                          "1") {
                                                        controller
                                                            .ifAcceptedShiftIsSelected
                                                            .remove(true);
                                                      } else if (shiftData[
                                                                      keyList[
                                                                          index]]
                                                                  [
                                                                  insideKeyList
                                                                          .toList()[
                                                                      index2]][
                                                              'confirmed_by_staff'] ==
                                                          "2") {
                                                        controller
                                                            .ifDeclinedShiftIsSelected
                                                            .remove(true);
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 3),
                                                    height:
                                                        shiftContainerHeight,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        //shift date
                                                        Text(
                                                          "${Constants.nameOfDayOfShift(shiftData[keyList[index]][insideKeyList.toList()[index2]]['day_of_shift'])} ${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date'].substring(8, 10)}/${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date'].substring(5, 7)}/${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date'].substring(0, 4)}",
                                                          style: _textTheme
                                                              .headline3!
                                                              .copyWith(
                                                            color: shiftData[keyList[index]]
                                                                            [insideKeyList.toList()[index2]]
                                                                        [
                                                                        'confirmed_by_staff'] ==
                                                                    "1"
                                                                ? const Color.fromARGB(
                                                                    255,
                                                                    54,
                                                                    192,
                                                                    59)
                                                                : shiftData[keyList[index]][insideKeyList.toList()[index2]]['confirmed_by_staff'] ==
                                                                        "2"
                                                                    ? const Color.fromARGB(
                                                                        255,
                                                                        194,
                                                                        48,
                                                                        48)
                                                                    : const Color.fromARGB(
                                                                        255,
                                                                        34,
                                                                        34,
                                                                        34),
                                                          ),
                                                        ),
                                                        //shift's client name
                                                        Text(
                                                          "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['client_name']}",
                                                          style: _textTheme
                                                              .headline4,
                                                        ),
                                                        //shift time
                                                        Text.rich(
                                                          TextSpan(
                                                            text:
                                                                '${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_on']}',
                                                            style: _textTheme
                                                                .headline4,
                                                            children: <
                                                                InlineSpan>[
                                                              const TextSpan(
                                                                  text: " TO "),
                                                              TextSpan(
                                                                text:
                                                                    '${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_off']}',
                                                                style: _textTheme
                                                                    .headline4,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              //
                                              //button to next page
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  splashColor: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  onTap: () {
                                                    Future.delayed(
                                                      const Duration(
                                                          milliseconds: 200),
                                                      () {
                                                        // if (shiftData[keyList[
                                                        //                 index]][insideKeyList
                                                        //                     .toList()[
                                                        //                 index2]]
                                                        //             [
                                                        //             'is_confirm'] ==
                                                        //         "1" &&

                                                        if (shiftData[keyList[
                                                                        index]][
                                                                    insideKeyList
                                                                            .toList()[
                                                                        index2]]
                                                                [
                                                                'confirmed_by_staff'] ==
                                                            "1") {
                                                          Navigator.push(
                                                            context,
                                                            (_isIos)
                                                                ? CupertinoPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CheckinCheckoutPage(
                                                                      shiftId: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['shift_id'],
                                                                      clientId: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['client_id'],
                                                                      workDate: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['work_date'],
                                                                      timeOn: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['time_on'],
                                                                      timeOff: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['time_off'],
                                                                      taskId: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['task_id'],
                                                                      clientName: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['client_name'],
                                                                      activityName: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['activity_name'],
                                                                      dayOfShift: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['day_of_shift'],
                                                                    ),
                                                                  )
                                                                : MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CheckinCheckoutPage(
                                                                      shiftId: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['shift_id'],
                                                                      clientId: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['client_id'],
                                                                      workDate: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['work_date'],
                                                                      timeOn: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['time_on'],
                                                                      timeOff: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['time_off'],
                                                                      taskId: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['task_id'],
                                                                      clientName: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['client_name'],
                                                                      activityName: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['activity_name'],
                                                                      dayOfShift: shiftData[
                                                                          keyList[index]][insideKeyList
                                                                              .toList()[
                                                                          index2]]['day_of_shift'],
                                                                    ),
                                                                  ),
                                                          );
                                                        } else if (shiftData[keyList[
                                                                        index]][insideKeyList
                                                                            .toList()[
                                                                        index2]]
                                                                    [
                                                                    'is_confirm'] !=
                                                                "1" &&
                                                            shiftData[keyList[
                                                                        index]][
                                                                    insideKeyList
                                                                            .toList()[
                                                                        index2]]['confirmed_by_staff'] ==
                                                                "1") {
                                                          Get.snackbar(
                                                              'Message',
                                                              'Shift is not confirmed from the backend.',
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1200));
                                                        } else if (shiftData[
                                                                        keyList[
                                                                            index]]
                                                                    [
                                                                    insideKeyList
                                                                            .toList()[
                                                                        index2]]
                                                                [
                                                                'confirmed_by_staff'] !=
                                                            "1") {
                                                          Get.snackbar(
                                                              'Message',
                                                              'You need to confirm the shift first.',
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1200));
                                                        }
                                                      },
                                                    );
                                                  },
                                                  child: const SizedBox(
                                                    // color: Colors.amber,
                                                    height: 40,
                                                    width: 40,
                                                    child: Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .arrowUpRightFromSquare,
                                                        size: 18,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: moreShifts,
                                    ),
                                  );
                                },
                              ),
                            );
                    }
                  }

                  // Displaying LoadingSpinner to indicate waiting state
                  //on fetching data from the server or link or api
                  return Center(
                    child: (_isIos)
                        ? const CupertinoActivityIndicator(
                            radius: 20.0, color: Colors.black)
                        : const CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                  );
                },
              ),
            ),
          ),
          //bottom accept or decline buttons
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0,),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: (MediaQuery.of(context).size.width - 50.0)/2,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0,),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    color: CupertinoColors.destructiveRed,
                    child: const Text("DECLINE",style: TextStyle(fontWeight: FontWeight.bold,),),
                    onPressed: () {
                      if (controller.ifAcceptedShiftIsSelected.contains(true)) {
                        //message dialog
                        (_isIos)
                            ? Constants.showCupertinoAlertDialog(
                                child: const Text(
                                    "Contact your manager as shift can no longer be declined."),
                                context: context,
                              )
                            : showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Message",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                            fontSize: 18,
                                          ),
                                    ),
                                    content: const Text(
                                        "Contact your manager as shift can no longer be declined."),
                                    actions: [
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: const Color.fromARGB(
                                              255, 30, 89, 137),
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 20),
                                            child: const Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 64, 160, 239)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                      } else if (!controller.ifDeclinedShiftIsSelected
                              .contains(true) &&
                          controller.idOfSelectedItemsList.isNotEmpty) {
                        //decline shift dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController giveReasonController =
                                TextEditingController();
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 15)
                                            .copyWith(
                                      top: 20.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Constants.declineShiftPopupTopRow(
                                            context, "Decline Shift"),
                                        //Some Space
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Constants.textfieldWithCancelSuffixButton(
                                            controller.setReasonErrorText,
                                            giveReasonController),
                                        //
                                        Obx(
                                          () => Text(
                                            controller.getReasonErrorText.value,
                                            style: _textTheme.headline6,
                                          ),
                                        ),
                                        //
                                        //Decline Shift Button
                                        Constants.materialRoundedButton(
                                            baseColor: const Color.fromARGB(
                                                255, 252, 39, 24),
                                            highlightColor: Colors.amber,
                                            splashColor: const Color.fromARGB(
                                                255, 126, 19, 19),
                                            onTapFunction: () {
                                              if (giveReasonController
                                                  .text.isEmpty) {
                                                controller.setReasonErrorText(
                                                    giveReasonController.text);
                                              } else {
                                                Navigator.of(context).pop();
                                                acceptOrDeclineStatusController
                                                    .declineShift(
                                                        controller
                                                            .idOfSelectedItemsList,
                                                        startDate,
                                                        endDate,
                                                        giveReasonController.text,
                                                        callback,
                                                        context);
                                              }
                                            },
                                            buttonText: "Decline Shift"),
                                        //Some Space
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (controller.idOfSelectedItemsList.isEmpty) {
                        (_isIos)
                            ? Constants.showCupertinoAlertDialog(
                                child: const Text("Please select some values."),
                                context: context)
                            : Get.snackbar(
                                'Message', 'Please select some values.',
                                duration: const Duration(milliseconds: 1200));
                      } else {
                        (_isIos)
                            ? Constants.showCupertinoAlertDialog(
                                child: const Text(
                                    "Declined shift cannot be declined again."),
                                context: context)
                            : Get.snackbar('Message',
                                'Declined shift cannot be declined again.',
                                duration: const Duration(milliseconds: 1200));
                      }
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: (MediaQuery.of(context).size.width - 50.0)/2,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0,),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    color: const Color.fromARGB(255, 31, 224, 37),
                    child: const Text("ACCEPT",style: TextStyle(fontWeight: FontWeight.bold,),),
                    onPressed: () {
                      if (!controller.ifAcceptedShiftIsSelected.contains(true) &&
                          controller.idOfSelectedItemsList.isNotEmpty) {
                        acceptOrDeclineStatusController.acceptShift(
                            controller.idOfSelectedItemsList, callback, context);
                      } else if (controller.idOfSelectedItemsList.isEmpty) {
                        (_isIos)
                            ? Constants.showCupertinoAlertDialog(
                                child: const Text("Please select some values."),
                                context: context)
                            : Get.snackbar(
                                'Message', 'Please select some values.',
                                duration: const Duration(milliseconds: 1200));
                      } else {
                        (_isIos)
                            ? Constants.showCupertinoAlertDialog(
                                child: const Text(
                                    "Accepted shift cannot be accepted again."),
                                context: context)
                            : Get.snackbar('Message',
                                'Accepted shift cannot be accepted again.',
                                duration: const Duration(milliseconds: 1200));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AcceptDeclineController extends GetxController {
  RxList<String> selectedItemsList = <String>[].obs;
  RxList<String> idOfSelectedItemsList = <String>[].obs;
  RxList<bool> ifAcceptedShiftIsSelected = <bool>[].obs;
  RxList<bool> ifDeclinedShiftIsSelected = <bool>[].obs;
  //for selectedItemsList variable
  addSelectedItemsList(String value) {
    selectedItemsList.add(value);
  }

  deleteSelectedItemsList(String value) {
    selectedItemsList.remove(value);
  }

  //for idOfSelectedItemsList variable
  addIdOfSelectedItemsList(String value) {
    idOfSelectedItemsList.add(value);
  }

  deleteIdOfSelectedItemsList(String value) {
    idOfSelectedItemsList.remove(value);
  }

  RxString reasonErrorText = ''.obs;
  setReasonErrorText(String value) {
    if (value.isEmpty || value == "") {
      reasonErrorText.value = "*Reason cannot be empty";
    } else {
      reasonErrorText.value = "";
    }
  }

  get getReasonErrorText {
    return reasonErrorText;
  }

  RxInt _preventFromRefreshInt = 1.obs;

  //getters
  get getPreventFromRefreshInt {
    return _preventFromRefreshInt;
  }
}
