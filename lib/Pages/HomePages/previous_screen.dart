
import 'package:emes/Utils/configure_platform.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController declineShiftReasonController = TextEditingController();
  double shiftContainerHeight = 75;
  final ShiftData _shiftData = ShiftData();
  final ConfigurePlatform _configurePlatform = ConfigurePlatform();
  @override
  Widget build(BuildContext context) {
    //initializing fisrstscreen getx controller
    final firstScreenController = Get.put(FirstScreenController());
    final _textTheme = Theme.of(context).textTheme;
    final _colorScheme = Theme.of(context).colorScheme;
    bool _isIos = _configurePlatform.getConfigurePlatformBool;
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

                        // if we got our data
                      } else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        final shiftData = snapshot.data['allShifts'] as Map;
                        final keyList = shiftData.keys.toList();

                        return shiftData.isEmpty
                            ?
                            //if data is empty
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                onNotification: (OverscrollIndicatorNotification
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
                                      height:
                                          (shiftContainerHeight * moreShifts +
                                                  16 * (moreShifts))
                                              .toDouble(),
                                      child: ListView.separated(
                                        physics: const ClampingScrollPhysics(),
                                        separatorBuilder: (context, index) {
                                          return const SizedBox.shrink();
                                        },
                                        itemBuilder: (context, index2) {
                                          var tempVar = shiftData[
                                                  keyList[index]]
                                              [insideKeyList.toList()[index2]];
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
                                            padding:
                                                const EdgeInsets.symmetric(),
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
                                                              color: tempVar
                                                                          [
                                                                          'confirmed_by_staff'] ==
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

class FirstScreenController extends GetxController {
  RxInt _valueInt = 0.obs;

  //getters and setters
  get getValueInt {
    return _valueInt.value;
  }

  setValueInt() {
    _valueInt.value++;
  }
}
