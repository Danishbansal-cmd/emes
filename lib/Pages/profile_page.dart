import 'package:emes/Pages/ProfilePages/license_qualification_screen.dart';
import 'package:emes/Pages/ProfilePages/profile_screen.dart';
import 'package:emes/Utils/configure_platform.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum Sky { ProfileScreen, LicenseQualificationScreen }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.ProfileScreen: const Color(0xff191970),
  Sky.LicenseQualificationScreen: const Color(0xff40826d)
};

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Sky _selectedSegment = Sky.ProfileScreen;
  final ConfigurePlatform _configurePlatform = ConfigurePlatform();

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;
    bool _isIos = _configurePlatform.getConfigurePlatformBool;
    return (_isIos)
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              // This Cupertino segmented control has the enum "Sky" as the type.
              middle: Text(
                'My Profile',
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                ),
              ),
            ),
            child: Material(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15.0,),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                      child: CupertinoSlidingSegmentedControl<Sky>(
                        backgroundColor: CupertinoColors.systemGrey5,
                        thumbColor: CupertinoColors.white,
                        // This represents the currently selected segmented control.
                        groupValue: _selectedSegment,
                        // Callback that sets the selected segmented control.
                        onValueChanged: (Sky? value) {
                          if (value != null) {
                            setState(() {
                              _selectedSegment = value;
                            });
                          }
                        },
                        children: const <Sky, Widget>{
                          Sky.ProfileScreen: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0,),
                            child: Text(
                              'Profile',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Sky.LicenseQualificationScreen: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0,),
                            child: Text(
                              'License/Qualification',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        },
                      ),
                    ),
                    Expanded(
                      // height: MediaQuery.of(context).size.height,
                      child: _selectedSegment == Sky.ProfileScreen
                          ? ProfileScreen()
                          : LicenseQualificationScreen(),
                    )
                  ],
                ),
              ),
            ),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              drawer: const MyDrawer(),
              appBar: AppBar(
                // backgroundColor: (true) ? CupertinoColors.systemGrey2 : null,
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
              body: SafeArea(
                child: TabBarView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [ProfileScreen(), LicenseQualificationScreen()],
                ),
              ),
            ),
          );
  }
}
