import 'dart:convert';

import 'package:emes/Pages/message_chat.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:emes/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  //app level initializing mainPage controller
  final controller = Get.put(MainPageController());


  @override
  Widget build(BuildContext context) {
    print("Afsasdfasdf");
    print("Afsasdfasdf");
    print("Afsasdfasdf");
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
              future: getChatAdmins(context),
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
                    final chatAdmins = snapshot.data as Map;
                    List chatAdminsList =
                        chatAdmins['administrators'].keys.toList();
                    print(chatAdmins['administrators']);

                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Future.delayed(
                                const Duration(
                                  milliseconds: 300,
                                ), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MessageChatPage(
                                      adminId: chatAdminsList[index],
                                      adminName: chatAdmins['administrators']
                                          [chatAdminsList[index]]),
                                ),
                              );
                            });
                            // Get.to(() => MessageChatPage(adminId: chatAdminsList[index],),
                            // );
                          },
                          child: Obx(
                            () => ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: chatAdminsList[index] == "1"
                                    ? AssetImage("assets/trusecurity.png")
                                    : AssetImage(""),
                              ),
                              title: Text(chatAdmins['administrators']
                                  [chatAdminsList[index]]),
                              subtitle: Text("ID: " + chatAdminsList[index]),
                              trailing: (controller.getNumberOfNotification >
                                          0) &&
                                      (chatAdminsList[index] == "1")
                                  ? Container(
                                      padding: const EdgeInsets.all(5.0),
                                      constraints: const BoxConstraints(
                                          minWidth: 25,
                                          maxWidth: 25,
                                          minHeight: 25,
                                          maxHeight: 25),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        controller.getNumberOfNotification
                                            .toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        );
                      },
                      itemCount: chatAdminsList.length,
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

  Future<Map> getChatAdmins(BuildContext context) async {
    print("Afsasdfasdf");
    var response = await http.get(
      Uri.parse(Constants.getChatAdmins + Constants.getStaffID),
    );

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData = jsonDecode(response.body);
    String sharedData = jsonEncode(jsonData['data']);
    if (jsonData['status'] == 200) {
      return jsonData['data'];
    }
    if (jsonData['status'] == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Notification Found."),
        ),
      );
    }
    return jsonData['data'];
  }

  Future<Map> getChatMessages() async {
    var response = await http.get(
      Uri.parse(Constants.getChatMessages + Constants.getStaffID + "/" + "1"),
    );
    print("this is the ahfasdf");
    // print(widget.adminId);
    var jsonData = jsonDecode(response.body);
    print(response);
    if (jsonData['status'] == 200) {
      print(jsonData['data']);
      return jsonData['data'] as Map;
    }
    return jsonData['data'] as Map;
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
