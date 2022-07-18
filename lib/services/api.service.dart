import 'dart:convert';

import 'package:flaq/models/campaignModel.dart';
import 'package:flaq/models/quizModel.dart';
import 'package:flaq/models/rewards.model.dart';
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
import 'package:http/http.dart' as http;

const BASE_URL = "http://52.66.228.64:4000/api/v1";
const BASE_URL_GO = "http://52.66.228.64:8080";

class ApiService extends GetConnect implements GetxService {
  @override
  void onInit() {
    super.onInit();
  }

  //sign up user
  Future signup(String email, String password) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        debugPrint('Signing up the user');
        final res = await http.post(
          Uri.parse('$BASE_URL_GO/auth/signup'),
          body: jsonEncode({"Email": email, "Password": password}),
        );
        var jsonData = jsonDecode(res.body);
        if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
          }
        } else {
          await prefs.setString(
              "REFRESHTOKEN", jsonData['Data']['RefreshToken']);
          await prefs.setString("ACCESSTOKEN", jsonData['Data']['AccessToken']);
          debugPrint("signed up successfully");
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  //login the user
  Future login(String email, String password) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        debugPrint('logging in the user');
        final res = await http.post(
          Uri.parse('$BASE_URL_GO/auth/login'),
          body: jsonEncode({"Email": email, "Password": password}),
        );
        var jsonData = jsonDecode(res.body);
        debugPrint(jsonData.toString());
        if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
          }
          EasyLoading.dismiss();
          return false;
        } else {
          await prefs.setString(
              "REFRESHTOKEN", jsonData['Data']['RefreshToken']);
          await prefs.setString("ACCESSTOKEN", jsonData['Data']['AccessToken']);
          debugPrint("logged in successfully");
          EasyLoading.dismiss();
          return true;
        }
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
        return false;
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  //refresh token
  Future refreshToken() async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var refreshtoken = prefs.getString('REFRESHTOKEN');
        debugPrint('refreshing the token');
        final res = await http.post(
          Uri.parse('$BASE_URL_GO/auth/token/refresh'),
          body: jsonEncode({"RefreshToken": refreshtoken}),
        );
        var jsonData = jsonDecode(res.body);
        if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
          }
        } else {
          await prefs.setString(
              "REFRESHTOKEN", jsonData['Data']['RefreshToken']);
          await prefs.setString("ACCESSTOKEN", jsonData['Data']['AccessToken']);
          debugPrint("refresh successfully");
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
      }
    } else {
      Helper.toast('please enable your internet connection');
    }
  }

  // Get the user's profile
  Future<FlaqUser?> getProfile() async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      debugPrint('Getting profile');
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        final res =
            await http.get(Uri.parse('$BASE_URL_GO/users/profile'), headers: {
          'Authorization': 'Bearer $accessToken',
        });
        var jsonData = jsonDecode(res.body);
        debugPrint(jsonData.toString());
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await getProfile();
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
            return null;
          }
        } else {
          debugPrint("profile fetched successfully");
          EasyLoading.dismiss();
          return UserProfileResponse.fromJson(jsonData).data;
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  //register payment
  registerPayment(String amount) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        debugPrint('registering the payment');
        final res = await http.post(Uri.parse('$BASE_URL_GO/payments/register'),
            body: jsonEncode(
              {"Amount": amount},
            ),
            headers: {'Authorization': 'Bearer $accessToken'});
        var jsonData = jsonDecode(res.body);
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await registerPayment(amount);
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
            return null;
          }
        } else {
          debugPrint("payment registered successfully");
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');

        EasyLoading.dismiss();
        return null;
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  // get all payments
  Future<List<Transaction>?> getAllPayments() async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('Getting payments');
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        final res = await http.get(Uri.parse('$BASE_URL_GO/payments'),
            headers: {'Authorization': 'Bearer $accessToken'});
        var jsonData = jsonDecode(res.body);
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await getAllPayments();
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
          }
        } else {
          debugPrint("payments fetched successfully");
          return TransactionDataResponse.fromJson(jsonData).data;
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  // check referral code
  Future checkReferralCode(String referralCode) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        debugPrint('Checking Referral Code');
        final res = await http.post(
            Uri.parse('$BASE_URL_GO/users/apply-referral'),
            body: jsonEncode({"ReferralCode": referralCode}),
            headers: {'Authorization': 'Bearer $accessToken'});
        var jsonData = jsonDecode(res.body);
        debugPrint(jsonData['Message']);
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await checkReferralCode(referralCode);
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
          }
        } else {
          debugPrint("Referral Code checked successfully");
          final apiService = Get.find<ApiService>();

          var user = (await apiService.getProfile());
          if (user != null) {
            if (user.isAllowed == true) {
              if (true) {
                if (await Permission.sms.isGranted) {
                  if (await OptimizeBattery.isIgnoringBatteryOptimizations()) {
                    Get.offAll(() => const DashBoard(
                          tab: 0,
                        ));
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
                  bool permissionAsked =
                      prefs.getBool('permissionAsked') ?? false;
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
          }
          if (user != null && user.isAllowed != null) {
            if (user.isAllowed == false) {
              Get.offAll(() => const ReferralScreen());
              EasyLoading.dismiss();
              return;
            }
          }
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  // get all campaigns
  getCampaigns() async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      debugPrint('Getting Campaigns');
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        final res =
            await http.get(Uri.parse('$BASE_URL_GO/campaign'), headers: {
          'Authorization': 'Bearer $accessToken',
        });
        var jsonData = jsonDecode(res.body);
        debugPrint(jsonData.toString());
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await getCampaigns();
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
            EasyLoading.dismiss();
            return null;
          }
        } else {
          debugPrint("campaigns fetched successfully");
          EasyLoading.dismiss();
          return CampaignResponse.fromJson(jsonDecode(res.body)).data;
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  // participate in the quiz
  participateInCampaign(String campaignId) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        debugPrint('participating in the campaign');
        final res =
            await http.post(Uri.parse('$BASE_URL_GO/campaign/participate'),
                body: jsonEncode(
                  {"CampaignId": campaignId},
                ),
                headers: {'Authorization': 'Bearer $accessToken'});
        var jsonData = jsonDecode(res.body);
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await participateInCampaign(campaignId);
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
            EasyLoading.dismiss();
            return false;
          }
        } else {
          debugPrint("participated successfully");
          EasyLoading.dismiss();
          return true;
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
        return false;
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  // Get the quiz
  getQuiz(String campaignId) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      debugPrint('Getting quiz');
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        final res = await http
            .get(Uri.parse('$BASE_URL_GO/campaign/$campaignId/quiz'), headers: {
          'Authorization': 'Bearer $accessToken',
        });
        var jsonData = jsonDecode(res.body);
        debugPrint(jsonData.toString());
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await getQuiz(campaignId);
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
            return null;
          }
        } else {
          debugPrint("quiz fetched successfully");
          EasyLoading.dismiss();
          return quizResponseFromJson(res.body);
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  // evaluate quiz
  evaluateQuiz(List answers, String quizId, String participationId) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        debugPrint('evaluating the quiz');
        final res =
            await http.post(Uri.parse('$BASE_URL_GO/campaign/quiz/evaluate'),
                body: jsonEncode(
                  {
                    "Answers": answers,
                    "CampaignParticipationId": participationId,
                    "QuizTemplateId": quizId
                  },
                ),
                headers: {'Authorization': 'Bearer $accessToken'});
        var jsonData = jsonDecode(res.body);
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await evaluateQuiz(answers, quizId, participationId);
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
            EasyLoading.dismiss();
            return false;
          }
        } else {
          debugPrint("evaluated successfully");
          debugPrint(jsonData.toString());
          EasyLoading.dismiss();
          return jsonData;
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
        return false;
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  // get all rewards
  Future<List<RewardDatum>?> getRewards() async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      debugPrint('Getting rewards');
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        final res = await http.get(Uri.parse('$BASE_URL_GO/rewards'), headers: {
          'Authorization': 'Bearer $accessToken',
        });
        var jsonData = jsonDecode(res.body);
        debugPrint(jsonData.toString());
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await getRewards();
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
            return null;
          }
        } else {
          debugPrint("rewards fetched successfully");
          EasyLoading.dismiss();
          return Reward.fromJson(jsonData).data;
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }

  // get all campaigns
  getConversions() async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      debugPrint('Getting Conversions');
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var accessToken = prefs.getString('ACCESSTOKEN');
        final res = await http
            .get(Uri.parse('$BASE_URL_GO/campaign/conversion'), headers: {
          'Authorization': 'Bearer $accessToken',
        });
        var jsonData = jsonDecode(res.body);
        debugPrint(jsonData.toString());
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          await getCampaigns();
        } else if (jsonData['StatusCode'] != 200) {
          if (jsonData['Message'] != null) {
            Helper.toast(jsonData['Message']);
            EasyLoading.dismiss();
            return null;
          }
        } else {
          debugPrint("conversion fetched successfully");
          EasyLoading.dismiss();
          return jsonData['Data'];
        }
        EasyLoading.dismiss();
      } catch (e) {
        Helper.toast('error, please try again');
        debugPrint('error: $e');
        EasyLoading.dismiss();
      }
    } else {
      Helper.toast('please enable your internet connection');
      return null;
    }
  }
}
