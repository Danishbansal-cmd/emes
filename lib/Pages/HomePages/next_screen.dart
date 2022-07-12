import 'package:emes/Pages/checkin_checkout_page.dart';
import 'package:emes/Pages/details_page_from_next_screen.dart';
import 'package:emes/Providers/accept_decline_provider.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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

  ShiftData _shiftData = ShiftData();

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
    // var date = HomepageDatesProvider();

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
                              final shiftData =
                                  snapshot.data['allShifts'] as Map;
                              final keyList = shiftData.keys.toList();
                              startDate = snapshot.data['start_date'];
                              endDate = snapshot.data['end_date'];

                              // print("start_date ${snapshot.data['start_date']}");
                              // print("end_date ${snapshot.data['end_date']}");
                              // date.setStartDate(snapshot.data['start_date']);
                              // date.setEndDate(snapshot.data['end_date']);

                              return shiftData.isEmpty
                                  ? Column(
                                      //if data is empty
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  : NotificationListener<
                                      OverscrollIndicatorNotification>(
                                      onNotification:
                                          (OverscrollIndicatorNotification
                                              overScroll) {
                                        overScroll.disallowGlow();
                                        return true;
                                      },
                                      child: ListView.separated(
                                        //first list and if data is not empty
                                        // shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox.shrink(
                                              // height: 15,
                                              );
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
                                              // shrinkWrap: true,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox.shrink(
                                                    // height: 15,
                                                    );
                                              },
                                              itemBuilder: (context, index2) {
                                                nextScreenCurrentDate =
                                                    shiftData[keyList[index]][
                                                            insideKeyList
                                                                    .toList()[
                                                                index2]]['loop']
                                                        ['M'];
                                                print(
                                                    "nextScreenCurrentDate $nextScreenCurrentDate");
                                                //main box of the shift
                                                return Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 8,
                                                  ),
                                                  height: shiftContainerHeight,
                                                  // padding: const EdgeInsets.symmetric(
                                                  //     // horizontal: 15,
                                                  //     // vertical: 15,
                                                  //     ),
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
                                                        () => Container(
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
                                                                        index]][insideKeyList
                                                                            .toList()[
                                                                        index2]]['confirmed_by_staff'] ==
                                                                    "1") {
                                                                  controller
                                                                      .ifAcceptedShiftIsSelected
                                                                      .add(
                                                                          true);
                                                                } else if (shiftData[
                                                                        keyList[index]][insideKeyList
                                                                            .toList()[
                                                                        index2]]['confirmed_by_staff'] ==
                                                                    "2") {
                                                                  controller
                                                                      .ifDeclinedShiftIsSelected
                                                                      .add(
                                                                          true);
                                                                }
                                                                print(
                                                                    "acceptedshiftisseleceted ${controller.ifAcceptedShiftIsSelected}");
                                                                print(
                                                                    "edclinedshiftisseleceted ${controller.ifDeclinedShiftIsSelected}");
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
                                                                        index]][insideKeyList
                                                                            .toList()[
                                                                        index2]]['confirmed_by_staff'] ==
                                                                    "1") {
                                                                  controller
                                                                      .ifAcceptedShiftIsSelected
                                                                      .remove(
                                                                          true);
                                                                } else if (shiftData[
                                                                        keyList[index]][insideKeyList
                                                                            .toList()[
                                                                        index2]]['confirmed_by_staff'] ==
                                                                    "2") {
                                                                  controller
                                                                      .ifDeclinedShiftIsSelected
                                                                      .remove(
                                                                          true);
                                                                }
                                                                print(
                                                                    "acceptedshiftisseleceted ${controller.ifAcceptedShiftIsSelected}");
                                                                print(
                                                                    "edclinedshiftisseleceted ${controller.ifDeclinedShiftIsSelected}");
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
                                                            // controller.clickedItemValue
                                                            //     .value = index;
                                                            if (!controller
                                                                .selectedItemsList
                                                                .contains(
                                                                    "$index$index2")) {
                                                              print(
                                                                  "does i work ");
                                                              print(index);
                                                              controller
                                                                  .addSelectedItemsList(
                                                                      "$index$index2");
                                                              controller
                                                                  .addIdOfSelectedItemsList(
                                                                      "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['user_id']}");
                                                              if (shiftData[keyList[
                                                                      index]][insideKeyList
                                                                          .toList()[
                                                                      index2]]['confirmed_by_staff'] ==
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
                                                                          index2]]['confirmed_by_staff'] ==
                                                                  "2") {
                                                                controller
                                                                    .ifDeclinedShiftIsSelected
                                                                    .add(true);
                                                              }
                                                              print(
                                                                  "acceptedshiftisseleceted ${controller.ifAcceptedShiftIsSelected}");
                                                              print(
                                                                  "edclinedshiftisseleceted ${controller.ifDeclinedShiftIsSelected}");
                                                              // controller.forDeletionOfSelectedItemsList["$index$index2"] = [snapshot.data['start_date'], snapshot.data['end_date'],];
                                                              print(
                                                                  "addsil ${controller.selectedItemsList}");
                                                              print(
                                                                  "addiosil ${controller.idOfSelectedItemsList}");
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
                                                                      index]][insideKeyList
                                                                          .toList()[
                                                                      index2]]['confirmed_by_staff'] ==
                                                                  "1") {
                                                                controller
                                                                    .ifAcceptedShiftIsSelected
                                                                    .remove(
                                                                        true);
                                                              } else if (shiftData[
                                                                          keyList[
                                                                              index]]
                                                                      [
                                                                      insideKeyList
                                                                              .toList()[
                                                                          index2]]['confirmed_by_staff'] ==
                                                                  "2") {
                                                                controller
                                                                    .ifDeclinedShiftIsSelected
                                                                    .remove(
                                                                        true);
                                                              }
                                                              print(
                                                                  "acceptedshiftisseleceted ${controller.ifAcceptedShiftIsSelected}");
                                                              print(
                                                                  "edclinedshiftisseleceted ${controller.ifDeclinedShiftIsSelected}");
                                                              print(
                                                                  "delsil ${controller.selectedItemsList}");
                                                              print(
                                                                  "deliosil ${controller.idOfSelectedItemsList}");
                                                            }
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        3),
                                                            // color: Colors.green,
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
                                                                // const Icon(Icons.ad_units),
                                                                Text(
                                                                  "${Constants.nameOfDayOfShift(shiftData[keyList[index]][insideKeyList.toList()[index2]]['day_of_shift'])} ${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date'].substring(8, 10)}/${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date'].substring(5, 7)}/${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date'].substring(0, 4)}",
                                                                  style: _textTheme
                                                                      .headline3!
                                                                      .copyWith(
                                                                    color: shiftData[keyList[index]][insideKeyList.toList()[index2]]['confirmed_by_staff'] ==
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
                                                                          text:
                                                                              " TO "),
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

                                                                // if(shiftData[keyList[
                                                                //             index]][
                                                                //         insideKeyList
                                                                //                 .toList()[
                                                                //             index2]]['confirmed_by_staff'] ==
                                                                //     "1") {
                                                                Get.to(
                                                                    () =>
                                                                        DetailsPageFromNextScreen(),
                                                                    arguments: [
                                                                      {
                                                                        "shift_id":
                                                                            "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']}",
                                                                        "client_id":
                                                                            "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['client_id']}",
                                                                        "work_date":
                                                                            "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']}",
                                                                        "time_on":
                                                                            "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_on']}",
                                                                        "time_off":
                                                                            "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_off']}",
                                                                        "task_id":
                                                                            "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['task_id']}",
                                                                        "client_name":
                                                                            "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['client_name']}",
                                                                        "activity_name":
                                                                            "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['activity_name']}",
                                                                        "day_of_shift":
                                                                            "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['day_of_shift']}"
                                                                      }
                                                                    ]);
                                                                // }
                                                                // else if (shiftData[keyList[
                                                                //                 index]][insideKeyList
                                                                //                     .toList()[
                                                                //                 index2]]
                                                                //             [
                                                                //             'is_confirm'] !=
                                                                //         "1" &&
                                                                //     shiftData[keyList[
                                                                //                 index]][
                                                                //             insideKeyList
                                                                //                     .toList()[
                                                                //                 index2]]['confirmed_by_staff'] ==
                                                                //         "1") {
                                                                //   Get.snackbar(
                                                                //       'Message',
                                                                //       'Shift is not confirmed from the backend.',
                                                                //       duration:
                                                                //           const Duration(
                                                                //               milliseconds:
                                                                //                   1200));
                                                                // }
                                                                // else if (shiftData[keyList[
                                                                //                 index]][
                                                                //             insideKeyList
                                                                //                     .toList()[
                                                                //                 index2]]
                                                                //         [
                                                                //         'confirmed_by_staff'] !=
                                                                //     "1") {
                                                                //   Get.snackbar(
                                                                //       'Message',
                                                                //       'You need to confirm the shift first.',
                                                                //       duration:
                                                                //           const Duration(
                                                                //               milliseconds:
                                                                //                   1200));
                                                                // }
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            // color: Colors.amber,
                                                            height: 40,
                                                            width: 40,
                                                            child: const Center(
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
                            child: CircularProgressIndicator(
                              color: _colorScheme.onSecondary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  //bottom accept or decline buttons
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Material(
                            color: Color.fromARGB(255, 252, 39, 24),
                            child: InkWell(
                              onTap: () {
                                print("decline");
                                // print(controller.ifDeclinedShiftIsSelected.value);
                                if (!controller.ifDeclinedShiftIsSelected
                                        .contains(true) &&
                                    controller
                                        .idOfSelectedItemsList.isNotEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController
                                          giveReasonController =
                                          TextEditingController();
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                          horizontal: 15)
                                                      .copyWith(
                                                top: 20.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Constants
                                                      .declineShiftPopupTopRow(
                                                          context),
                                                  //Some Space
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Constants
                                                      .textfieldWithCancelSuffixButton(
                                                          controller
                                                              .setReasonErrorText,
                                                          giveReasonController),
                                                  //
                                                  Obx(
                                                    () => Text(
                                                      controller
                                                          .getReasonErrorText
                                                          .value,
                                                      style:
                                                          _textTheme.headline6,
                                                    ),
                                                  ),
                                                  //
                                                  //Decline Shift Button
                                                  Constants
                                                      .materialRoundedButton(
                                                          baseColor: const Color
                                                                  .fromARGB(
                                                              255, 252, 39, 24),
                                                          highlightColor:
                                                              Colors.amber,
                                                          splashColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  126,
                                                                  19,
                                                                  19),
                                                          onTapFunction: () {
                                                            if (giveReasonController
                                                                .text.isEmpty) {
                                                              controller
                                                                  .setReasonErrorText(
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
                                  Get.snackbar(
                                      'Message', 'Please select some values.',
                                      duration:
                                          const Duration(milliseconds: 1200));
                                } else {
                                  Get.snackbar('Message',
                                      'Declined shift cannot be declined again.',
                                      duration:
                                          const Duration(milliseconds: 1200));
                                }
                                // controller.idOfSelectedItemsList.clear();
                                // controller.selectedItemsList.clear();
                              },
                              highlightColor: Colors.amber,
                              splashColor: Color.fromARGB(255, 126, 19, 19),
                              child: Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                    // color: Color.fromARGB(255, 252, 39, 24),
                                    ),
                                child: const Center(
                                  child: Text(
                                    "DECLINE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Color.fromARGB(255, 31, 224, 37),
                            child: InkWell(
                              onTap: () {
                                print("accept");
                                if (!controller.ifAcceptedShiftIsSelected
                                        .contains(true) &&
                                    controller
                                        .idOfSelectedItemsList.isNotEmpty) {
                                  print("first");
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
                                  Get.snackbar(
                                      'Message', 'Please select some values.',
                                      duration:
                                          const Duration(milliseconds: 1200));
                                } else {
                                  Get.snackbar('Message',
                                      'Accepted shift cannot be accepted again.',
                                      duration:
                                          const Duration(milliseconds: 1200));
                                }

                                // if (controller.selectedItemsList.isNotEmpty) {
                                //   setState(() {});
                                // }
                              },
                              splashColor: Color.fromARGB(255, 27, 126, 30),
                              highlightColor: Colors.amber,
                              child: Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                    // color: Color.fromARGB(255, 36, 255, 43),
                                    ),
                                child: const Center(
                                  child: Text(
                                    "ACCEPT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SizedBox.shrink(),
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
