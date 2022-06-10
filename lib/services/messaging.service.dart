import 'package:flaq/main.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;

const bags = [
  ["Mode", "INR", "Account", "sent", "UPI"],
  ["Debited", "UPI, Rs", "Debited For"],
  ["Debited For", "Rs", "UPI", "BLOCK"]
];

final inrRegex = RegExp(r'INR (\d+(\.\d+)?)');
final rupeesRegex = RegExp(r'Rs (\d+(\.\d+)?)');

test(String message) {
  final res = bags.any((bag) {
    final arr =
        bag.map((word) => message.toLowerCase().contains(word.toLowerCase()));
    return !arr.contains(false);
  });
  return res;
}

/// Get the transactin amount from the message
getTxnAmount(String message) {
  var match = rupeesRegex.firstMatch(message);
  match ??= inrRegex.firstMatch(message);
  double? amount;
  if (match != null) {
    amount = double.parse(match.group(1) ?? '');
  }
  return amount;
}

backgroundMessageHandler(SmsMessage message) async {
  print("Handling background message");
  final testRes = test(message.body ?? '');
  if (!testRes) return;
  final amount = getTxnAmount(message.body ?? '');
  if (amount == null) return;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future.delayed(const Duration(seconds: 3)).then(
    (value) => flutterLocalNotificationsPlugin.show(
      100,
      'You earned $amount flaq!',
      'Tap now to claim your reward',
      PLATFORM_CHANNEL_SPECIFICS,
      payload: '$amount',
    ),
  );
}

class MessagingService extends GetxService {
  late Telephony telephony;

  Future<MessagingService> init() async {
    telephony = Telephony.instance;
    telephony.listenIncomingSms(
      onBackgroundMessage: backgroundMessageHandler,
      onNewMessage: backgroundMessageHandler,
    );
    return this;
  }
}
