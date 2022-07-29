import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/utils/constants.dart';
import 'package:flaq/widgets/common.dart';
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
            // await Get.find<DataService>().fetchTransactions();
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

  static String? getYoutubeVideoIdByURL(String? url) {
    return YoutubePlayer.convertUrlToId(url!);
  }

  static dialog({
    required String title,
    required String description,
    required VoidCallback onYes,
  }) {
    Get.bottomSheet(
      Container(
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Empty.V(24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Empty.V(24),
              Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(21, 25, 32, 0.5),
                ),
              ),
              Empty.V(24),
              const Expand(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: FLAQ_BORDER_RADIUS,
                          border: Border.all(
                            color: const Color(0xff566789),
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "cancel",
                              style: TextStyle(
                                color: Color.fromRGBO(21, 25, 32, 0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Empty.H(24),
                  Expanded(
                    child: GestureDetector(
                      onTap: onYes,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: FLAQ_BORDER_RADIUS,
                          color: const Color(0xff1A1A1A),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "got it",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Empty.V(24)
            ],
          ),
        ),
      ),
    );
  }
}
