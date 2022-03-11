import 'dart:convert';

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
                final shiftData = snapshot.data['allShifts'] as List;

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
                    : ListView.builder(
                        itemCount: shiftData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.ad_units),
                            trailing: const Text("HEY"),
                            title: Text("List item $index"),
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
