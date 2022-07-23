import 'dart:convert';
import 'package:emes/Pages/HomePages/previous_screen.dart';
import 'package:emes/Pages/HomePages/today_screen.dart';
import 'package:emes/Pages/HomePages/next_screen.dart';
import 'package:emes/Pages/apply_leave_page.dart';
import 'package:emes/Pages/profile_page.dart';
import 'package:emes/Routes/routes.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Themes/themes.dart';
import 'package:emes/Utils/shift_data.dart';
import 'package:emes/Widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initializing values here
  //initializing home getx controller
  final homeController = Get.put(HomeController());
  //initializing fisrstscreen getx controller
  final firstScreenController = Get.put(FirstScreenController());
  //initializing thirdscreen getx controller
  final nextScreenController = Get.put(NextScreenController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homeController.dispose();
  }

  ShiftData _shiftData = ShiftData();

  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    //initializing homepagedates getx controller
    final homepageDatesController = Get.put(HomepageDatesController());
    void setDateFunction(String value1, String value2) {
      // print("tryfunction real values $value1   $value2");
      homepageDatesController.setStartDate(value1);
      homepageDatesController.setEndDate(value2);
    }

    final _colorScheme = Theme.of(context).colorScheme;
    return (true)
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Tab 1',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  label: 'Tab 2',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Tab 3',
                ),
              ],
            ),
            tabBuilder: (context, index) {
              if (index == 0) {
                return CupertinoTabView(
                  navigatorKey: firstTabNavKey,
                  builder: (BuildContext context) => SecondScreen(),
                );
              } else if (index == 1) {
                return CupertinoTabView(
                  navigatorKey: secondTabNavKey,
                  builder: (BuildContext context) => ProfilePage(),
                );
              } else {
                return CupertinoTabView(
                  navigatorKey: thirdTabNavKey,
                  builder: (BuildContext context) => ApplyLeavePage(),
                );
              }
            },
          )
        : DefaultTabController(
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

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3)
                        .copyWith(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Constants.indicatorTracker(Colors.amber, 18),
                        const SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                  homepageDatesController.getStartDate,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 90, 90, 90),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Text(
                                  homepageDatesController.getEndDate,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 90, 90, 90),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                bottom: TabBar(
                  labelColor: _colorScheme.secondary,
                  overlayColor: MaterialStateProperty.all(Colors.blue),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                    fontSize: 15,
                  ),
                  onTap: (int) async {
                    // print("do i printaasfdas");

                    // void tryFunction(String value1, String value2) {
                    //   // print("tryfunction real values $value1   $value2");
                    //   date.setStartDate(value1);
                    //   date.setEndDate(value2);
                    // }

                    //your code goes here
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    String decodeData =
                        sharedPreferences.getString("data") ?? "";
                    var data = jsonDecode(decodeData);
                    final myFuture = http.post(
                      Uri.parse(int == 0
                          ? _shiftData.getPreUrl
                          : int == 1
                              ? Constants.getShiftUrl
                              : _shiftData.getNextUrl),
                      body: {
                        "staff_id": data['id'],
                      },
                    );
                    if (int == 0) {
                      firstScreenController.setValueInt();
                    }
                    if (int == 2) {
                      nextScreenController.setValueInt();
                    }
                    myFuture.then(
                      (value) => setDateFunction(
                          (jsonDecode(value.body))['data']['start_date'],
                          (jsonDecode(value.body))['data']['end_date']),
                      // print((jsonDecode(value.body))['data']['start_date']);
                    );
                    // setState(() {});
                  },
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
              body: TabBarView(
                // to disable swiping tabs in TabBar flutter
                physics: const NeverScrollableScrollPhysics(),
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

class HomeController extends GetxController {
  var location = new Location();
  bool? serviceEnabled;
  PermissionStatus? _permissionGranted;
  String? realAddress;
  LocationData? coordinates;
  @override
  void onInit() {
    // secureScreen();
    // TODO: implement onInit
    super.onInit();
    getLocation();
    // .then((value) {
    //   LocationData? location = value;
    //   getAddress(location!.latitude!, location.longitude);
    // });
  }

  Future<LocationData?> getLocation() async {
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled!) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled!) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.grantedLimited) {
        return null;
      }
    }
    locationData = await location.getLocation();
    coordinates = locationData;
    return locationData;
  }

  Future<String?> getAddress(double? lat, double? long) async {
    if (lat == null || long == null) return "";

    GeoCode geoCode = GeoCode();
    Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: long);
    realAddress =
        "this is the address ${address.countryName} ${address.city} ${address.streetAddress}";
    print("realAddress ${realAddress}");
    return realAddress;
  }
}

class HomepageDatesController extends GetxController {
  RxString _start_date = "".obs;
  RxString _end_date = "".obs;

  //getters and setters
  get getStartDate {
    return _start_date.value;
  }

  get getEndDate {
    return _end_date.value;
  }

  setStartDate(String value) {
    _start_date.value = value;
  }

  setEndDate(String value) {
    _end_date.value = value;
  }
}
