import 'package:emes/Pages/checkin_checkout_page.dart';
import 'package:emes/Providers/accept_decline_provider.dart';
import 'package:emes/Utils/configure_platform.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  TextEditingController declineShiftReasonController = TextEditingController();
  double shiftContainerHeight = 75;
  String startDate = "";
  String endDate = "";
  String nextScreenCurrentDate = "";

  final ShiftData _shiftData = ShiftData();
  final ConfigurePlatform _configurePlatform = ConfigurePlatform();

  @override
  Widget build(BuildContext context) {
    //applevel controller initialize
    final controller = Get.put(AcceptDeclineControllerNextScreen());
    //initializing thirdscreen getx controller
    final nextScreenController = Get.put(NextScreenController());
    //initializing acceptordeclineshift getx controller
    final acceptOrDeclineStatusController =
        Get.put(AcceptOrDeclineStatusController());
    final _textTheme = Theme.of(context).textTheme;
    final _colorScheme = Theme.of(context).colorScheme;
    bool _isIos = _configurePlatform.getConfigurePlatformBool;

    //function of callback
    //need to call from another page
    callback() {
      setState(() {
        controller.idOfSelectedItemsList.clear();
        controller.selectedItemsList.clear();
        controller.ifAcceptedShiftIsSelected.clear();
        controller.ifDeclinedShiftIsSelected.clear();
        _shiftData.setNextUrl((_shiftData.getNextUrl)
                .substring(0, ((_shiftData.getNextUrl).length - 10)) +
            nextScreenCurrentDate);
      });
    }

    return Obx(
      () => nextScreenController.getValueInt > 0
          ? Container(
              color: _colorScheme.background,
              child: Column(
                children: [
                  //upper list of the page
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: FutureBuilder(
                        future: _shiftData.getNextData(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // If we get an error becuase of network
                            if (snapshot.hasError) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.calendarDays,
                                    size: 70,
                                    color: CupertinoColors.activeGreen,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "No Connection Found",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            }

                            // if we get our data
                            else if (snapshot.hasData) {
                              // Extracting data from snapshot object
                              final shiftData =
                                  snapshot.data['allShifts'] as Map;
                              final keyList = shiftData.keys.toList();
                              startDate = snapshot.data['start_date'];
                              endDate = snapshot.data['end_date'];

                              return shiftData.isEmpty
                                  ?
                                  //if data is empty
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.calendarDays,
                                          size: 70,
                                          color: CupertinoColors.activeGreen,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "No Shifts Found",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data['shift_title'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : NotificationListener<
                                      OverscrollIndicatorNotification>(
                                      onNotification:
                                          (OverscrollIndicatorNotification
                                              overScroll) {
                                        overScroll.disallowGlow();
                                        return true;
                                      },
                                      child: ListView.separated(
                                        physics: (_isIos)
                                            ? const BouncingScrollPhysics()
                                            : const AlwaysScrollableScrollPhysics(),
                                        //first list and if data is not empty
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
                                            height: (shiftContainerHeight *
                                                        moreShifts +
                                                    16 * (moreShifts))
                                                .toDouble(),
                                            child: ListView.separated(
                                              //nested second list
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox.shrink();
                                              },
                                              itemBuilder: (context, index2) {
                                                var tempVar =
                                                    shiftData[keyList[index]][
                                                        insideKeyList
                                                            .toList()[index2]];
                                                nextScreenCurrentDate =
                                                    shiftData[keyList[index]][
                                                            insideKeyList
                                                                    .toList()[
                                                                index2]]['loop']
                                                        ['M'];
                                                //main box of the shift
                                                return Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 8,
                                                  ),
                                                  height: shiftContainerHeight,
                                                  decoration: BoxDecoration(
                                                    color: _colorScheme.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSecondary,
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
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
                                                                        "${tempVar['shift_id']}:${tempVar['work_date']}:${tempVar['user_id']}");
                                                                if (tempVar[
                                                                        'confirmed_by_staff'] ==
                                                                    "1") {
                                                                  controller
                                                                      .ifAcceptedShiftIsSelected
                                                                      .add(
                                                                          true);
                                                                } else if (tempVar[
                                                                        'confirmed_by_staff'] ==
                                                                    "2") {
                                                                  controller
                                                                      .ifDeclinedShiftIsSelected
                                                                      .add(
                                                                          true);
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
                                                                        "${tempVar['shift_id']}:${tempVar['work_date']}:${tempVar['user_id']}");
                                                                if (tempVar[
                                                                        'confirmed_by_staff'] ==
                                                                    "1") {
                                                                  controller
                                                                      .ifAcceptedShiftIsSelected
                                                                      .remove(
                                                                          true);
                                                                } else if (tempVar[
                                                                        'confirmed_by_staff'] ==
                                                                    "2") {
                                                                  controller
                                                                      .ifDeclinedShiftIsSelected
                                                                      .remove(
                                                                          true);
                                                                }
                                                              }
                                                            },
                                                            value: controller
                                                                .selectedItemsList
                                                                .contains(
                                                                    "$index$index2"),
                                                            shape:
                                                                const CircleBorder(),
                                                          ),
                                                        ),
                                                      ),

                                                      //data to be represented
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (!controller
                                                                .selectedItemsList
                                                                .contains(
                                                                    "$index$index2")) {
                                                              controller
                                                                  .addSelectedItemsList(
                                                                      "$index$index2");
                                                              controller
                                                                  .addIdOfSelectedItemsList(
                                                                      "${tempVar['shift_id']}:${tempVar['work_date']}:${tempVar['user_id']}");
                                                              if (tempVar[
                                                                      'confirmed_by_staff'] ==
                                                                  "1") {
                                                                controller
                                                                    .ifAcceptedShiftIsSelected
                                                                    .add(true);
                                                              } else if (tempVar[
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
                                                                      "${tempVar['shift_id']}:${tempVar['work_date']}:${tempVar['user_id']}");
                                                              if (tempVar[
                                                                      'confirmed_by_staff'] ==
                                                                  "1") {
                                                                controller
                                                                    .ifAcceptedShiftIsSelected
                                                                    .remove(
                                                                        true);
                                                              } else if (tempVar[
                                                                      'confirmed_by_staff'] ==
                                                                  "2") {
                                                                controller
                                                                    .ifDeclinedShiftIsSelected
                                                                    .remove(
                                                                        true);
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        3),
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
                                                                Text(
                                                                  "${Constants.nameOfDayOfShift(tempVar['day_of_shift'])} ${tempVar['work_date'].substring(8, 10)}/${tempVar['work_date'].substring(5, 7)}/${tempVar['work_date'].substring(0, 4)}",
                                                                  style: _textTheme
                                                                      .headline3!
                                                                      .copyWith(
                                                                    color: tempVar['confirmed_by_staff'] ==
                                                                            "1"
                                                                        ? const Color.fromARGB(
                                                                            255,
                                                                            54,
                                                                            192,
                                                                            59)
                                                                        : tempVar['confirmed_by_staff'] ==
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
                                                                  "${tempVar['client_name']}",
                                                                  style: _textTheme
                                                                      .headline4,
                                                                ),
                                                                //shift time
                                                                Text.rich(
                                                                  TextSpan(
                                                                    text:
                                                                        '${tempVar['time_on']}',
                                                                    style: _textTheme
                                                                        .headline4,
                                                                    children: <
                                                                        InlineSpan>[
                                                                      const TextSpan(
                                                                          text:
                                                                              " TO "),
                                                                      TextSpan(
                                                                        text:
                                                                            '${tempVar['time_off']}',
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

                                                      //button to next page
                                                      Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          splashColor:
                                                              Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9),
                                                          onTap: () {
                                                            Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      200),
                                                              () {
                                                                // if (shiftData[keyList[
                                                                //                 index]][insideKeyList
                                                                //                     .toList()[
                                                                //                 index2]]
                                                                //             [
                                                                //             'is_confirm'] ==
                                                                //         "1" &&

                                                                if (tempVar[
                                                                        'confirmed_by_staff'] ==
                                                                    "1") {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    (_isIos)
                                                                        ? CupertinoPageRoute(
                                                                            builder: (context) =>
                                                                                CheckinCheckoutPage(
                                                                              shiftId: tempVar['shift_id'],
                                                                              clientId: tempVar['client_id'],
                                                                              workDate: tempVar['work_date'],
                                                                              timeOn: tempVar['time_on'],
                                                                              timeOff: tempVar['time_off'],
                                                                              taskId: tempVar['task_id'],
                                                                              clientName: tempVar['client_name'],
                                                                              activityName: tempVar['activity_name'],
                                                                              dayOfShift: tempVar['day_of_shift'],
                                                                            ),
                                                                          )
                                                                        : MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                CheckinCheckoutPage(
                                                                              shiftId: tempVar['shift_id'],
                                                                              clientId: tempVar['client_id'],
                                                                              workDate: tempVar['work_date'],
                                                                              timeOn: tempVar['time_on'],
                                                                              timeOff: tempVar['time_off'],
                                                                              taskId: tempVar['task_id'],
                                                                              clientName: tempVar['client_name'],
                                                                              activityName: tempVar['activity_name'],
                                                                              dayOfShift: tempVar['day_of_shift'],
                                                                            ),
                                                                          ),
                                                                  );
                                                                } else if (tempVar[
                                                                            'is_confirm'] !=
                                                                        "1" &&
                                                                    tempVar['confirmed_by_staff'] ==
                                                                        "1") {
                                                                  (_isIos)
                                                                      ? Constants.showCupertinoAlertDialog(
                                                                          child: const Text(
                                                                              "Shift is not confirmed from the backend."),
                                                                          context:
                                                                              context)
                                                                      : Get.snackbar(
                                                                          'Message',
                                                                          'Shift is not confirmed from the backend.',
                                                                          duration:
                                                                              const Duration(milliseconds: 1200));
                                                                } else if (tempVar[
                                                                        'confirmed_by_staff'] !=
                                                                    "1") {
                                                                  (_isIos)
                                                                      ? Constants.showCupertinoAlertDialog(
                                                                          child: const Text(
                                                                              "You need to confirm the shift first."),
                                                                          context:
                                                                              context)
                                                                      : Get.snackbar(
                                                                          'Message',
                                                                          'You need to confirm the shift first.',
                                                                          duration:
                                                                              const Duration(milliseconds: 1200));
                                                                }
                                                              },
                                                            );
                                                          },
                                                          child: const SizedBox(
                                                            height: 40,
                                                            width: 40,
                                                            child: Center(
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .arrowUpRightFromSquare,
                                                                size: 18,
                                                                color:
                                                                    Colors.blue,
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
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ).copyWith(
                      bottom: (_isIos) ? 5.0 : 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 40.0) / 2,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: CupertinoColors.destructiveRed,
                            child: const Text(
                              "DECLINE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              if (controller.ifAcceptedShiftIsSelected
                                  .contains(true)) {
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
                                                  splashColor:
                                                      const Color.fromARGB(
                                                          255, 30, 89, 137),
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12,
                                                        horizontal: 20),
                                                    child: const Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              64,
                                                              160,
                                                              239)),
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
                                TextEditingController giveReasonController =
                                    TextEditingController();
                                int maxlines = 3;
                                (_isIos)
                                    ? showCupertinoDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: const Text("Decline Shift"),
                                            content: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height:
                                                      maxlines * 24.0 + 10.0,
                                                  child: Constants
                                                      .setReasonCupertinoTextField(
                                                    context: context,
                                                    controller:
                                                        giveReasonController,
                                                    maxlines: maxlines,
                                                    onChanged: controller
                                                        .setReasonErrorText,
                                                  ),
                                                ),
                                                //
                                                Obx(
                                                  () => Text(
                                                    controller
                                                        .getReasonErrorText
                                                        .value,
                                                    style: _textTheme.headline6,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: double.infinity,
                                                  child: CupertinoButton(
                                                    padding: EdgeInsets.zero,
                                                    color: CupertinoColors
                                                        .destructiveRed,
                                                    child: const Text(
                                                        "Decline Shift"),
                                                    onPressed: () {
                                                      if (giveReasonController
                                                          .text.isEmpty) {
                                                        controller
                                                            .setReasonErrorText(
                                                                giveReasonController
                                                                    .text);
                                                      } else {
                                                        Navigator.of(context)
                                                            .pop();
                                                        acceptOrDeclineStatusController.declineShift(
                                                            controller
                                                                .idOfSelectedItemsList,
                                                            startDate,
                                                            endDate,
                                                            giveReasonController
                                                                .text,
                                                            callback,
                                                            context);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: const Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        })
                                    : showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15)
                                                      .copyWith(
                                                    top: 20.0,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Constants
                                                          .declineShiftPopupTopRow(
                                                              context,
                                                              "Decline Shift"),
                                                      //Some Space
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Constants.textfieldWithCancelSuffixButton(
                                                          controller
                                                              .setReasonErrorText,
                                                          giveReasonController),
                                                      //
                                                      Obx(
                                                        () => Text(
                                                          controller
                                                              .getReasonErrorText
                                                              .value,
                                                          style: _textTheme
                                                              .headline6,
                                                        ),
                                                      ),
                                                      //
                                                      //Decline Shift Button
                                                      Constants
                                                          .materialRoundedButton(
                                                              baseColor: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  252,
                                                                  39,
                                                                  24),
                                                              highlightColor:
                                                                  Colors.amber,
                                                              splashColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      126,
                                                                      19,
                                                                      19),
                                                              onTapFunction:
                                                                  () {
                                                                if (giveReasonController
                                                                    .text
                                                                    .isEmpty) {
                                                                  controller.setReasonErrorText(
                                                                      giveReasonController
                                                                          .text);
                                                                } else {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  acceptOrDeclineStatusController.declineShift(
                                                                      controller
                                                                          .idOfSelectedItemsList,
                                                                      startDate,
                                                                      endDate,
                                                                      giveReasonController
                                                                          .text,
                                                                      callback,
                                                                      context);
                                                                }
                                                              },
                                                              buttonText:
                                                                  "Decline Shift"),
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
                              } else if (controller
                                  .idOfSelectedItemsList.isEmpty) {
                                (_isIos)
                                    ? Constants.showCupertinoAlertDialog(
                                        child: const Text(
                                            "Please select some values."),
                                        context: context)
                                    : Get.snackbar(
                                        'Message', 'Please select some values.',
                                        duration:
                                            const Duration(milliseconds: 1200));
                              } else {
                                (_isIos)
                                    ? Constants.showCupertinoAlertDialog(
                                        child: const Text(
                                            "Declined shift cannot be declined again."),
                                        context: context)
                                    : Get.snackbar('Message',
                                        'Declined shift cannot be declined again.',
                                        duration:
                                            const Duration(milliseconds: 1200));
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 40.0) / 2,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: const Color.fromARGB(255, 31, 224, 37),
                            child: const Text(
                              "ACCEPT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              if (!controller.ifAcceptedShiftIsSelected
                                      .contains(true) &&
                                  controller.idOfSelectedItemsList.isNotEmpty) {
                                acceptOrDeclineStatusController.acceptShift(
                                    controller.idOfSelectedItemsList, () {
                                  setState(() {
                                    controller.idOfSelectedItemsList.clear();
                                    controller.selectedItemsList.clear();
                                    controller.ifAcceptedShiftIsSelected
                                        .clear();
                                    controller.ifDeclinedShiftIsSelected
                                        .clear();
                                    _shiftData.setNextUrl(
                                        (_shiftData.getNextUrl).substring(
                                                0,
                                                ((_shiftData.getNextUrl)
                                                        .length -
                                                    10)) +
                                            nextScreenCurrentDate);
                                  });
                                }, context);
                              } else if (controller
                                  .idOfSelectedItemsList.isEmpty) {
                                (_isIos)
                                    ? Constants.showCupertinoAlertDialog(
                                        child: const Text(
                                            "Please select some values."),
                                        context: context)
                                    : Get.snackbar(
                                        'Message', 'Please select some values.',
                                        duration:
                                            const Duration(milliseconds: 1200));
                              } else {
                                (_isIos)
                                    ? Constants.showCupertinoAlertDialog(
                                        child: const Text(
                                            "Accepted shift cannot be accepted again."),
                                        context: context)
                                    : Get.snackbar('Message',
                                        'Accepted shift cannot be accepted again.',
                                        duration:
                                            const Duration(milliseconds: 1200));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : (_isIos)
              ? const CupertinoActivityIndicator(
                  radius: 20.0, color: Colors.black)
              : const CircularProgressIndicator(
                  color: Colors.blue,
                ),
    );
  }
}

class AcceptDeclineControllerNextScreen extends GetxController {
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
}

class NextScreenController extends GetxController {
  RxInt _valueInt = 0.obs;

  //getters and setters
  get getValueInt {
    return _valueInt.value;
  }

  setValueInt() {
    _valueInt.value++;
  }
}
