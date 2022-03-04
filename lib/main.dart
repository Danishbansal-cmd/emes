import 'package:emes/Pages/apply_leave_page.dart';
import 'package:emes/Pages/home_page.dart';
import 'package:emes/Pages/inbox_page.dart';
import 'package:emes/Pages/profile_page.dart';
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
        // ChangeNotifierProvider(create: (_) =>)
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
              "/": (context) => ProfilePage(),
              MyRoutes.homePageRoute: (context) => HomePage(),
              MyRoutes.profilePageRoute: (context) => ProfilePage(),
              MyRoutes.applyLeavePageRoute: (context) => ApplyLeavePage(),
              MyRoutes.inboxPageRoute: (context) => InboxPage(),
            },
          );
        },
      ),
    );
  }
}
