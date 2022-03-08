import 'package:emes/Pages/api_testing_page.dart';
import 'package:emes/Pages/apply_leave_page.dart';
import 'package:emes/Pages/home_page.dart';
import 'package:emes/Pages/inbox_page.dart';
import 'package:emes/Pages/login_page.dart';
import 'package:emes/Pages/profile_page.dart';
import 'package:emes/Pages/signup_page.dart';
import 'package:emes/Providers/apply_leave_form_provider.dart';
import 'package:emes/Routes/routes.dart';
import 'package:emes/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        ChangeNotifierProvider<ApplyLeaveFormProvider>(
          create: (_) => ApplyLeaveFormProvider(),
        ),
        ChangeNotifierProvider<OpenLeaveBarProvider>(
          create: (_) => OpenLeaveBarProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, appLevelThemeProvider, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: MyTheme.lightTheme(context),
            darkTheme: MyTheme.darkTheme(context),
            themeMode: appLevelThemeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              "/": (context) => LoginPage(),
              MyRoutes.homePageRoute: (context) => HomePage(),
              MyRoutes.profilePageRoute: (context) => ProfilePage(),
              MyRoutes.applyLeavePageRoute: (context) => ApplyLeavePage(),
              MyRoutes.inboxPageRoute: (context) => InboxPage(),
              MyRoutes.loginPageRoute:(context) => LoginPage(),
              MyRoutes.signupPageRoute:(context) => SignupPage(),
              MyRoutes.testingApiRoute:(context) => TestingApi(),
            },
          );
        },
      ),
    );
  }
}
