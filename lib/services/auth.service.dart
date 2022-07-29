import 'package:flaq/screens/auth/login.dart';
import 'package:flaq/screens/auth/referral.dart';
import 'package:flaq/screens/generic/generic_1.screen.dart';
import 'package:flaq/screens/home/scaffold.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/tracking.service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flaq/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/helper.dart';

class AuthService extends GetxService {
  static AuthService instance = Get.find();
  TrackingService tracker = Get.find();
  late final ApiService _apiService;
  late final SharedPreferences _sp;
  Rx<FlaqUser?> user = FlaqUser().obs;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  /// Login the user
  Future login(String email, String password) async {
    bool internet = await Helper().checkInternetConnectivity();

    if (internet) {
      var loggedIn = await _apiService.login(email, password);
      if (loggedIn) {
        navigate();
      }
    } else {
      Helper.toast('please enable your internet connection');
    }
  }

  Future<AuthService> init() async {
    _sp = await SharedPreferences.getInstance();
    _setInitialScreen();
    return this;
  }

  final FIRST_TIME_USER_TOKEN = 'first_time_user_2';

  /// Set the initital screen
  _setInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('ACCESSTOKEN');
    var refreshToken = prefs.getString('REFRESHTOKEN');
    var firstTimeUser = prefs.getBool(FIRST_TIME_USER_TOKEN);
    if (firstTimeUser ?? true) {
      Get.to(
        () => Generic1Screen(
          data: GenericScreenData.noBS,
          onTap: () {
            Get.to(
              () => Generic1Screen(
                  data: GenericScreenData.earn$,
                  onTap: () async {
                    await prefs.setBool(FIRST_TIME_USER_TOKEN, false);
                    navigate();
                  }),
              preventDuplicates: false,
            );
          },
        ),
      );
      return;
    }

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
      navigate();
    } else {
      Helper.toast('please enable your internet connection');
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
