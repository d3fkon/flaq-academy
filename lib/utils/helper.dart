import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Helper {
  static toast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }

  static showRewardReceipt(String payload) {
    Dialogs.materialDialog(
      color: Colors.white,
      msg: 'you earned $payload flaq',
      title: 'Congratulations',
      lottieBuilder: Lottie.asset(
        'assets/animations/success.json',
        fit: BoxFit.contain,
      ),
      barrierDismissible: false,
      context: Get.context as BuildContext,
      actions: [
        IconsButton(
          onPressed: () async {
            await Get.find<DataService>().fetchTransactions();
            Get.back();
          },
          text: 'Claim',
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  static String? validateReferralCode(String? value) {
    String pattern = r"\w{3}-\w{3}";
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'referral code is required';
    } else if (!regExp.hasMatch(value)) {
      return 'invalid referral code format';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'enter a valid email address';
    } else {
      return null;
    }
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static String? ytId;
  static String? getYoutubeVideoIdByURL(String? url) {
    return YoutubePlayer.convertUrlToId(url!);
  }
}
