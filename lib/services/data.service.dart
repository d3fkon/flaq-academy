import 'package:flaq/models/transaction.model.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class DataService extends GetxService {
  late final ApiService _apiService;
  final RxList<Transaction> _txnList = <Transaction>[].obs;
  get txnList => _txnList.value.reversed.toList();
  get totalFlaqRewarded {
    var total = 0.0;
    for (var txn in _txnList.value) {
      total += double.parse(txn.flaqReward.toString());
    }
    return total;
  }

  @override
  void onReady() async {
    super.onReady();
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    final payload = notificationAppLaunchDetails?.payload;
    if (payload != null) {
      Helper.showRewardReceipt(payload);
      registerTxn(payload);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  fetchTransactions() async {
    EasyLoading.show();
    _txnList(await _apiService.getAllPayments() ?? []);
    EasyLoading.dismiss();
  }

  registerTxn(String amount) async {
    await _apiService.registerPayment(amount);
  }
}
