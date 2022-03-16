import 'package:emes/Pages/HomePages/previous_screen.dart';
import 'package:emes/Pages/HomePages/today_screen.dart';
import 'package:emes/Pages/HomePages/next_screen.dart';
import 'package:emes/Providers/homepage_dates_provider.dart';
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
    final _colorScheme = Theme.of(context).colorScheme;
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

            Consumer<HomepageDatesProvider>(
              builder: (context, appLevelHomepageDatesProvider, _) {
                return Container(
              padding: const EdgeInsets.symmetric(vertical: 6).copyWith(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Constants.indicatorTracker(Colors.amber,14),
                  const SizedBox(width: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(appLevelHomepageDatesProvider.getStartDate),
                        // Text(appLevelHomepageDatesProvider.getEndDate),
                      ],
                    ),
                  ),
                ],
              ),
            );},),
          ],
          bottom: TabBar(
            labelColor: _colorScheme.secondary,
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
              if(int == 2){
                print("does i print second");
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
