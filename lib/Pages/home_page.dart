import 'package:emes/Pages/HomePages/previous_screen.dart';
import 'package:emes/Pages/HomePages/today_screen.dart';
import 'package:emes/Pages/HomePages/next_screen.dart';
import 'package:emes/Routes/routes.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Themes/themes.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final homePageArguments = ModalRoute.of(context)!.settings.arguments as HomePageArguments;
    final _colorScheme = Theme.of(context).colorScheme;
    // Constants.setFirstName("fasf");
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nu Force Security Group"),
          actions: [
            // Consumer<ThemeProvider>(
            //   builder: (context, appLevelThemeProvider, _) {
            //     return Switch.adaptive(
            //       value: appLevelThemeProvider.themeMode == ThemeMode.dark,
            //       onChanged: (value) {
            //         final provider =
            //             Provider.of<ThemeProvider>(context, listen: false);
            //         provider.toggleTheme(value);
            //       },
            //     );
            //   },
            // ),

            Column(
              children: [

              ],
            ),
          ],
          bottom: TabBar(
            // controller: TabController(length: 1,vsync: TickerProvider),
            labelColor: _colorScheme.primary,
            overlayColor: MaterialStateProperty.all(Colors.blue),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              fontSize: 15,
            ),
            onTap: (int){
              print("int ${int}");
              if(int == 0){
                print("does i print");
                setState(() {
                  
                });
              }
            },
            tabs:const [
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
        body: TabBarView(
          children: [FirstScreen(), SecondScreen(), ThirdScreen()],
        ),
      ),
    );
  }
}

// class HomePageArguments {
//   String firstName = "";
//   String lastName = "";
//   String email = "";
//   String staffID ="";

//   HomePageArguments(this.firstName, this.lastName, this.email, this.staffID);
// }
