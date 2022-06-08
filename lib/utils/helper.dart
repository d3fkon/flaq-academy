import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  static toast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
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
}
