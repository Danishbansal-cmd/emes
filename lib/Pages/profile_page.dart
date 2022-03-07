import 'package:emes/Pages/ProfilePages/license_qualification_screen.dart';
import 'package:emes/Pages/ProfilePages/profile_screen.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          // title: const Text("My Profile"),
          bottom: const TabBar(
            tabs: [
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
            children: [ProfileScreen(), LicenseQualificationScreen()],
          ),
        ),
      ),
    );
  }
}
