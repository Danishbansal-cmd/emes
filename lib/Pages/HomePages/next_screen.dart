import 'package:emes/Providers/accept_decline_provider.dart';
import 'package:emes/Providers/homepage_dates_provider.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  TextEditingController declineShiftReasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    // var date = HomepageDatesProvider();
    return Container(
      // color: Colors.red,
      child: Center(
        child: FutureBuilder(
          future: ShiftData.getNextData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 90,
                      color: Colors.blue,
                    ),
                    Text("No Shifts Found"),
                  ],
                );

                // if we got our data
              } else if (snapshot.hasData) {
                final shiftData = snapshot.data['allShifts'] as Map;
                final keyList = shiftData.keys.toList();
                print("start_date ${snapshot.data['start_date']}");
                print("end_date ${snapshot.data['end_date']}");
                // date.setStartDate(snapshot.data['start_date']);
                // date.setEndDate(snapshot.data['end_date']);

                return shiftData.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 90,
                            color: Colors.blue,
                          ),
                          const Text("No Shifts Found"),
                          Text(snapshot.data['shift_title']),
                        ],
                      )
                    : ListView.separated(
                        // shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: keyList.length,
                        itemBuilder: (context, index) {
                          var moreShifts = shiftData[keyList[index]].length;
                          var insideKeyList = shiftData[keyList[index]].keys;
                          return Container(
                            color: Colors.white,
                            height: (120 * moreShifts +
                                    (moreShifts > 1 ? 5 * (moreShifts - 1) : 0))
                                .toDouble(),
                            child: ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              // shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 5,
                                );
                              },
                              itemBuilder: (context, index2) {
                                return Container(
                                  height: 120,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15,
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 90,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${Constants.nameOfDayOfShift(shiftData[keyList[index]][insideKeyList.toList()[index2]]['day_of_shift'])} (${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']})",
                                              style: _textTheme.headline3,
                                            ),
                                            Text(
                                              "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['client_name']}",
                                              style: _textTheme.headline3,
                                            ),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "From:  ${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_on']}",
                                                  style: _textTheme.headline3,
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Text(
                                                  "To:  ${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_off']}",
                                                  style: _textTheme.headline3,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 90,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Consumer<AcceptOrDeclineStatus>(
                                              builder: (context,
                                                  appLevelAcceptOrDeclineStatus,
                                                  _) {
                                                return InkWell(
                                                  onTap: () {
                                                    if (shiftData[keyList[
                                                                    index]][
                                                                insideKeyList
                                                                        .toList()[
                                                                    index2]][
                                                            'confirmed_by_staff'] !=
                                                        "1") {
                                                      appLevelAcceptOrDeclineStatus
                                                          .acceptShift(
                                                              "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['user_id']}",
                                                              context);
                                                      setState(() {
                                                        ShiftData.setNextUrl((ShiftData
                                                                    .getNextUrl)
                                                                .substring(
                                                                    0,
                                                                    ((ShiftData.getNextUrl)
                                                                            .length -
                                                                        10)) +
                                                            shiftData[keyList[
                                                                        index]][
                                                                    insideKeyList
                                                                        .toList()[index2]]
                                                                ['loop']['M']);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.blue),
                                                    child: Text(
                                                      // appLevelAcceptOrDeclineStatus
                                                      //     .getAcceptButtonText,
                                                      shiftData[keyList[index]][
                                                                      insideKeyList
                                                                              .toList()[
                                                                          index2]]
                                                                  [
                                                                  'confirmed_by_staff'] ==
                                                              "1"
                                                          ? "Accepted"
                                                          : "Accept",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (shiftData[keyList[index]][
                                                            insideKeyList
                                                                    .toList()[
                                                                index2]][
                                                        'confirmed_by_staff'] !=
                                                    "2") {
                                                  declineShiftReasonController
                                                      .text = "";
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              height: 220,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 15,
                                                                vertical: 20,
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  //
                                                                  //
                                                                  //Reason Field
                                                                  const Text(
                                                                      "Give Reason"),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Container(
                                                                    height: 100,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    child: Consumer<
                                                                        AcceptOrDeclineStatus>(
                                                                      builder: (context,
                                                                          appLevelAcceptOrDeclineStatus,
                                                                          _) {
                                                                        return TextField(
                                                                          onChanged:
                                                                              (value) {
                                                                            appLevelAcceptOrDeclineStatus.setDeclineReasonErrorText(value);
                                                                          },
                                                                          controller:
                                                                              declineShiftReasonController,
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            hintText:
                                                                                "Type Reason Here...",
                                                                            border:
                                                                                InputBorder.none,
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Consumer<
                                                                      AcceptOrDeclineStatus>(
                                                                    builder:
                                                                        (context,
                                                                            appLevelAcceptOrDeclineStatus,
                                                                            _) {
                                                                      return Text(
                                                                        appLevelAcceptOrDeclineStatus
                                                                            .getDeclineReasonErrorText,
                                                                        style: _textTheme
                                                                            .headline6,
                                                                      );
                                                                    },
                                                                  ),
                                                                  //
                                                                  //
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  //
                                                                  //
                                                                  Material(
                                                                    color: Colors
                                                                        .blue,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                    child: Consumer<
                                                                        AcceptOrDeclineStatus>(
                                                                      builder: (context,
                                                                          appLevelAcceptOrDeclineStatus,
                                                                          _) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            appLevelAcceptOrDeclineStatus.setDeclineReasonErrorText(declineShiftReasonController.text);
                                                                            print("decline shift works first");
                                                                            if (declineShiftReasonController.text.isNotEmpty) {
                                                                              print("decline shift works");
                                                                              print(shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']);
                                                                              appLevelAcceptOrDeclineStatus.declineShift(shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id'], shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date'], snapshot.data['start_date'], snapshot.data['end_date'], declineShiftReasonController.text, context);
                                                                            }
                                                                            setState(() {
                                                                              ShiftData.setNextUrl((ShiftData.getNextUrl).substring(0, ((ShiftData.getNextUrl).length - 10)) + shiftData[keyList[index]][insideKeyList.toList()[index2]]['loop']['M']);
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                35,
                                                                            child:
                                                                                const Center(
                                                                              child: Text(
                                                                                "Decline Shift",
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Colors.white,
                                                                                  letterSpacing: 1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              child: Consumer<
                                                  AcceptOrDeclineStatus>(
                                                builder: (context,
                                                    appLevelAcceptOrDeclineStatus,
                                                    _) {
                                                  return Container(
                                                    width: 100,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.blue),
                                                    child: Text(
                                                      // appLevelAcceptOrDeclineStatus
                                                      //     .getDeclineButtonText,
                                                      shiftData[keyList[index]][
                                                                      insideKeyList
                                                                              .toList()[
                                                                          index2]]
                                                                  [
                                                                  'confirmed_by_staff'] ==
                                                              "2"
                                                          ? "Declined"
                                                          : "Decline",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
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
                      );
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
