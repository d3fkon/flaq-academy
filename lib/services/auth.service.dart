import 'package:flaq/constants/auth.constants.dart';
import 'package:flaq/screens/auth/login.dart';
import 'package:flaq/screens/auth/referral.dart';
import 'package:flaq/screens/dashboard.dart';
import 'package:flaq/screens/home.screen.dart';
import 'package:flaq/screens/notification_approval.screen.dart';
import 'package:flaq/screens/sms_open_settings.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/messaging.service.dart';
import 'package:flaq/services/root.service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flaq/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/helper.dart';

class AuthService extends GetxService {
  static AuthService instance = Get.find();
  late Rx<User?> firebaseUser;
  late final ApiService _apiService;
  late final SharedPreferences _sp;
  FlaqUser? user;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
    debugPrint("Setting up auth service");
    _setInitialScreen();
  }

  @override
  void onReady() async {
    _setInitialScreen();
    debugPrint("Setting up auth service");
  }

  /// Login the user
  Future login(String email, String password) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      var loggedIn = await _apiService.login(email, password);
      if (loggedIn) {
        user = await _apiService.getProfile();
        navigate();
      }
    } else {
      Helper.toast('please enable your internet connection');
    }
  }

  Future<AuthService> init() async {
    _sp = await SharedPreferences.getInstance();
    return this;
  }

  /// Set the initital screen
  _setInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('ACCESSTOKEN');
    var refreshToken = prefs.getString('REFRESHTOKEN');

    debugPrint("Setting initial screen");
    if (accessToken == null && refreshToken == null) {
      // if the user is not found then the user is navigated to the Register Screen
      debugPrint("User doesn't exist");
      Get.offAll(() => const LoginScreen());
    } else {
      debugPrint("user exists");
      bool internet = await Helper().checkInternetConnectivity();
      if (internet) {
        EasyLoading.show();
        user = await _apiService.getProfile();
        EasyLoading.dismiss();
        navigate();
      } else {
        Helper.toast('please enable your internet connection');
        Get.offAll(() => const LoginScreen());
        return;
      }
    }
  }

  /// Navigate to the right screen
  navigate() async {
    debugPrint("AuthService: navigate");

    if (user == null) {
      Get.offAll(() => const LoginScreen());
      return;
    }
    if (user!.isAllowed) {
      if (await Permission.sms.status.isGranted) {
        // Get.offAll(() => const DashBoard());
        Get.find<RootService>().navigate();
        // navigate with the root service
        return;
      } else if (await Permission.sms.status.isDenied) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        bool permissionAsked = prefs.getBool('permissionAsked') ?? false;
        if (permissionAsked) {
          Get.offAll(() => const SmsOpenSettingsScreen());
          return;
        } else {
          Get.offAll(() => const SmsApprovalScreen());
          return;
        }
      } else if (await Permission.sms.status.isPermanentlyDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        return;
      }
    }

    if (!user!.isAllowed) {
      Get.offAll(() => const ReferralScreen());
    }
  }

  signup(String email, String password) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      await _apiService.signup(email, password);
      user = await _apiService.getProfile();
      navigate();
    } else {
      Helper.toast('please enable your internet connection');
    }
  }

  /// Get the user's profile
  getProfile({bool handleReferral = true}) async {
    EasyLoading.show();
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      user = (await _apiService.getProfile());
      Get.log('Profile fetched');
      if (user == null) {
        Get.log('Signing out');
        signOut();
        EasyLoading.dismiss();
        return;
      }
      // final homeController = Get.find<HomeController>();
      // homeController.flaqValue(double.parse(user?.synFlaqBalance ?? '0'));
      EasyLoading.dismiss();
    } else {
      Helper.toast('please enable your internet connection');
      return;
    }
  }

  void signOut() async {
    await _sp.remove("ACCESSTOKEN");
    await _sp.remove("REFRESHTOKEN");
    user = null;
    navigate();
  }
}
