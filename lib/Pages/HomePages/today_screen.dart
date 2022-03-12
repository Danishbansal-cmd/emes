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
                          return SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: keyList.length,
                        itemBuilder: (context, index) {
                          // return ListTile(
                          //   tileColor: Colors.amber,
                          //   leading: const Icon(Icons.ad_units),
                          //   trailing: Column(children: [
                          //     RaisedButton(onPressed: (){},child: Text("Accept"),),
                          //     RaisedButton(onPressed: (){},child: Text("Decline"),),
                          //   ],),
                          //   title: Text("List item ${shiftData[keyList[index]][0]['UserAllowShiftID']}"),

                          // );
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 86,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    color: Colors.amber,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // const Icon(Icons.ad_units),
                                        Text(
                                          "Day:  ${Constants.nameOfDayOfShift(shiftData[keyList[index]][0]['day_of_shift'])}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                            "Venue Name:  ${shiftData[keyList[index]][0]['client_name']}"),
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "From:  ${shiftData[keyList[index]][0]['time_on']}"),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                                "To:  ${shiftData[keyList[index]][0]['time_off']}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      RaisedButton(
                                        onPressed: () {},
                                        child: Text("Accept"),
                                      ),
                                      RaisedButton(
                                        onPressed: () {},
                                        child: Text("Decline"),
                                      ),
                                    ],
                                  ),
                                )
                              ],
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
