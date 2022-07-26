// ignore_for_file: invalid_use_of_protected_member

import 'package:flaq/models/campaignModel.dart';
import 'package:flaq/models/rewards.model.dart';
import 'package:flaq/models/transaction.model.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class DataService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  // Initialize the API Service
  late final ApiService _apiService;

  // List of rewards for the user
  final RxList<Reward> _rewardList = <Reward>[].obs;

  // List all the rewards for the user
  List<Reward> get rewards => _rewardList.value.reversed.toList();

  // Transaction list of the user
  final RxList<Transaction> _txnList = <Transaction>[].obs;

  // Get the transaction list
  get txnList => _txnList.value.reversed.toList();

  // List of Campaigns
  final RxList<Campaign> _campaigns = <Campaign>[].obs;
  List<Campaign> get campaigns => _campaigns.value.reversed.toList();

  // Get the campaign list
  final RxList<Participation> _participations = <Participation>[].obs;
  List<Participation> get participations =>
      _participations.value.reversed.toList();

  /// Check if the user is participating in a campaign or not
  /// Return the participation ID if true, else return null
  String? getParticipationId(String campaignId) {
    for (final participation in participations) {
      if (participation.campaign!.id == campaignId) {
        return participation.id;
      }
    }
    return null;
  }

  /// Get all complete participations
  List<Participation> getCompleteParticipations() {
    return participations.where((participation) {
      return participation.isComplete!;
    }).toList();
  }

  /// Get a list of ongoing participations
  List<Participation> getIncompeleteParticipations() {
    return participations.where((participation) {
      return !participation.isComplete!;
    }).toList();
  }

  // Fetch all the API data related to this service
  Future<void> fetchData() async {
    fetchCampaigns();
    fetchTransactions();
  }

  // Fetch all the available campaigns for the user
  Future<void> fetchCampaigns() async {
    EasyLoading.show();
    var campaignData = await _apiService.getCampaigns();
    _campaigns(campaignData?.campaigns);
    _participations(campaignData?.participations);
    EasyLoading.dismiss();
  }

  // Fetch the rewards for the user
  Future<void> fetchRewards() async {
    var rewardsData = await Get.find<ApiService>().getRewards();
    _rewardList(rewardsData);
  }

  /// Fetch all the transaction history for the user
  fetchTransactions() async {
    EasyLoading.show();
    _txnList(await _apiService.getAllPayments() ?? []);
    EasyLoading.dismiss();
  }

  /// Register a transaction for the user
  registerTxn(String amount) async {
    await _apiService.registerPayment(amount);
  }

  /// Enroll the user to a particular campaign
  Future<bool> enrollForCampaign(String campaignId) async {
    EasyLoading.show();
    var res = await _apiService.participateInCampaign(campaignId);
    // Refresh the data in the service
    await fetchCampaigns();
    EasyLoading.dismiss();
    return res;
  }

  Campaign? getCampaignForId(String id) {
    for (final campaign in campaigns) {
      if (campaign.id == id) {
        return campaign;
      }
    }
    return null;
  }

  /// Get the total flaq reward for the user using transactions as the base
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
}
