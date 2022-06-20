import 'package:flaq/screens/home.screen.dart';
import 'package:flaq/screens/notification_approval.screen.dart';
import 'package:flaq/screens/open_settings.screen.dart';
import 'package:flaq/screens/sms_open_settings.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/messaging.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:optimize_battery/optimize_battery.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool permissionAsked = prefs.getBool('permissionAsked') ?? false;
      if (!permissionAsked) {
        Get.to(() => const SmsApprovalScreen());
      } else {
        Get.to(() => const SmsOpenSettingsScreen());
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await (Permission.sms.status).isGranted) {
        isSmsPermissionGranted(true);
        await navigate();
      }
      if (await (Permission.sms.status).isDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
      }
      if (await (Permission.sms.status).isPermanentlyDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
      }
      if (await (Permission.ignoreBatteryOptimizations).isGranted) {
        isBatteryOptimizationDisabled(true);
        navigate();
      }
    }
    if (state == AppLifecycleState.paused) {
      if (await (Permission.sms.status).isGranted) {
        isSmsPermissionGranted(true);
        await navigate();
      }
      if (await (Permission.sms.status).isDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
      }
      if (await (Permission.sms.status).isPermanentlyDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
      }
      if (await (Permission.ignoreBatteryOptimizations).isGranted) {
        isBatteryOptimizationDisabled(true);
        navigate();
      }
    }
  }

  requestSmsPermission() async {
    if (!(await Telephony.instance.isSmsCapable ?? false)) {
      Helper.toast("Your device does not support SMS");
      return;
    }
    // var permissionGranted = await telephony.requestSmsPermissions;
    // isSmsPermissionGranted(permissionGranted ?? false);
    // if (permissionGranted == true) {
    //   navigate();
    // } else if (permissionGranted == false || permissionGranted == null) {
    //   Helper.toast("Please enable SMS permission from settings");
    //   Get.offAll(() => const SmsOpenSettingsScreen());
    //   debugPrint('navigate to open settings screen');
    // }
    // Open the "OPEN SETTINGS" screen
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool permissionAsked = prefs.getBool('permissionAsked') ?? false;
      if (permissionAsked == false) {
        await prefs.setBool('permissionAsked', true);
        debugPrint('in function');
        await telephony.requestSmsPermissions;
      }
    } catch (e) {
      Helper.toast('please enable sms permissions');
    }
    var permissionGranted = await Permission.sms.status;
    if (permissionGranted.isPermanentlyDenied) {
      Get.offAll(() => const SmsOpenSettingsScreen());
      debugPrint('permanent');
      return;
    }
    if (permissionGranted.isDenied) {
      Get.offAll(() => const SmsOpenSettingsScreen());
      debugPrint('denied');
      return;
    }
    if (permissionGranted.isGranted) {
      isSmsPermissionGranted(true);
      navigate();
    }
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
