import 'package:flaq/models/transaction.model.dart';
import 'package:flaq/models/user.model.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
