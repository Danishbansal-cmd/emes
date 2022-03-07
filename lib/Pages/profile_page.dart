import 'package:emes/Pages/ProfilePages/license_qualification_screen.dart';
import 'package:emes/Pages/ProfilePages/profile_screen.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // elevation: 0,
          title: const Text("My Profile"),
          bottom: TabBar(
            // labelPadding: EdgeInsets.all(0),
            // pinn

            // padding: EdgeInsets.symmetric(horizontal: 20),
            dragStartBehavior: DragStartBehavior.down,
            labelPadding:const EdgeInsets.symmetric(horizontal: 10.0),
            isScrollable: true,
            overlayColor: MaterialStateProperty.all(Colors.blue),
            labelColor: Colors.black,
            labelStyle:const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              fontSize: 16,
            ),
            tabs:const [
              Tab(
                text: 'PROFILE',
              ),
              Tab(
                text: 'LICENSE/QUALIFICATION',
              ),
            ],
          ),
        ),
        drawer: const MyDrawer(),
        body: const SafeArea(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [ProfileScreen(), LicenseQualificationScreen()],
          ),
        ),
      ),
    );
  }
}
