import 'package:flaq/constants/auth.constants.dart';
import 'package:flaq/screens/auth/login.dart';
import 'package:flaq/screens/auth/referral.dart';
import 'package:flaq/screens/home/scaffold.dart';
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
  late final ApiService _apiService;
  late final SharedPreferences _sp;
  Rx<FlaqUser?> user = FlaqUser().obs;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
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
        var _user = await _apiService.getProfile();
        user(_user);
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
    EasyLoading.show();
    var _user = await _apiService.getProfile();
    user(_user);
    EasyLoading.dismiss();
    if (user == null) {
      Get.offAll(() => const LoginScreen());
      return;
    }
    if (_user?.isAllowed ?? false) {
      debugPrint("User allowed");
      Get.offAll(() => const HomeScaffold());
    } else {
      Get.offAll(() => const ReferralScreen());
    }
  }

  signup(String email, String password) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      await _apiService.signup(email, password);
      var _user = await _apiService.getProfile();
      user(_user);
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
      var _user = (await _apiService.getProfile());
      user(_user);
      Get.log('Profile fetched');
      if (_user == null) {
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
    user(null);
    Get.offAll(() {
      return const LoginScreen();
    });
  }
}
