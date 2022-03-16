import 'package:emes/Pages/ProfilePages/license_qualification_screen.dart';
import 'package:emes/Pages/ProfilePages/profile_screen.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // elevation: 0,
          title: const Text("My Profile"),
          bottom: TabBar(
            labelColor: _colorScheme.secondary,
            dragStartBehavior: DragStartBehavior.down,
            labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            overlayColor: MaterialStateProperty.all(Colors.blue),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              fontSize: 16,
            ),
            tabs: const [
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
        body: SafeArea(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [ProfileScreen(), LicenseQualificationScreen()],
          ),
        ),
      ),
    );
  }
}
