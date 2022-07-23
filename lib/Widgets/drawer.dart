import 'dart:convert';
import 'dart:io' show Platform;
import 'package:emes/Themes/themes.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Routes/routes.dart';
import 'package:emes/Utils/get_logged_in_information.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:emes/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String firstName = "";
  String lastName = "";
  String email = "";

  ShiftData _shiftData = ShiftData();

  // @override
  // void initState() async{
  //   // super.initState();
  //   SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     String decodeData = sharedPreferences.getString("data") ?? "";
  //     var data = jsonDecode(decodeData);
  //     firstName = data['first_name'];
  //     lastName = data['last_name'];
  //     email = data['email'];
  // }

  //app level initializing mainPage controller
  final controller = Get.put(MainPageController());

  bool _isIOS = Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () async{
    //   SharedPreferences sharedPreferences =
    //       await SharedPreferences.getInstance();
    //   String decodeData = sharedPreferences.getString("data") ?? "";
    //   var data = jsonDecode(decodeData);
    //   firstName = data['first_name'];
    //   lastName = data['last_name'];
    //   email = data['email'];
    // });
    print("image url\n ");
    _shiftData.getData();
    final _textTheme = Theme.of(context).textTheme;
    final _colorScheme = Theme.of(context).colorScheme;
    const imageUrl =
        "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=";
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName:
                    Text("${Constants.getFirstName} ${Constants.getLastName}"),
                accountEmail: Text(Constants.getEmail),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, MyRoutes.homePageRoute);
                // Navigator.pushNamed(context, MyRoutes.homePageRoute);
              },
              child: ListTile(
                // leading: Icon(Icons.calendar_month_outlined,color: _colorScheme.secondaryVariant,),
                leading: FaIcon(
                  FontAwesomeIcons.calendarDays,
                  size: 18,
                  color: _colorScheme.secondary,
                ),
                title: Text(
                  "Roster",
                  style: _textTheme.headline2,
                ),
                // subtitle: Text("Subtitle Please"),
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, MyRoutes.profilePageRoute);
                Navigator.pushReplacementNamed(
                    context, MyRoutes.profilePageRoute);
              },
              child: ListTile(
                // leading: Icon(
                //   Icons.threed_rotation,
                //   color: _colorScheme.secondaryVariant,
                // ),
                leading: FaIcon(
                  FontAwesomeIcons.addressCard,
                  size: 18,
                  color: _colorScheme.secondary,
                ),
                title: Text(
                  "Profile",
                  style: _textTheme.headline2,
                ),
                // subtitle: const Text("Subtitle Please"),
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, MyRoutes.applyLeavePageRoute);
                Navigator.pushReplacementNamed(
                    context, MyRoutes.applyLeavePageRoute);
              },
              child: ListTile(
                // leading: Icon(
                //   Icons.add_circle,
                //   color: _colorScheme.secondaryVariant,
                // ),
                leading: FaIcon(
                  FontAwesomeIcons.circlePlus,
                  size: 18,
                  color: _colorScheme.secondary,
                ),
                title: Text(
                  "Apply Leave",
                  style: _textTheme.headline2,
                ),
                // subtitle:const Text("Subtitle Please"),
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, MyRoutes.inboxPageRoute);
                  Navigator.pushReplacementNamed(
                      context, MyRoutes.inboxPageRoute);
                },
                child: ListTile(
                  // leading: Icon(
                  //   Icons.forum,
                  //   color: _colorScheme.secondaryVariant,
                  // ),
                  leading: FaIcon(
                    FontAwesomeIcons.solidMessage,
                    size: 18,
                    color: _colorScheme.secondary,
                  ),
                  title: Text(
                    "Inbox",
                    style: _textTheme.headline2,
                  ),
                  trailing: controller.getNumberOfNotification > 0
                      ? Container(
                          padding: const EdgeInsets.all(5.0),
                          constraints: const BoxConstraints(
                              minWidth: 25,
                              maxWidth: 25,
                              minHeight: 25,
                              maxHeight: 25),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            controller.getNumberOfNotification.toString(),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : null,
                  // subtitle:const  Text("Subtitle Please"),
                ),
              ),
            ),
            // ListTile(
            //   // leading: Icon(
            //   //   Icons.abc,
            //   //   color: _colorScheme.secondaryVariant,
            //   // ),
            //   leading: FaIcon(
            //       FontAwesomeIcons.arrowRightFromBracket,
            //       size: 18,
            //       color: _colorScheme.secondary,
            //     ),
            //   title: Consumer<ThemeProvider>(
            //     builder: (context, appLevelThemeProvider, _) {
            //       return Switch.adaptive(
            //         value: appLevelThemeProvider.themeMode == ThemeMode.dark,
            //         onChanged: (value) {
            //           final provider =
            //               Provider.of<ThemeProvider>(context, listen: false);
            //           provider.toggleTheme(value);
            //         },
            //       );
            //     },
            //   ),
            // ),

            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return (false) ? CupertinoAlertDialog(
                        title: const Text("Logout"),
                        content:
                            const Text("Are you sure want to logout of this app?"),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text("ok"),
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.clear();
                              sharedPreferences.commit();
                              Navigator.pushReplacementNamed(
                                  context, MyRoutes.loginPageRoute);
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text("cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ) : Dialog(
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20)
                                .copyWith(bottom: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 180,
                            // width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Confirm!",
                                  style: _textTheme.headline1,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Are you sure want to logout of this app?",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 148, 148, 148),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Material(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        splashColor: Colors.blue,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const SizedBox(
                                          height: 35,
                                          width: 80,
                                          child: Center(
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Material(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      child: InkWell(
                                        onTap: () async {
                                          SharedPreferences sharedPreferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharedPreferences.clear();
                                          sharedPreferences.commit();
                                          Navigator.pushReplacementNamed(
                                              context, MyRoutes.loginPageRoute);
                                        },
                                        borderRadius: BorderRadius.circular(5),
                                        splashColor: Colors.red,
                                        child: const SizedBox(
                                          height: 35,
                                          width: 80,
                                          child: Center(
                                            child: Text(
                                              "Logout",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: ListTile(
                // leading: Icon(
                //   Icons.logout,
                //   color: _colorScheme.secondaryVariant,
                // ),
                leading: FaIcon(
                  FontAwesomeIcons.arrowRightFromBracket,
                  size: 18,
                  color: _colorScheme.secondary,
                ),
                title: Text(
                  "Logout",
                  style: _textTheme.headline2,
                ),
                // subtitle:const Text("Subtitle Please"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {}
}
