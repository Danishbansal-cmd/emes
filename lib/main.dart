import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:emes/Pages/HomePages/previous_screen.dart';
import 'package:emes/Pages/apply_leave_page.dart';
import 'package:emes/Pages/home_page.dart';
import 'package:emes/Pages/inbox_page.dart';
import 'package:emes/Pages/login_page.dart';
import 'package:emes/Pages/profile_page.dart';
import 'package:emes/Pages/signup_page.dart';
import 'package:emes/Themes/themes.dart';
import 'package:emes/Utils/configure_platform.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/get_logged_in_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

var user;
late SharedPreferences sharedPreferences;

// [Android-only] This "Headless Task" is run when the Android app
// is terminated with enableHeadless: true
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    BackgroundFetch.finish(taskId);
    return;
  }
  final controller = Get.put(MainPageController());
  String decodeData = sharedPreferences.getString("data") ?? "";
  String companyURL = sharedPreferences.getString("sharedDataCompanyURL") ?? "";
  var data = jsonDecode(decodeData);
  var response = await http
      .get(Uri.parse(companyURL + "/api/get_new_message_noti/" + data['id']));
  var jsonResponse = jsonDecode(response.body);
  if (jsonResponse['data'] > 0) {
    NotificationApi.init();
    NotificationApi.showNotification(
        title: 'New Messages',
        body: '${jsonResponse["data"]}',
        payload: 'EMES');
    controller.setNumberOfNotification(jsonResponse['data']);
    FlutterAppBadger.updateBadgeCount(jsonResponse['data']);
  } else {
    controller.setNumberOfNotification(jsonResponse['data']);
    FlutterAppBadger.isAppBadgeSupported();
  }
  BackgroundFetch.finish(taskId);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  user = sharedPreferences.getString("token");
  runApp(MyApp());

  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? mytimer;
  ConfigurePlatform _configurePlatform = ConfigurePlatform();

  //app level initializing controller
  final controller = Get.put(MainPageController());

  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    // initPlatformState();
    String companyURL =
        sharedPreferences.getString("sharedDataCompanyURL") ?? "";
    String decodeData = sharedPreferences.getString("data") ?? "";
    mytimer = Timer.periodic(Duration(minutes: 1), (timer) async {
      if (decodeData != "") {
        var data = jsonDecode(decodeData);
        var response = await http.get(
            Uri.parse(companyURL + "/api/get_new_message_noti/" + data['id']));
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['data'] > 0) {
          NotificationApi.showNotification(
              title: 'Inbox',
              body: 'New messages: ${jsonResponse["data"]}',
              payload: 'EMES');
          controller.setNumberOfNotification(jsonResponse['data']);
          FlutterAppBadger.updateBadgeCount(jsonResponse['data']);
        } else {
          controller.setNumberOfNotification(jsonResponse['data']);
          FlutterAppBadger.removeBadge();
        }
      }
    });
  }

  // Future<void>
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //to set globally the value of variable
    _configurePlatform.setConfigurePlatformBool(Platform.isIOS);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, appLevelThemeProvider, _) {
          return GetMaterialApp(
            builder: (context, child) {
              final constrainedTextScaleFactor =
                  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2);

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: constrainedTextScaleFactor,
                ),
                child: child!,
              );
            },
            title: 'EMES',
            theme: MyTheme.lightTheme(context),
            darkTheme: MyTheme.darkTheme(context),
            themeMode: appLevelThemeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            //if user is not signed in then got to /loginPage
            //otherwise run homePageFunction
            //to set constants and sharedPreferences or cookies
            //for the app
            initialRoute: user == null ? '/loginPage' : homePageFunction(),
            getPages: [
              GetPage(
                name: '/homePage',
                page: () => HomePage(),
              ),
              GetPage(
                name: '/loginPage',
                page: () => LoginPage(),
              ),
              GetPage(
                name: '/signUpPage',
                page: () => SignupPage(),
              ),
              GetPage(
                name: '/applyLeavePage',
                page: () => ApplyLeavePage(),
              ),
              GetPage(
                name: '/inboxPage',
                page: () => InboxPage(),
              ),
              GetPage(
                name: '/profilePage',
                page: () => ProfilePage(),
              ),
              GetPage(
                name: '/firstScreen',
                page: () => FirstScreen(),
              ),
            ],
          );
        },
      ),
    );
  }

  String homePageFunction() {
    String decodeData = sharedPreferences.getString("data") ?? "";
    String companyURL =
        sharedPreferences.getString("sharedDataCompanyURL") ?? "";
    var data = jsonDecode(decodeData);
    Constants.setCompanyURL(companyURL);
    Constants.setStaffID(data['id']);
    GetLoggedInUserInformation.getData();
    return '/homePage';
  }
}

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notification.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          channelDescription: 'channel description',
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notification.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }
}

class MainPageController extends GetxController {
  RxInt _numberOfNotification = 0.obs;

  setNumberOfNotification(int value) {
    _numberOfNotification.value = value;
  }

  get getNumberOfNotification {
    return _numberOfNotification.value;
  }
}
