import 'package:flaq/models/campaignModel.dart';
import 'package:flaq/models/user.model.dart';
import 'package:flaq/screens/about_frontier.dart';
import 'package:flaq/screens/dashboard.dart';
import 'package:flaq/screens/flaqBank.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/services/messaging.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String formatDate(DateTime date) => DateFormat("dd/MM HH:mm").format(date);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late final DataService dataService;
  CampaignData? campaigns;
  String participationID = '';
  bool isLoading = true;
  FlaqUser? user;
  List participationIds = [];
  List completed = [];
  Widget circleAvatar(
    double radius,
    Color color,
    Widget child,
  ) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: child,
    );
  }

  Widget textButton(VoidCallback onPressed, Widget child) {
    return TextButton(onPressed: onPressed, child: child);
  }

  load() async {
    setState(() {
      isLoading = true;
    });
    EasyLoading.show();
    user = await Get.find<ApiService>().getProfile();
    campaigns = await Get.find<ApiService>().getCampaigns();
    if (campaigns != null) {
      if (mounted) {
        setState(() {
          for (int k = 0; k < campaigns!.campaigns!.length; k++) {
            completed.add(false);
          }
          for (int i = 0; i < campaigns!.participations!.length; i++) {
            for (int j = 0; j < campaigns!.campaigns!.length; j++) {
              if (campaigns!.participations![i].campaign!.id ==
                  campaigns!.campaigns![j].id) {
                completed[j] = campaigns!.participations![i].isComplete;
              }
            }
          }
          isLoading = false;
        });
        EasyLoading.dismiss();
      }
    }
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    Helper.ytId = '';
    load();
    dataService = Get.find();
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      dataService.fetchTransactions();
    });
    Get.putAsync(() => MessagingService().init());
  }

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0C0E),
      body: isLoading
          ? const SizedBox(
              height: 0,
              width: 0,
            )
          : SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 100));
                  dataService.fetchTransactions();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFF1D1D1D),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              verticalSpace(customHeight * 0.06),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: text(
                                          'flaq points',
                                          FontWeight.w400,
                                          18,
                                          Colors.white,
                                        ),
                                      ),
                                      verticalSpace(customHeight * 0.005),
                                      Row(
                                        children: [
                                          showAssetImage(
                                            'assets/images/icon-1.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          horizontalSpace(customWidth * 0.01),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: text(
                                              '${user!.flaqPoints}',
                                              FontWeight.w500,
                                              30,
                                              Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.offAll(() {
                                          return const DashBoard(tab: 1);
                                        });
                                      },
                                      child: const Icon(
                                        TablerIcons.wallet,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(customHeight * 0.025),
                              Align(
                                alignment: Alignment.topLeft,
                                child: text(
                                  'flaq rewards you for every upi payment you make which you can then redeem for front tokens',
                                  FontWeight.w500,
                                  12,
                                  Colors.white,
                                ),
                              ),
                              verticalSpace(customHeight * 0.025),
                              customButton(
                                customHeight * 0.06,
                                customWidth * 0.9,
                                text(
                                  'earn flaq',
                                  FontWeight.w700,
                                  14,
                                  Colors.black,
                                ),
                                () {
                                  Get.to(() => const FlaqBankScreen());
                                  // Get.snackbar(
                                  //   "Coming Soon",
                                  //   "Claiming Rewards is coming soon",
                                  //   backgroundColor: Colors.black,
                                  //   colorText: Colors.white,
                                  // );
                                },
                                Colors.white,
                                4,
                              ),
                              verticalSpace(customHeight * 0.025),
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(customHeight * 0.022),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: text(
                            'learn and earn',
                            FontWeight.w400,
                            18,
                            Colors.white,
                          ),
                        ),
                      ),
                      verticalSpace(customHeight * 0.022),
                      SizedBox(
                        width: customWidth,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: campaigns!.campaigns!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              if (campaigns!.participations!.isNotEmpty) {
                                for (int i = 0;
                                    i < campaigns!.participations!.length;
                                    i++) {
                                  participationIds.add(campaigns!
                                      .participations![i].campaign!.id);
                                }
                              }

                              return Padding(
                                  padding: index == 0
                                      ? const EdgeInsets.fromLTRB(20, 0, 20, 8)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 8,
                                        ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              text(
                                                campaigns!
                                                    .campaigns![index].title
                                                    .toString(),
                                                FontWeight.w500,
                                                18,
                                                Colors.black,
                                              ),
                                              circleAvatar(
                                                13,
                                                Colors.transparent,
                                                showNetworkImage(campaigns!
                                                    .campaigns![index]
                                                    .tickerImageUrl
                                                    .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalSpace(customHeight * 0.01),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: text(
                                            campaigns!
                                                .campaigns![index].description
                                                .toString(),
                                            FontWeight.w500,
                                            12,
                                            Colors.black,
                                          ),
                                        ),
                                        verticalSpace(customHeight * 0.01),
                                        completed[index] == true
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                child: textWorkSans(
                                                  'quiz completed',
                                                  FontWeight.w500,
                                                  14,
                                                  Colors.black,
                                                ),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  participationIds.contains(
                                                          campaigns!
                                                              .campaigns![index]
                                                              .id)
                                                      ? textWorkSans(
                                                          'unlocked',
                                                          FontWeight.w500,
                                                          14,
                                                          Colors.black,
                                                        )
                                                      : textWorkSans(
                                                          'earn ${campaigns!.campaigns![index].airdropPerUser} ${campaigns!.campaigns![index].tickerName}',
                                                          FontWeight.w500,
                                                          14,
                                                          Colors.black,
                                                        ),
                                                  customButton(
                                                    customHeight * 0.04,
                                                    customWidth * 0.42,
                                                    participationIds.contains(
                                                            campaigns!
                                                                .campaigns![
                                                                    index]
                                                                .id)
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              text(
                                                                'take the quiz',
                                                                FontWeight.w700,
                                                                12,
                                                                Colors.white,
                                                              ),
                                                              horizontalSpace(
                                                                  customWidth *
                                                                      0.02),
                                                              customIcon(
                                                                Icons
                                                                    .arrow_forward,
                                                                Colors.white,
                                                                size: 15,
                                                              ),
                                                            ],
                                                          )
                                                        : text(
                                                            'use ${campaigns!.campaigns![index].requiredFlaq} flaq',
                                                            FontWeight.w700,
                                                            12,
                                                            Colors.white,
                                                          ),
                                                    () {
                                                      setState(() {
                                                        Helper.ytId = Helper
                                                            .getYoutubeVideoIdByURL(
                                                                campaigns!
                                                                    .campaigns![
                                                                        index]
                                                                    .ytVideoUrl);
                                                        for (int i = 0;
                                                            i <
                                                                campaigns!
                                                                    .participations!
                                                                    .length;
                                                            i++) {
                                                          if (campaigns!
                                                                  .participations![
                                                                      i]
                                                                  .campaign!
                                                                  .id ==
                                                              campaigns!
                                                                  .campaigns![
                                                                      index]
                                                                  .id) {
                                                            participationID =
                                                                campaigns!
                                                                    .participations![
                                                                        i]
                                                                    .id!;
                                                          }
                                                        }
                                                      });

                                                      participationIds.contains(
                                                              campaigns!
                                                                  .campaigns![
                                                                      index]
                                                                  .id)
                                                          ? Get.to(() =>
                                                              WhatIsFrontier(
                                                                campaign: campaigns!
                                                                        .campaigns![
                                                                    index],
                                                                participationId:
                                                                    participationID,
                                                              ))
                                                          : showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: text(
                                                                    'Confirmation',
                                                                    FontWeight
                                                                        .w600,
                                                                    18,
                                                                    Colors
                                                                        .black,
                                                                  ),
                                                                  content: text(
                                                                    'are you sure you want to participate in this campaign using ${campaigns!.campaigns![index].requiredFlaq} flaq points?',
                                                                    FontWeight
                                                                        .w500,
                                                                    14,
                                                                    Colors.grey,
                                                                  ),
                                                                  actions: [
                                                                    customButton(
                                                                      customHeight *
                                                                          0.06,
                                                                      customWidth *
                                                                          0.3,
                                                                      text(
                                                                        'No',
                                                                        FontWeight
                                                                            .w600,
                                                                        14,
                                                                        Colors
                                                                            .grey,
                                                                      ),
                                                                      () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      Colors
                                                                          .white,
                                                                      4,
                                                                    ),
                                                                    customButton(
                                                                      customHeight *
                                                                          0.06,
                                                                      customWidth *
                                                                          0.3,
                                                                      text(
                                                                        'Yes',
                                                                        FontWeight
                                                                            .w600,
                                                                        14,
                                                                        Colors
                                                                            .white,
                                                                      ),
                                                                      () async {
                                                                        var participated =
                                                                            await Get.find<ApiService>().participateInCampaign(campaigns!.campaigns![index].id ??
                                                                                '');
                                                                        if (participated) {
                                                                          EasyLoading
                                                                              .show();
                                                                          campaigns =
                                                                              await Get.find<ApiService>().getCampaigns();
                                                                          if (campaigns !=
                                                                              null) {
                                                                            if (mounted) {
                                                                              setState(() {
                                                                                for (int i = 0; i < campaigns!.participations!.length; i++) {
                                                                                  if (campaigns!.participations![i].campaign!.id == campaigns!.campaigns![index].id) {
                                                                                    participationID = campaigns!.participations![i].id!;
                                                                                  }
                                                                                }
                                                                                Navigator.pop(context);
                                                                                Get.to(() => WhatIsFrontier(
                                                                                      campaign: campaigns!.campaigns![index],
                                                                                      participationId: participationID,
                                                                                    ));
                                                                                EasyLoading.dismiss();
                                                                              });
                                                                            }
                                                                          }
                                                                        } else {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Helper.toast(
                                                                              'error participating, please try again');
                                                                        }
                                                                      },
                                                                      Colors
                                                                          .black,
                                                                      4,
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                    },
                                                    Colors.black,
                                                    4,
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                      verticalSpace(customHeight * 0.025),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
