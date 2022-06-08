import 'package:flaq/screens/home.screen.dart';
import 'package:flaq/screens/notification_approval.screen.dart';
import 'package:flaq/screens/open_settings.screen.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:optimize_battery/optimize_battery.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class RootService extends GetxService with WidgetsBindingObserver {
  late Telephony telephony;
  var isSmsPermissionGranted = false.obs;
  var isBatteryOptimizationDisabled = false.obs;

  Future<RootService> init() async {
    telephony = Telephony.instance;
    return this;
  }

  @override
  onReady() async {
    if (await (Permission.sms.status).isGranted) {
      isSmsPermissionGranted(true);
    } else {
      isSmsPermissionGranted(false);
    }
    if (await OptimizeBattery.isIgnoringBatteryOptimizations()) {
      isBatteryOptimizationDisabled(true);
    } else {
      isBatteryOptimizationDisabled(false);
    }
    print("Root state");
    print("Sms permission: ${isSmsPermissionGranted.value}");
    print("Battery optimization: ${isBatteryOptimizationDisabled.value}");
  }

  navigate() async {
    if (isSmsPermissionGranted.value) {
      if (isBatteryOptimizationDisabled.value) {
        Get.to(() => const HomeScreen());
      } else {
        Get.to(() => const OpenSettingsScreen());
        return;
      }
    } else {
      Get.to(() => const SmsApprovalScreen());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await (Permission.sms.status).isGranted) {
        isSmsPermissionGranted(true);
      }
      if (await (Permission.ignoreBatteryOptimizations).isGranted) {
        isBatteryOptimizationDisabled(true);
        navigate();
      }
    }
  }

  requestSmsPermission() async {
    if (!(await telephony.isSmsCapable ?? false)) {
      Helper.toast("Your device does not support SMS");
      return;
    }
    var permissionGranted = await telephony.requestSmsPermissions;
    isSmsPermissionGranted(permissionGranted ?? false);
    if (permissionGranted ?? false) {
      navigate();
    } else {
      Helper.toast("Please enable SMS permission from settings");
    }
    // Open the "OPEN SETTINGS" screen
  }

  requestBatteryOptimizationDisable() async {
    OptimizeBattery.isIgnoringBatteryOptimizations().then((value) {
      print("BO VALUE - $value");
      if (value) {
        // If battery is optimised
        isBatteryOptimizationDisabled(true);
        navigate();
      } else {
        OptimizeBattery.openBatteryOptimizationSettings();
      }
    });
  }
}
