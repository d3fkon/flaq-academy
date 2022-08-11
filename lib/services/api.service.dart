import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flaq/models/campaignModel.dart';
import 'package:flaq/models/quizModel.dart';
import 'package:flaq/models/rewards.model.dart';
import 'package:flaq/models/transaction.model.dart';
import 'package:flaq/models/user.model.dart';
import 'package:flaq/screens/auth/referral.dart';

import 'package:flaq/screens/home/scaffold.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const BASE_URL_GO = "https://api.flaq.club";

class ApiService extends GetConnect implements GetxService {
  @override
  void onInit() {
    super.onInit();
    httpClient.addRequestModifier<dynamic>((request) async {
      Get.printInfo(info: 'Request - ${request.url}');
      request.headers['Authorization'] =
          'Bearer ${await Get.find<AuthService>().getUserToken()}';

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
    httpClient.baseUrl = BASE_URL_GO;
  }

  //sign up user
  Future signup(String email, String password) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      try {
        EasyLoading.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        debugPrint('Signing up the user');
        final res = await httpClient.post('/auth/signup',
            body: jsonEncode({"Email": email, "Password": password}));
        var jsonData = res.body;
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
        final fcmToken = await FirebaseMessaging.instance.getToken();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        debugPrint('logging in the user');
        final res = await httpClient.post('/auth/login',
            body: jsonEncode({
              "DeviceToken": fcmToken,
              "Email": email,
              "Password": password
            }));
        var jsonData = res.body;
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
        final res = await httpClient.post('/auth/token/refresh',
            body: jsonEncode({"RefreshToken": refreshtoken}));
        var jsonData = res.body;
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
        final res = await httpClient.get(
          '/users/profile',
        );
        var jsonData = res.body;
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
          return UserProfileResponse.fromJson(res.body).data;
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
        debugPrint('registering the payment');
        final res = await httpClient.post('/payments/register',
            body: jsonEncode(
              {"Amount": amount},
            ));
        var jsonData = res.body;
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
  // Future<List<Transaction>?> getAllPayments() async {
  //   bool internet = await Helper().checkInternetConnectivity();
  //   if (internet) {
  //     await Future.delayed(const Duration(seconds: 1));
  //     debugPrint('Getting payments');
  //     try {
  //       EasyLoading.show();
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       var accessToken = prefs.getString('ACCESSTOKEN');
  //       final res = await http.get(Uri.parse('$BASE_URL_GO/payments'),
  //           headers: {'Authorization': 'Bearer $accessToken'});
  //       var jsonData = jsonDecode(res.body);
  //       if (jsonData['StatusCode'] == 401) {
  //         await refreshToken();
  //         await getAllPayments();
  //       } else if (jsonData['StatusCode'] != 200) {
  //         if (jsonData['Message'] != null) {
  //           Helper.toast(jsonData['Message']);
  //         }
  //       } else {
  //         debugPrint("payments fetched successfully");
  //         return TransactionDataResponse.fromJson(jsonData).data;
  //       }
  //       EasyLoading.dismiss();
  //     } catch (e) {
  //       Helper.toast('error, please try again');
  //       debugPrint('error: $e');
  //       EasyLoading.dismiss();
  //     }
  //   } else {
  //     Helper.toast('please enable your internet connection');
  //     return null;
  //   }
  // }

  // check referral code
  Future checkReferralCode(String referralCode) async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      try {
        EasyLoading.show();
        debugPrint('Checking Referral Code');
        final res = await httpClient.post(
          '/users/apply-referral',
          body: jsonEncode({"ReferralCode": referralCode}),
        );
        var jsonData = res.body;
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
              Get.offAll(() => const HomeScaffold());
              EasyLoading.dismiss();
              return;
            } else {
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
  Future<CampaignData?> getCampaigns() async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      debugPrint('Getting Campaigns');
      try {
        EasyLoading.show();
        final res = await httpClient.get(
          '/campaign',
        );
        var jsonData = res.body;
        debugPrint(jsonData.toString());
        if (jsonData['StatusCode'] == 401) {
          await refreshToken();
          debugPrint("Access Token Not Valid");
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
          return CampaignResponse.fromJson(res.body).data;
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
        debugPrint('participating in the campaign');
        final res = await httpClient.post(
          '/campaign/participate',
          body: jsonEncode(
            {"CampaignId": campaignId},
          ),
        );
        var jsonData = res.body;
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
        final res = await httpClient.get(
          '/campaign/$campaignId/quiz',
        );
        var jsonData = res.body;
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
          return QuizResponse.fromJson(res.body);
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
        debugPrint('evaluating the quiz');
        final res = await httpClient.post(
          '/campaign/quiz/evaluate',
          body: jsonEncode(
            {
              "Answers": answers,
              "CampaignParticipationId": participationId,
              "QuizTemplateId": quizId
            },
          ),
        );
        var jsonData = res.body;
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
  Future<List<Reward>?> getRewards() async {
    bool internet = await Helper().checkInternetConnectivity();
    if (internet) {
      debugPrint('Getting rewards');
      try {
        EasyLoading.show();
        final res = await httpClient.get(
          '/rewards',
        );
        var jsonData = res.body;
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
          return RewardResponse.fromJson(res.body).data;
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
