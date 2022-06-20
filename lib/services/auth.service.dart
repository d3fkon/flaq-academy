import 'package:flaq/constants/auth.constants.dart';
import 'package:flaq/screens/auth/login.dart';
import 'package:flaq/screens/auth/referral.dart';
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
    firebaseUser = Rx<User?>(auth.currentUser);
    debugPrint("Setting up auth service");
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  @override
  void onReady() async {
    firebaseUser = Rx<User?>(auth.currentUser);
    debugPrint("Setting up auth service");
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// Login the user
  Future<bool> login(String email, String password) async {
    try {
      EasyLoading.show();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await _sp.setString(
          "AUTHKEY", await auth.currentUser?.getIdToken() ?? "");
      debugPrint("Logged In");
      Helper.toast("logged in");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Helper.toast("user not found. please sign up to Flaq");
      } else if (e.code == 'wrong-password') {
        Helper.toast("incorrect password");
      }
      return false;
    } catch (e) {
      debugPrint("Error logging in ");
      Helper.toast("error logging in. please check your network");
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  void logout() async {
    await auth.signOut();
  }

  Future<AuthService> init() async {
    _sp = await SharedPreferences.getInstance();
    return this;
  }

  /// Set the initital screen
  _setInitialScreen(User? user) async {
    debugPrint("Setting initial screen");
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      debugPrint("User doesn't exist");
      Get.offAll(() => const LoginScreen());
    } else {
      debugPrint("user exists");
      await getProfile();
      navigate();
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
        Get.offAll(() => const HomeScreen());

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
    EasyLoading.show();
    try {
      final authResult = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        Helper.toast('Signed up successfully');
        // Get.to(const LoginScreen());
      }
    } catch (e) {
      Helper.toast(e.toString().split(']')[1]);
    }
    EasyLoading.dismiss();
  }

  /// Get the user's profile
  getProfile({bool handleReferral = true}) async {
    EasyLoading.show();
    if (auth.currentUser == null) {
      EasyLoading.dismiss();
      return;
    }
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
  }

  getUserToken() async {
    await _sp.setString("AUTHKEY", await auth.currentUser?.getIdToken() ?? "");
    return await auth.currentUser?.getIdToken();
  }

  void signOut() async {
    await _sp.remove("AUTHKEY");
    await auth.signOut();
  }
}
