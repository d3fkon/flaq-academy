import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:telephony/telephony.dart';

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
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('flaq_logo');
  flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: initializationSettingsAndroid));

  Future.delayed(const Duration(seconds: 3)).then(
    (value) => flutterLocalNotificationsPlugin.show(
      100,
      'Rewarded for $amount!',
      'You just earned some flaq. Let\'s go!',
      platformChannelSpecifics,
      payload: 'item x',
    ),
  );
}

class MessagingService extends GetxService {
  late Telephony telephony;

  Future<MessagingService> init() async {
    telephony = Telephony.instance;
    return this;
  }

  addSmsListener() {
    telephony.listenIncomingSms(
      onBackgroundMessage: backgroundMessageHandler,
      onNewMessage: backgroundMessageHandler,
    );
  }
}
