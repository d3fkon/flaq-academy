import 'package:firebase_core/firebase_core.dart';
import 'package:flaq/firebase_options.dart';
import 'package:flaq/main.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;

const bags = [
  ["Mode", "INR", "Account", "sent", "UPI"],
  ["Debited", "UPI, Rs", "Debited For"],
  ["Debited For", "Rs", "UPI", "BLOCK"],
  ["BLOCK", "UPI Ref No", "Rs", "Available", "If not done", "block", "report"],
  ['Debit', 'A/c no', 'UPI', "Bal", 'SMS', "Block"],
  ['a/c no', "debited", "UPI", "RRN", "AVL"]
];

final inrRegex = RegExp(r'INR (\d+(\.\d+)?)');
final rupeesRegex1 = RegExp(r'Rs (\d+(\.\d+)?)');
final rupeesRegex2 = RegExp(r'Rs\.(\d+(\.\d+)?)');

const platform = MethodChannel('club.flaq/notify');

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
  var match = rupeesRegex1.firstMatch(message);
  match ??= rupeesRegex2.firstMatch(message);
  match ??= inrRegex.firstMatch(message);
  double? amount;
  if (match != null) {
    amount = double.parse(match.group(1) ?? '');
  }
  return amount;
}

backgroundMessageHandler(SmsMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Handling background message");
  final testRes = test(message.body ?? '');
  if (!testRes) return;
  final amount = getTxnAmount(message.body ?? '');
  if (amount == null) return;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(() => ApiService());
  await Get.find<ApiService>().registerPayment(amount.toString());

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
