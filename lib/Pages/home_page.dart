import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Container(
          child:const Center(
            child: Text("Nothing to show now"),
          ),
        ),
      ),
    );
  }
}
