import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';

class ApplyLeavePage extends StatelessWidget {
  const ApplyLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title:const Text("My Leave"),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
          child: Text("Leave page bro gsdg"),
        ),
      ),
    );
  }
}
