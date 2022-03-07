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
    final _colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nu Force Security Group"),
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
          bottom: TabBar(
            labelColor: _colorScheme.primary,
            overlayColor: MaterialStateProperty.all(Colors.blue),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              fontSize: 15,
            ),
            tabs: const [
              Tab(
                text: 'PREVIOUS',
              ),
              Tab(
                text: 'TODAY',
              ),
              Tab(
                text: 'NEXT',
              ),
            ],
          ),
        ),
        drawer: const MyDrawer(),
        body: const TabBarView(
          children: [FirstScreen(), SecondScreen(), ThirdScreen()],
        ),
      ),
    );
  }
}
