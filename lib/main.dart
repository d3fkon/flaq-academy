import 'package:flaq/screens/auth/login.dart';
import 'package:flaq/screens/notification_approval.screen.dart';
import 'package:flaq/screens/home.screen.dart';
import 'package:flaq/screens/open_settings.screen.dart';
import 'package:flaq/screens/auth/signup.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/messaging.service.dart';
import 'package:flaq/services/root.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => RootService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => MessagingService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Approval(),
    );
  }
}
