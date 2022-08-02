import 'package:emes/Pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('More'),
        ),
        child: SafeArea(
          child: Column(
            children: [
              DecoratedBox(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Log out"),
                      SizedBox(
                        child: CupertinoButton(
                          
                          color: CupertinoColors.activeGreen,
                          child: Icon(CupertinoIcons.forward),
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Log Out"),
                                  content: Text(
                                      "Are you sure you want to logout of EMES?"),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                        child: const Text("Logout",style: TextStyle(color: CupertinoColors.destructiveRed),),
                                        onPressed: () async {
                                          SharedPreferences sharedPreferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharedPreferences.clear();
                                          sharedPreferences.commit();
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) {
                                              return LoginPage();
                                            }),
                                          );
                                        }),
                                    
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
