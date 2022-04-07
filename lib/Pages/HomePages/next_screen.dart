import 'package:emes/Providers/accept_decline_provider.dart';
import 'package:emes/Providers/homepage_dates_provider.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  TextEditingController declineShiftReasonController = TextEditingController();
  double shiftContainerHeight = 75;

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final _colorScheme = Theme.of(context).colorScheme;
    // var date = HomepageDatesProvider();
    return Container(
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
                future: ShiftData.getNextData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
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
                           SizedBox(height: 5,),
                          Text("No Shifts Found"),
                        ],
                      );

                      // if we get our data
                    } else if (snapshot.hasData) {
                      final shiftData = snapshot.data['allShifts'] as Map;
                      final keyList = shiftData.keys.toList();
                      // print("start_date ${snapshot.data['start_date']}");
                      // print("end_date ${snapshot.data['end_date']}");
                      // date.setStartDate(snapshot.data['start_date']);
                      // date.setEndDate(snapshot.data['end_date']);

                      return shiftData.isEmpty
                          ? Column( //if data is empty
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                            FontAwesomeIcons.calendarDays,
                            size: 70,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 5,),
                                const Text("No Shifts Found"),
                                Text(snapshot.data['shift_title']),
                              ],
                            )

                          : ListView.separated( //first list and if data is not empty
                              // shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 15,
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
                                  height: (shiftContainerHeight * moreShifts +
                                          (moreShifts > 1
                                              ? 15 * (moreShifts - 1)
                                              : 0))
                                      .toDouble(),
                                  child: ListView.separated( //nested second list
                                    physics: const ClampingScrollPhysics(),
                                    // shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 15,
                                      );
                                    },
                                    itemBuilder: (context, index2) {
                                      //main box of the shift
                                      return Container(
                                        height: shiftContainerHeight,
                                        padding: const EdgeInsets.symmetric(
                                            // horizontal: 15,
                                            // vertical: 15,
                                            ),
                                        decoration: BoxDecoration(
                                          color: _colorScheme.primary,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // SizedBox(
                                            //   height: 90,
                                            //   child: Column(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.spaceBetween,
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.start,
                                            //     children: [
                                            //       Text(
                                            //         "${Constants.nameOfDayOfShift(shiftData[keyList[index]][insideKeyList.toList()[index2]]['day_of_shift'])} (${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']})",
                                            //         style: _textTheme.headline3,
                                            //       ),
                                            //       Text(
                                            //         "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['client_name']}",
                                            //         style: _textTheme.headline3,
                                            //       ),
                                            //       Row(
                                            //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //         children: [
                                            //           Text(
                                            //             "From:  ${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_on']}",
                                            //             style: _textTheme.headline3,
                                            //           ),
                                            //           const SizedBox(
                                            //             width: 30,
                                            //           ),
                                            //           Text(
                                            //             "To:  ${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_off']}",
                                            //             style: _textTheme.headline3,
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),

                                            //checkbox button
                                            Container(
                                              width: 35,
                                              child: Checkbox(
                                                onChanged: (value) {
                                                  // value = !value!;
                                                },
                                                value: false,
                                                shape: const CircleBorder(),
                                              ),
                                            ),

                                            //data to be represented
                                            Expanded(
                                              child: InkWell(
                                                onTap: (){},
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3),
                                                  // color: Colors.green,
                                                  height: shiftContainerHeight,
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
                                                          color: shiftData[keyList[
                                                                          index]][insideKeyList
                                                                              .toList()[
                                                                          index2]][
                                                                      'confirmed_by_staff'] ==
                                                                  "1"
                                                              ? const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  54,
                                                                  192,
                                                                  59)
                                                              : const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  34,
                                                                  34,
                                                                  34),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['client_name']}",
                                                        style: _textTheme
                                                            .headline4,
                                                      ),

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
                                                      // Row(
                                                      //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      //   children: [
                                                      //     Text(
                                                      //       "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_on']}",
                                                      //       style: _textTheme.headline4,
                                                      //     ),
                                                      //     const SizedBox(
                                                      //       width: 30,
                                                      //     ),
                                                      //     Text(
                                                      //       "To:  ${shiftData[keyList[index]][insideKeyList.toList()[index2]]['time_off']}",
                                                      //       style: _textTheme.headline3,
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // Container(
                                            //   height: shiftContainerHeight,
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           vertical: 5),
                                            //   child: Column(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment
                                            //             .spaceBetween,
                                            //     children: [
                                            //       Consumer<
                                            //           AcceptOrDeclineStatus>(
                                            //         builder: (context,
                                            //             appLevelAcceptOrDeclineStatus,
                                            //             _) {
                                            //           return InkWell(
                                            //             onTap: () {
                                            //               if (shiftData[keyList[
                                            //                               index]]
                                            //                           [
                                            //                           insideKeyList
                                            //                                   .toList()[
                                            //                               index2]]
                                            //                       [
                                            //                       'confirmed_by_staff'] !=
                                            //                   "1") {
                                            //                 appLevelAcceptOrDeclineStatus
                                            //                     .acceptShift(
                                            //                         "${shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date']}:${shiftData[keyList[index]][insideKeyList.toList()[index2]]['user_id']}",
                                            //                         context);
                                            //                 setState(() {
                                            //                   ShiftData.setNextUrl((ShiftData
                                            //                               .getNextUrl)
                                            //                           .substring(
                                            //                               0,
                                            //                               ((ShiftData.getNextUrl).length -
                                            //                                   10)) +
                                            //                       shiftData[keyList[
                                            //                           index]][insideKeyList
                                            //                               .toList()[
                                            //                           index2]]['loop']['M']);
                                            //                 });
                                            //               }
                                            //             },
                                            //             child: Container(
                                            //               width: 100,
                                            //               padding:
                                            //                   const EdgeInsets
                                            //                           .symmetric(
                                            //                       vertical: 10),
                                            //               decoration: BoxDecoration(
                                            //                   borderRadius:
                                            //                       BorderRadius
                                            //                           .circular(
                                            //                               5),
                                            //                   color:
                                            //                       Colors.blue),
                                            //               child: Text(
                                            //                 // appLevelAcceptOrDeclineStatus
                                            //                 //     .getAcceptButtonText,
                                            //                 shiftData[keyList[
                                            //                             index]][insideKeyList
                                            //                                 .toList()[
                                            //                             index2]]['confirmed_by_staff'] ==
                                            //                         "1"
                                            //                     ? "Accepted"
                                            //                     : "Accept",
                                            //                 textAlign: TextAlign
                                            //                     .center,
                                            //               ),
                                            //             ),
                                            //           );
                                            //         },
                                            //       ),
                                            //       InkWell(
                                            //         onTap: () {
                                            //           if (shiftData[keyList[
                                            //                           index]][
                                            //                       insideKeyList
                                            //                               .toList()[
                                            //                           index2]][
                                            //                   'confirmed_by_staff'] !=
                                            //               "2") {
                                            //             declineShiftReasonController
                                            //                 .text = "";
                                            //             showDialog(
                                            //               context: context,
                                            //               builder: (context) {
                                            //                 return Dialog(
                                            //                   backgroundColor:
                                            //                       Colors
                                            //                           .transparent,
                                            //                   child: Stack(
                                            //                     children: [
                                            //                       Container(
                                            //                         height: 220,
                                            //                         decoration:
                                            //                             BoxDecoration(
                                            //                           borderRadius:
                                            //                               BorderRadius.circular(
                                            //                                   5),
                                            //                           color: Theme.of(
                                            //                                   context)
                                            //                               .colorScheme
                                            //                               .primary,
                                            //                         ),
                                            //                         padding:
                                            //                             const EdgeInsets
                                            //                                 .symmetric(
                                            //                           horizontal:
                                            //                               15,
                                            //                           vertical:
                                            //                               20,
                                            //                         ),
                                            //                         child:
                                            //                             Column(
                                            //                           mainAxisAlignment:
                                            //                               MainAxisAlignment
                                            //                                   .start,
                                            //                           crossAxisAlignment:
                                            //                               CrossAxisAlignment
                                            //                                   .start,
                                            //                           children: [
                                            //                             //
                                            //                             //
                                            //                             //Reason Field
                                            //                             const Text(
                                            //                                 "Give Reason"),
                                            //                             const SizedBox(
                                            //                               height:
                                            //                                   5,
                                            //                             ),
                                            //                             Container(
                                            //                               height:
                                            //                                   100,
                                            //                               padding:
                                            //                                   const EdgeInsets.symmetric(horizontal: 10),
                                            //                               decoration:
                                            //                                   BoxDecoration(
                                            //                                 borderRadius:
                                            //                                     BorderRadius.circular(
                                            //                                   5,
                                            //                                 ),
                                            //                                 border:
                                            //                                     Border.all(
                                            //                                   color: Colors.grey,
                                            //                                   width: 2,
                                            //                                 ),
                                            //                               ),
                                            //                               child:
                                            //                                   Consumer<AcceptOrDeclineStatus>(
                                            //                                 builder: (context,
                                            //                                     appLevelAcceptOrDeclineStatus,
                                            //                                     _) {
                                            //                                   return TextField(
                                            //                                     cursorColor: Colors.grey,
                                            //                                     onChanged: (value) {
                                            //                                       appLevelAcceptOrDeclineStatus.setDeclineReasonErrorText(value);
                                            //                                     },
                                            //                                     controller: declineShiftReasonController,
                                            //                                     decoration: const InputDecoration(
                                            //                                       hintText: "Type Reason Here...",
                                            //                                       border: InputBorder.none,
                                            //                                     ),
                                            //                                   );
                                            //                                 },
                                            //                               ),
                                            //                             ),
                                            //                             Consumer<
                                            //                                 AcceptOrDeclineStatus>(
                                            //                               builder: (context,
                                            //                                   appLevelAcceptOrDeclineStatus,
                                            //                                   _) {
                                            //                                 return Text(
                                            //                                   appLevelAcceptOrDeclineStatus.getDeclineReasonErrorText,
                                            //                                   style: _textTheme.headline6,
                                            //                                 );
                                            //                               },
                                            //                             ),
                                            //                             //
                                            //                             //
                                            //                             const SizedBox(
                                            //                               height:
                                            //                                   10,
                                            //                             ),
                                            //                             //
                                            //                             //
                                            //                             Material(
                                            //                               color:
                                            //                                   Colors.blue,
                                            //                               borderRadius:
                                            //                                   BorderRadius.circular(
                                            //                                 50,
                                            //                               ),
                                            //                               child:
                                            //                                   Consumer<AcceptOrDeclineStatus>(
                                            //                                 builder: (context,
                                            //                                     appLevelAcceptOrDeclineStatus,
                                            //                                     _) {
                                            //                                   return InkWell(
                                            //                                     onTap: () {
                                            //                                       appLevelAcceptOrDeclineStatus.setDeclineReasonErrorText(declineShiftReasonController.text);
                                            //                                       print("decline shift works first");
                                            //                                       if (declineShiftReasonController.text.isNotEmpty) {
                                            //                                         print("decline shift works");
                                            //                                         print(shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id']);
                                            //                                         appLevelAcceptOrDeclineStatus.declineShift(shiftData[keyList[index]][insideKeyList.toList()[index2]]['shift_id'], shiftData[keyList[index]][insideKeyList.toList()[index2]]['work_date'], snapshot.data['start_date'], snapshot.data['end_date'], declineShiftReasonController.text, context);
                                            //                                       }
                                            //                                       if (declineShiftReasonController.text.isNotEmpty) {
                                            //                                         setState(() {
                                            //                                           ShiftData.setNextUrl((ShiftData.getNextUrl).substring(0, ((ShiftData.getNextUrl).length - 10)) + shiftData[keyList[index]][insideKeyList.toList()[index2]]['loop']['M']);
                                            //                                         });
                                            //                                       }
                                            //                                     },
                                            //                                     child: Container(
                                            //                                       width: double.infinity,
                                            //                                       height: 35,
                                            //                                       child: const Center(
                                            //                                         child: Text(
                                            //                                           "Decline Shift",
                                            //                                           style: TextStyle(
                                            //                                             fontWeight: FontWeight.bold,
                                            //                                             color: Colors.white,
                                            //                                             letterSpacing: 1,
                                            //                                           ),
                                            //                                         ),
                                            //                                       ),
                                            //                                     ),
                                            //                                   );
                                            //                                 },
                                            //                               ),
                                            //                             ),
                                            //                           ],
                                            //                         ),
                                            //                       ),
                                            //                     ],
                                            //                   ),
                                            //                 );
                                            //               },
                                            //             );
                                            //           }
                                            //         },
                                            //         child: Consumer<
                                            //             AcceptOrDeclineStatus>(
                                            //           builder: (context,
                                            //               appLevelAcceptOrDeclineStatus,
                                            //               _) {
                                            //             return Container(
                                            //               width: 100,
                                            //               padding:
                                            //                   const EdgeInsets
                                            //                           .symmetric(
                                            //                       vertical: 10),
                                            //               decoration: BoxDecoration(
                                            //                   borderRadius:
                                            //                       BorderRadius
                                            //                           .circular(
                                            //                               5),
                                            //                   color:
                                            //                       Colors.blue),
                                            //               child: Text(
                                            //                 // appLevelAcceptOrDeclineStatus
                                            //                 //     .getDeclineButtonText,
                                            //                 shiftData[keyList[
                                            //                             index]][insideKeyList
                                            //                                 .toList()[
                                            //                             index2]]['confirmed_by_staff'] ==
                                            //                         "2"
                                            //                     ? "Declined"
                                            //                     : "Decline",
                                            //                 textAlign: TextAlign
                                            //                     .center,
                                            //               ),
                                            //             );
                                            //           },
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          
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
                      onTap: (){
                        print("decline");
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
                    color: Color.fromARGB(255, 36, 255, 43),
                    child: InkWell(
                      onTap: (){},
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
    );
  }
}
