import 'package:flaq/screens/home/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootService extends GetxService with WidgetsBindingObserver {
  Future<RootService> init() async {
    return this;
  }

  @override
  onReady() async {}

  navigate() async {
    debugPrint("NAVIGATE CALLED");
    Get.offAll(() => const HomeScaffold());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {}
}
