import 'dart:convert';

import 'package:emes/Utils/constants.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: const Text("Messages"),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: InboxPageDataProvider.getInboxData(context),
              builder: (context, snapshot) {
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
                        Text("${snapshot.error} occured"),
                      ],
                    );
                  } else if (snapshot.hasData) {
                    final inboxData = snapshot.data as String;

                    return Center(
                      child: Text(
                        inboxData == "0" ? "Found Nothing" : inboxData,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                );
              },
            )),
      ),
    );
  }
}

class InboxPageDataProvider {
  static Future<String> getInboxData(BuildContext context) async {
    var response = await http.get(
      Uri.parse(Constants.getInboxPageUrl + Constants.getStaffID),
    );

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData = jsonDecode(response.body);
    String sharedData = jsonEncode(jsonData['data']);
    if (jsonData['status'] == 200) {}
    if (jsonData['status'] == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Notification Found."),
        ),
      );
    }
    return jsonData['data'].toString();
  }
}
