import 'package:emes/Pages/HomePages/previous_screen.dart';
import 'package:emes/Pages/HomePages/today_screen.dart';
import 'package:emes/Pages/HomePages/next_screen.dart';
import 'package:emes/Themes/themes.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Consumer<ThemeProvider>(
                builder: (context, appLevelThemeProvider, _) {
                  return Switch.adaptive(
                    value: appLevelThemeProvider.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      final provider =
                          Provider.of<ThemeProvider>(context, listen: false);
                      provider.toggleTheme(value);
                    },
                  );
                },
              ),
            ],
            bottom: const TabBar(tabs: [
              Tab(
                text: 'PREVIOUS',
              ),
              Tab(
                text: 'TODAY',
              ),
              Tab(
                text: 'NEXT',
              ),
            ]),
          ),
          drawer: const MyDrawer(),
          body: const TabBarView(
            children: [FirstScreen(), SecondScreen(), ThirdScreen()],
          ),
        ),
      );
  }
}
