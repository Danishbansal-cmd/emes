import 'dart:convert';

import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondScreen extends StatelessWidget {
  SecondScreen({Key? key}) : super(key: key);

  // Future<Map<dynamic, dynamic>> getData() async {
  //   var response = await http.post(
  //     Uri.parse(
  //       "http://trusecurity.emesau.com/dev/api/getshift",
  //     ),body: {"staff_id":"8"}
  //   );
  //   var jsonData = jsonDecode(response.body);
  //   Map<dynamic, dynamic> data = jsonData['data'];
  //   return data;
  // }

  // Future<String> getData2() async {
  //   return Future.delayed(
  //     Duration(seconds: 2),
  //     () {
  //       return "I am data";
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Container(
      // color: Colors.red,
      child: Center(
        child: FutureBuilder(
          future: ShiftData.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occured',
                    style: TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                // final data = snapshot.data as String;
                final shiftData = snapshot.data['allShifts'] as Map;
                final keyList = shiftData.keys.toList();
                print("start_date ${snapshot.data['start_date']}");

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
                            height: (120 * moreShifts + (moreShifts > 1 ? 5 * (moreShifts - 1) : 0 )).toDouble(),
                            child: NotificationListener<OverscrollIndicatorNotification>(
                              onNotification: (OverscrollIndicatorNotification overScroll){
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
                                      horizontal: 15,vertical: 15,
                                      
                                    ),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  AcceptOrDeclineStatus.acceptShift("${shiftData[keyList[index]][index2]['shift_id']}:${shiftData[keyList[index]][index2]['work_date']}:${shiftData[keyList[index]][index2]['user_id']}",context);
                                                },
                                                child: Container(
                                                  width: 120,
                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.blue),
                                                  child: Text(shiftData[keyList[index]][index2]['confirmed_by_staff'] == "1" ? "Accepted" : "Accept",textAlign: TextAlign.center,),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  
                                                },
                                                child: Container(
                                                  width: 120,
                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.blue),
                                                  child: Text(shiftData[keyList[index]][index2]['confirmed_by_staff'] == "2" ? "Declined" : "Decline",textAlign: TextAlign.center,),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class AcceptOrDeclineStatus {
  static String _acceptUrl = "http://trusecurity.emesau.com/dev/api/confirm_roster";

  static acceptShift(String value,BuildContext context) async {
    var response =
        await http.post(Uri.parse(_acceptUrl), body: {"rosterInfo": value});
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Shift Confirmed"),
        ),
      );
    }
    if (jsonData['status'] == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not Accepted"),
        ),
      );
    }
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("Server Error"),
    //     ),
    //   );
    // }
  }
}

class shiftListingVariables {}
