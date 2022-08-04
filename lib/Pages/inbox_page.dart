import 'dart:convert';
import 'package:emes/Pages/message_chat.dart';
import 'package:emes/Utils/configure_platform.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:emes/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  //app level initializing mainPage controller
  final controller = Get.put(MainPageController());
  final ConfigurePlatform _configurePlatform = ConfigurePlatform();

  @override
  Widget build(BuildContext context) {
    bool _isIos = _configurePlatform.getConfigurePlatformBool;
    return (_isIos)
        ? Material(
            child: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                middle: Text(
                  "Messages",
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                  ),
                ),
              ),
              child: _CommonSafeAreaWidget(context: context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              // elevation: 0,
              title: const Text("Messages"),
            ),
            drawer: const MyDrawer(),
            body: _CommonSafeAreaWidget(context: context),
          );
  }

  Widget _CommonSafeAreaWidget({required BuildContext context}) {
    bool _isIos = _configurePlatform.getConfigurePlatformBool;
    return SafeArea(
      child: SizedBox(
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

                return ListView.builder(
                  physics: (_isIos)
                      ? const BouncingScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: CupertinoColors.inactiveGray,
                            width: 0.0,
                          ),
                          bottom: BorderSide(
                            color: CupertinoColors.inactiveGray,
                            width: 0.0,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Future.delayed(
                              const Duration(
                                milliseconds: 300,
                              ), () {
                            Navigator.push(
                              context,
                              (_isIos)
                                  ? CupertinoPageRoute(
                                      builder: (context) => MessageChatPage(
                                          adminId: chatAdminsList[index],
                                          adminName:
                                              chatAdmins['administrators']
                                                  [chatAdminsList[index]]),
                                    )
                                  : MaterialPageRoute(
                                      builder: (context) => MessageChatPage(
                                          adminId: chatAdminsList[index],
                                          adminName:
                                              chatAdmins['administrators']
                                                  [chatAdminsList[index]]),
                                    ),
                            );
                          });
                        },
                        child: Obx(
                          () => ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: chatAdminsList[index] == "1"
                                  ? const AssetImage("assets/trusecurity.png")
                                  : const AssetImage(""),
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
                      ),
                    );
                  },
                  itemCount: chatAdminsList.length,
                );
              }
            }
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
    );
  }

  Future<Map> getChatAdmins(BuildContext context) async {
    bool _isIos = _configurePlatform.getConfigurePlatformBool;
    var response = await http.get(
      Uri.parse(
          Constants.getCompanyURL + "/api/chat_admins/" + Constants.getStaffID),
    );
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 200) {
      return jsonData['data'];
    }
    if (jsonData['status'] == 401) {
      (_isIos)
          ? Constants.showCupertinoAlertDialog(
              child: const Text("No Chat Admin Found."), context: context)
          : ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No Chat Admin Found."),
              ),
            );
    }
    return jsonData['data'];
  }

  Future<Map> getChatMessages() async {
    var response = await http.get(
      Uri.parse(Constants.getCompanyURL +
          "/api/chat/" +
          Constants.getStaffID +
          "/" +
          "1"),
    );
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 200) {
      return jsonData['data'] as Map;
    }
    return jsonData['data'] as Map;
  }
}

class InboxPageDataProvider {
  static Future<String> getInboxData(BuildContext context) async {
    var response = await http.get(
      Uri.parse(Constants.getCompanyURL +
          "/api/get_new_message_noti/" +
          Constants.getStaffID),
    );
    var jsonData = jsonDecode(response.body);
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
