import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/data.service.dart';
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
  final testRes = test(message.body ?? '');
  if (!testRes) return;
  final amount = getTxnAmount(message.body ?? '');
  if (amount == null) return;
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    '1234',
    'FLAQ',
    channelDescription: 'Reward Notification',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    subText: "You've received a reward",
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('flaq_logo');
  flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(android: initializationSettingsAndroid),
    onSelectNotification: (payload) async {
      print("IN ON SELECT NOTIFICATION");
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final key = sp.getString("AUTHKEY");
      if (key == null) return;

      try {
        await http.post(Uri.parse("$BASE_URL/payments/register"), body: {
          "amount": amount.toString()
        }, headers: {
          'x-auth-token': key,
        });
      } catch (e) {
        print(e);
      }
    },
  );

  Future.delayed(const Duration(seconds: 3)).then(
    (value) => flutterLocalNotificationsPlugin.show(
      100,
      'Flaq Rewarded for $amount!',
      'You just earned some flaq. Tap this notification to claim it!',
      platformChannelSpecifics,
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
