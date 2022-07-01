import 'dart:convert';

import 'package:flaq/models/transaction.model.dart';
import 'package:flaq/models/user.model.dart';
import 'package:flaq/screens/auth/referral.dart';
import 'package:flaq/screens/dashboard.dart';
import 'package:flaq/screens/home.screen.dart';
import 'package:flaq/screens/notification_approval.screen.dart';
import 'package:flaq/screens/open_settings.screen.dart';
import 'package:flaq/screens/sms_open_settings.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/root.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:optimize_battery/optimize_battery.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = "http://52.66.228.64:4000/api/v1";

class ApiService extends GetConnect implements GetxService {
  @override
  void onInit() {
    super.onInit();
    httpClient.addRequestModifier<dynamic>((request) async {
      Get.printInfo(info: 'Request - ${request.url}');
      request.headers['x-auth-token'] =
          '${await Get.find<AuthService>().getUserToken()}';
      return request;
    });
    httpClient.addResponseModifier((request, response) {
      if (response.hasError) {
        Get.printError(info: 'Response - ${response.bodyString}');
      } else {
        Get.printInfo(info: response.bodyString ?? '');
      }
      return response;
    });
    // httpClient.baseUrl = 'https://6b2f-125-22-99-42.in.ngrok.io/api/v1';
    httpClient.baseUrl = BASE_URL;
  }

  // Get the user's profile
  Future<FlaqUser?> getProfile() async {
    debugPrint('Getting profile');
    final res = await httpClient.get('/user/profile');
    if (res.hasError) {
      debugPrint("Error fetching profile");
      debugPrint(res.bodyString);
      return null;
    }
    debugPrint("Profile fetched");
    return UserProfileResponse.fromJson(res.body).data;
  }

  registerPayment(String amount) async {
    final res = await httpClient.post('/payments/register', body: {
      'amount': amount,
    });
    if (res.hasError) {
      debugPrint("Error registering payment");
      debugPrint(res.bodyString);
      return null;
    }
  }

  Future<List<Transaction>?> getAllPayments() async {
    await Future.delayed(const Duration(seconds: 1));
    final res = await httpClient.post('/payments/all');
    if (res.hasError) {
      debugPrint("Error fetching payments");
      debugPrint(res.bodyString);
      return null;
    }
    debugPrint(res.bodyString);
    debugPrint("Payments fetched");
    final data = TransactionDataResponse.fromJson(res.body).data;
    print(data?.length);
    return data;
  }

  checkReferralCode(String referralCode) async {
    EasyLoading.show();
    debugPrint('Checking Referral Code');
    final res = await httpClient.post('/user/referral/apply', body: {
      'referralCode': referralCode,
    });
    var jsonData = res.body;
    debugPrint(jsonData['message']);
    if (jsonData['statusCode'] != 200) {
      if (jsonData['message'] != null) {
        Helper.toast(jsonData['message']);
      }
    } else {
      debugPrint("Referral Code checked successfully");
      final apiService = Get.find<ApiService>();

      var user = (await apiService.getProfile());

      if (user!.isAllowed) {
        if (true) {
          if (await Permission.sms.isGranted) {
            if (await OptimizeBattery.isIgnoringBatteryOptimizations()) {
              Get.offAll(() => const DashBoard());
              EasyLoading.dismiss();
              return;
            } else {
              Get.offAll(() => const OpenSettingsScreen());
              EasyLoading.dismiss();
              return;
            }
          } else {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            bool permissionAsked = prefs.getBool('permissionAsked') ?? false;
            if (!permissionAsked) {
              Get.offAll(() => const SmsApprovalScreen());
              EasyLoading.dismiss();
              return;
            } else {
              Get.offAll(() => const SmsOpenSettingsScreen());
              EasyLoading.dismiss();
              return;
            }
          }
        }
      }
      if (!user.isAllowed) {
        Get.offAll(() => const ReferralScreen());
        EasyLoading.dismiss();
        return;
      }
    }
    EasyLoading.dismiss();
  }
}
