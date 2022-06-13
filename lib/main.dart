import 'package:firebase_core/firebase_core.dart';
import 'package:flaq/bindings.dart';
import 'package:flaq/firebase_options.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('flaq_logo');
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(android: initializationSettingsAndroid),
    onSelectNotification: (payload) async {
      print("IN ON SELECT NOTIFICATION");
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final key = sp.getString("AUTHKEY");
      if (key == null) return;
      try {
        await http.post(Uri.parse("$BASE_URL/payments/register"), body: {
          "amount": payload.toString()
        }, headers: {
          'x-auth-token': key,
        });
        Helper.showRewardReceipt(payload.toString());
      } catch (e) {
        print(e);
      }
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
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.black,
      ),
      builder: EasyLoading.init(),
    );
  }
}
