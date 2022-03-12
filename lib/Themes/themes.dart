import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode {
    return _themeMode;
  }

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    primaryColor: Colors.blue,
        textTheme: const TextTheme(
          //for status of leavepage
          headline1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          //for error text
          headline6: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),

          //for the drawer items
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff414141),
            fontSize: 16,
          ),
          //for the shift text
          headline3: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          )
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
          toolbarTextStyle: TextStyle(
            color: Colors.black,
            // fontSize: 18,
            // letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme:const ColorScheme.light(
          primary: Colors.black
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    primaryColor: Colors.blue,
        textTheme: const TextTheme(
          //for status of leavepage
          headline1: TextStyle(
            fontSize: 16,
            // fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          //for error text
          headline6: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff414141),
            fontSize: 16,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
        ),
      );

  static Color firstColor = Color(0xff414141);
  static Color secondColor = Color(0xff414141);
  static Color thirdColor = Color(0xff414141);
  static Color fourthColor = Color(0xff414141);
}
