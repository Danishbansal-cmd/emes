import 'dart:convert';

import 'package:emes/Pages/HomePages/previous_screen.dart';
import 'package:emes/Pages/apply_leave_page.dart';
import 'package:emes/Pages/form_testing_page.dart';
import 'package:emes/Pages/home_page.dart';
import 'package:emes/Pages/inbox_page.dart';
import 'package:emes/Pages/login_page.dart';
import 'package:emes/Pages/profile_page.dart';
import 'package:emes/Pages/signup_page.dart';
import 'package:emes/Providers/accept_decline_provider.dart';
import 'package:emes/Routes/routes.dart';
import 'package:emes/Themes/themes.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/get_logged_in_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

var user;
late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  user = sharedPreferences.getString("token");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, appLevelThemeProvider, _) {
          return GetMaterialApp(
            builder: (context, child) {
              final constrainedTextScaleFactor =
                  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2);

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: constrainedTextScaleFactor as double?,
                ),
                child: child!,
              );
            },
            // navigatorObservers: [NavigationHistoryObserver()],
            title: 'Flutter Demo',
            theme: MyTheme.lightTheme(context),
            darkTheme: MyTheme.darkTheme(context),
            themeMode: appLevelThemeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: user == null ? '/loginPage' : homePageFunction(),
            getPages: [
              GetPage(
                name: '/homePage',
                page: () => HomePage(),
              ),
              GetPage(
                name: '/loginPage',
                page: () => LoginPage(),
              ),
            ],
            routes: {
              MyRoutes.homePageRoute: (context) => HomePage(),
              MyRoutes.profilePageRoute: (context) => ProfilePage(),
              MyRoutes.applyLeavePageRoute: (context) => ApplyLeavePage(),
              MyRoutes.inboxPageRoute: (context) => InboxPage(),
              MyRoutes.loginPageRoute: (context) => LoginPage(),
              MyRoutes.signupPageRoute: (context) => SignupPage(),
              MyRoutes.formTestingPageRoute: (context) => FormTestingPage(),
              MyRoutes.previousScreenRoute: (context) => FirstScreen(),
            },
          );
        },
      ),
    );
  }

  String homePageFunction() {
    String decodeData = sharedPreferences.getString("data") ?? "";
    var data = jsonDecode(decodeData);
    // Constants.setFirstName(data['first_name']);
    // Constants.setLastName(data['last_name']);
    // Constants.setEmail(data['email']);
    Constants.setStaffID(data['id']);
    GetLoggedInUserInformation.getData();
    return '/homePage';
  }
}
