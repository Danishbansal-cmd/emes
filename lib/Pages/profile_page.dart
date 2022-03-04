import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:const Text("My Profile"),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
          child: Text("profile page bro"),
        ),
      ),
    );
  }
}
