import 'package:flaq/screens/home.screen.dart';
import 'package:flaq/screens/notification_approval.screen.dart';
import 'package:flaq/screens/open_settings.screen.dart';
import 'package:flutter/material.dart';
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
    ever(isSmsPermissionGranted, (bool val) {
      if (!val) {
        Get.to(() => const Approval());
        return;
      }
      if (isBatteryOptimizationDisabled.value) {
        Get.to(() => const OpenSettingsScreen());
        return;
      } else {
        Get.to(() => const HomeScreen());
      }
    });
    ever(isBatteryOptimizationDisabled, (bool val) {
      if (!val) {
        Get.to(() => const OpenSettingsScreen());
      } else if (isSmsPermissionGranted.value) {
        Get.to(() => const HomeScreen());
      }
    });

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
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (await (Permission.sms.status).isGranted) {
      isSmsPermissionGranted(true);
    }
    if (state == AppLifecycleState.resumed) {
      if (await (Permission.ignoreBatteryOptimizations).isGranted) {
        isBatteryOptimizationDisabled(true);
      }
    }
  }

  requestSmsPermission() async {
    if (!(await telephony.isSmsCapable ?? false)) {
      // TODO: Handle device not able to send SMS
    }
    var permissionGranted = await telephony.requestSmsPermissions;
    isSmsPermissionGranted(permissionGranted ?? false);
    // Open the "OPEN SETTINGS" screen
  }

  requestBatteryOptimizationDisable() async {
    OptimizeBattery.isIgnoringBatteryOptimizations().then((value) {
      print("BO VALUE - $value");
      if (!value) {
        if (!value) OptimizeBattery.openBatteryOptimizationSettings();
      } else {
        isBatteryOptimizationDisabled(true);
      }
    });
  }
}
