import 'package:firebase_core/firebase_core.dart';
import 'package:flaq/bindings.dart';
import 'package:flaq/firebase_options.dart';
import 'package:flaq/screens/home.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  Future.delayed(const Duration(milliseconds: 1)).then((value) =>
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark, // bar light == text dark
      )));
  WidgetsFlutterBinding.ensureInitialized();
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
      home: Container(color: Colors.black,),
      builder: EasyLoading.init(),
    );
  }
}
