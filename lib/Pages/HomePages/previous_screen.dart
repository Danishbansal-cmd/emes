import 'dart:convert';
import 'package:emes/Providers/accept_decline_provider.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController declineShiftReasonController = TextEditingController();
  double shiftContainerHeight = 75;
  ShiftData _shiftData = ShiftData();

  @override
  Widget build(BuildContext context) {
    //initializing fisrstscreen getx controller
    final firstScreenController = Get.put(FirstScreenController());
    final _textTheme = Theme.of(context).textTheme;
    final _colorScheme = Theme.of(context).colorScheme;
    return Obx(
      () => firstScreenController.getValueInt > 0
          ? Container(
              color: _colorScheme.background,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: FutureBuilder(
                  future: _shiftData.getPreviousData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
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

                        // if we got our data
                      } else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        final shiftData = snapshot.data['allShifts'] as Map;
                        final keyList = shiftData.keys.toList();

                        return shiftData.isEmpty
                            ? Column(
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
                            : NotificationListener<
                                OverscrollIndicatorNotification>(
                                onNotification: (OverscrollIndicatorNotification
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
                                      height:
                                          (shiftContainerHeight * moreShifts +
                                                  16 * (moreShifts))
                                              .toDouble(),
                                      child: ListView.separated(
                                        physics: ClampingScrollPhysics(),
                                        // shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox.shrink(
                                              // height: 15,
                                              );
                                        },
                                        itemBuilder: (context, index2) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            height: shiftContainerHeight,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                                width: 1.5,
                                              ),
                                              color: _colorScheme.primary,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                // horizontal: 15,
                                                // vertical: 15,
                                                ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //data to be represented
                                                Expanded(
                                                  child: InkWell(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 3,
                                                          horizontal: 10),
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
            )
          : SizedBox.shrink(),
    );
  }
}

class FirstScreenController extends GetxController {
  RxInt _valueInt = 0.obs;

  //getters and setters
  get getValueInt {
    _valueInt.value;
  }

  setValueInt() {
    _valueInt.value++;
  }
}
