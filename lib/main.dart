import 'package:firebase_core/firebase_core.dart';
import 'package:flaq/bindings.dart';
import 'package:flaq/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

const AndroidNotificationDetails ANDROID_PLATFORM_CHANNEL_SPECIFICS =
    AndroidNotificationDetails(
  '1234',
  'FLAQ',
  channelDescription: 'Reward Notification',
  importance: Importance.max,
  priority: Priority.high,
  ticker: 'ticker',
  subText: "You've received a reward",
);
const NotificationDetails PLATFORM_CHANNEL_SPECIFICS =
    NotificationDetails(android: ANDROID_PLATFORM_CHANNEL_SPECIFICS);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool permissionAsked = prefs.getBool('permissionAsked') ?? false;

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('flaq_logo');
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(android: initializationSettingsAndroid),
    onSelectNotification: (payload) async {
      debugPrint("IN ON SELECT NOTIFICATION");
    },
  );
  // print("NOTIFICAITON INITIALIZATION RESULT: $res");
  Future.delayed(const Duration(milliseconds: 1)).then((value) =>
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark, // bar light == text dark
      )));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Set dark theme with the Montserrat font family
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Montserrat'),
      home: Container(
        color: Colors.black,
      ),
      initialBinding: AppBindings(),
      builder: EasyLoading.init(),
      // home: const Generic1Screen(
      //   type: GenericScreenType.slider,
      // ),
    );
    return GetMaterialApp(
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.black,
      ),
      builder: EasyLoading.init(),
    );
  }
}
