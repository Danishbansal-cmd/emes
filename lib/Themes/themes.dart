import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode {
    return _themeMode;
  }

  void toggleTheme(bool isOn){
    _themeMode = isOn ? ThemeMode.dark :  ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          //for error text
          headline6: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),

          //for the drawer items
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff414141),
            fontSize: 16,
          ),
        ),
        colorScheme: ColorScheme.light(
            ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
          //for error text
          headline6: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff414141),
            fontSize: 16,
          ),
        ),
        colorScheme: const ColorScheme.dark(
            ),
      );

  static Color firstColor = Color(0xff414141);
  static Color secondColor = Color(0xff414141);
  static Color thirdColor = Color(0xff414141);
  static Color fourthColor = Color(0xff414141);
}
