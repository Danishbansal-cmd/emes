import 'dart:convert';

import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LicenseQualificationScreen extends StatelessWidget {
  const LicenseQualificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final _colorScheme = Theme.of(context).colorScheme;
    return Container(
      child: FutureBuilder(
          future: getLicenceData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If we get an error becuase of network
              if (snapshot.hasError) {
                return Text("Connection Error");
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                final licenseData = snapshot.data as Map;
                final keyList = licenseData.keys.toList();
                print("this is the keyLIst $keyList");

                return keyList.isEmpty
                    ? Text("No License Available")
                    : ListView.builder(
                        itemCount: keyList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(licenseData[keyList[index]]
                                    ['category_name']),
                                subtitle: Text(
                                    licenseData[keyList[index]]['licence_no']),
                                trailing: Text(
                                    licenseData[keyList[index]]['expiry_date']),
                              ),
                            ),
                          );
                        },
                      );
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            //on fetching data from the server or link or api
            return Center(
              child: CircularProgressIndicator(
                color: _colorScheme.onSecondary,
              ),
            );
          }),
    );
  }

  Future<Map<dynamic, dynamic>> getLicenceData() async {
    var response = await http.get(Uri.parse(
        Constants.getCompanyURL + "/api/get_user_licenses/" +
            Constants.getStaffID));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == 200) {
      return jsonResponse['data'];
    } else {
      return {"message": "No Data Found"};
    }
  }
}
