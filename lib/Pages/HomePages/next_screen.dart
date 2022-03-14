import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
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
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 90,
                      color: Colors.blue,
                    ),
                    const Text("No Shifts Found"),
                    Text(
                      '${snapshot.error} occured',
                    ),
                    // Text(snapshot.data['shift_title']),
                  ],
                );

                // if we got our data
              } else if (snapshot.hasData) {

                final shiftData;
                if(snapshot.data['allShifts'].runtimeType == List){
                  shiftData = snapshot.data['allShifts'] as List;
                }else {
                  shiftData = snapshot.data['allShifts'] as Map;
                }
                final keyList = shiftData.keys.toList();

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
                          // Text(snapshot.data['shift_title']),
                        ],
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: keyList.length,
                        itemBuilder: (context, index) {
                          var moreShifts = shiftData[keyList[index]].length;
                          return Container(
                            color: Colors.white,
                            height: (120 * moreShifts +
                                    (moreShifts > 1 ? 5 * (moreShifts - 1) : 0))
                                .toDouble(),
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification:
                                  (OverscrollIndicatorNotification overScroll) {
                                overScroll.disallowGlow();
                                return true;
                              },
                              child: ListView.separated(
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
                                              // const Icon(Icons.ad_units),
                                              Text(
                                                "Day:  ${Constants.nameOfDayOfShift(shiftData[keyList[index]][index2]['day_of_shift'])} (${shiftData[keyList[index]][index2]['work_date']})",
                                                style: _textTheme.headline3,
                                              ),
                                              Text(
                                                "Venue Name:  ${shiftData[keyList[index]][index2]['client_name']}",
                                                style: _textTheme.headline3,
                                              ),
                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "From:  ${shiftData[keyList[index]][index2]['time_on']}",
                                                    style: _textTheme.headline3,
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Text(
                                                    "To:  ${shiftData[keyList[index]][index2]['time_off']}",
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
                                              InkWell(
                                                onTap: () {
                                                  // AcceptOrDeclineStatus.acceptShift(
                                                  //     "${shiftData[keyList[index]][index2]['shift_id']}:${shiftData[keyList[index]][index2]['work_date']}:${shiftData[keyList[index]][index2]['user_id']}",
                                                  //     context);
                                                },
                                                child: Container(
                                                  width: 120,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.blue),
                                                  child: Text(
                                                    shiftData[keyList[index]]
                                                                    [index2][
                                                                'confirmed_by_staff'] ==
                                                            "1"
                                                        ? "Accepted"
                                                        : "Accept",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                child: Container(
                                                  width: 120,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.blue),
                                                  child: Text(
                                                    "Decline",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: moreShifts,
                              ),
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
