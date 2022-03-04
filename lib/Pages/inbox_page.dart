import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title:const Text("Messages"),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
          child: Text("Inbox page bro"),
        ),
      ),
    );
  }
}
