import 'dart:convert';

import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MessageChatPage extends StatefulWidget {
  String adminId;
  String adminName;
  MessageChatPage({Key? key, required this.adminId, required this.adminName}) : super(key: key);

  @override
  State<MessageChatPage> createState() => _MessageChatPageState();
}

class _MessageChatPageState extends State<MessageChatPage> {
  //intializing MessageChatPage getx controller
  TextEditingController sendMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Asfdadsf");
    print("Asfdadsf");
    print("Asfdadsf");
    print("Asfdadsf");
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              backgroundImage: widget.adminId == "1"
                                  ? AssetImage("assets/trusecurity.png")
                                  : AssetImage(""),
                            ),
                            
                            title: Text(widget.adminName),
                            // subtitle: Text("ID: " + chatAdminsList[index]),
                          ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: getChatMessages(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occured',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                final chatMessages = snapshot.data as Map;
                var chatMessagesData =
                    chatMessages['data']['messages'].keys.toList();
                print(chatMessages);
                print(chatMessagesData[0]);
                print(chatMessagesData.length);

                return ListView.builder(
                  itemBuilder: (context, index) {
                    print(index);
                    print(chatMessages['data']['messages']
                        [chatMessagesData[index]]['Message']['sender_id']);
                    print(chatMessages['data']['messages']
                            [chatMessagesData[index]]['Message']['sender_id']
                        .runtimeType);
                    return Padding(
                      // add some padding
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Align(
                        // align the child within the container
                        alignment: chatMessages['data']['messages']
                                        [chatMessagesData[index]]['Message']
                                    ['sender_id'] ==
                                "8"
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: DecoratedBox(
                          // chat bubble decoration
                          decoration: BoxDecoration(
                            color: chatMessages['data']['messages']
                                            [chatMessagesData[index]]['Message']
                                        ['sender_id'] ==
                                    "8"
                                ? Colors.blue
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text.rich(
                              TextSpan(
                                  text: chatMessages['data']['messages']
                                          [chatMessagesData[index]]['Message']
                                      ['msg_text'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: chatMessages['data']
                                                              ['messages'][
                                                          chatMessagesData[index]]
                                                      ['Message']['sender_id'] ==
                                                  "8"
                                              ? Colors.white
                                              : Colors.black87),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: "   " + (chatMessages['data']['messages']
                                              [chatMessagesData[index]]
                                          ['Message']['created']).substring(11,16),
                                      style: TextStyle(
                                        fontFeatures: [FontFeature.subscripts()],
                                        fontSize: 10,
                                        color: chatMessages['data']['messages'][
                                                        chatMessagesData[index]]
                                                    ['Message']['sender_id'] ==
                                                "8"
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: chatMessagesData.length,
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: MediaQuery.of(context).viewInsets,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(70),
                ),
                height: 45,
                padding: EdgeInsets.only(left: 25.0),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: TextField(
                  enableInteractiveSelection: false,
                  controller: sendMessageController,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type a message',
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (sendMessageController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Message cannot be empty"),
                    ),
                  );
                } else if (sendMessageController.text.isNotEmpty) {
                  sendMessage(sendMessageController.text);
                  sendMessageController.clear();
                  setState(() {
                    
                  });
                }
              },
              child: Container(
                width: 45,
                height: 45,
                margin: EdgeInsets.only(right: 5.0),
                padding: const EdgeInsets.only(left: 6.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map> getChatMessages() async {
    var response = await http.get(
      Uri.parse(
          Constants.getChatMessages + Constants.getStaffID + "/" + widget.adminId),
    );
    // print("this is the ahfasdf");
    // print(widget.adminId);
    var jsonData = jsonDecode(response.body);
    // print(response);
    if (jsonData['status'] == 200) {
      // print(jsonData['data']);
      return jsonData as Map;
    }
    return jsonData as Map;
  }

  Future<Map> sendMessage(String text) async {
    var response = await http.post(
        Uri.parse(
          Constants.getSendMessage,
        ),
        body: {
          "sender_id": Constants.getStaffID,
          "receiver_id": widget.adminId,
          "msg_text": text
        });
    // print("this is the ahfasdf");
    // print(widget.adminId);
    var jsonData = jsonDecode(response.body);
    // print(response);
    if (jsonData['status'] == 200) {
      // print(jsonData['data']);
      return jsonData as Map;
    }
    return jsonData as Map;
  }
}

// class MessageChatPageController extends GetxController {
//   var details = Get.arguments;
// }
