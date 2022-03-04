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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
          headline6: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff414141),
            fontSize: 16,
          ),
        ),
        colorScheme: ColorScheme.light(
            // primary: Colors.deepPurple,
            // background: Colors.white,
            // primaryVariant: Vx.gray200,
            // secondary: Colors.black,
            // secondaryVariant: Colors.black.withOpacity(0.6),
            ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
          headline6: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff414141),
            fontSize: 16,
          ),
        ),
        colorScheme: const ColorScheme.dark(
            // primary: Color(0xFF303030),
            // background: Color(0xFF303030),
            // primaryVariant: Color(0xFF606060),
            // secondary: Colors.white,
            // secondaryVariant: Colors.black
            ),
      );

  static Color firstColor = Color(0xff414141);
  static Color secondColor = Color(0xff414141);
  static Color thirdColor = Color(0xff414141);
  static Color fourthColor = Color(0xff414141);
}
