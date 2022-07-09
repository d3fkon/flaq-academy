import 'package:flaq/screens/about_frontier.dart';
import 'package:flaq/screens/flaqBank.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/services/messaging.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date) => DateFormat("dd/MM HH:mm").format(date);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late final DataService dataService;
  List<String> lockedUnlocked = [
    'unlocked',
    'locked',
    'locked',
  ];
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

  @override
  void initState() {
    super.initState();
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
      body: SafeArea(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: Obx(
                                        () => text(
                                          '${dataService.totalFlaqRewarded}',
                                          FontWeight.w500,
                                          30,
                                          Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: GestureDetector(
                                onTap: () {},
                                child: circleAvatar(
                                  12,
                                  const Color(0xFF9999A5),
                                  customIcon(
                                    Icons.person,
                                    Colors.black,
                                    size: 18,
                                  ),
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
                      itemCount: 3,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.fromLTRB(20, 0, 20, 8)
                              : const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                          child: lockedUnlocked[index] == 'unlocked'
                              ? Container(
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
                                              'frontier',
                                              FontWeight.w500,
                                              18,
                                              Colors.black,
                                            ),
                                            circleAvatar(
                                              13,
                                              Colors.transparent,
                                              showAssetImage(
                                                  'assets/images/frontier.png'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      verticalSpace(customHeight * 0.01),
                                      text(
                                        'a Crypto & DeFi, NFT wallet where you can send, store & invest in 4,000+ crypto assets',
                                        FontWeight.w500,
                                        12,
                                        Colors.black,
                                      ),
                                      verticalSpace(customHeight * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          textWorkSans(
                                            lockedUnlocked[index],
                                            FontWeight.w500,
                                            14,
                                            Colors.black,
                                          ),
                                          customButton(
                                            customHeight * 0.04,
                                            customWidth * 0.42,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                text(
                                                  'take the quiz',
                                                  FontWeight.w700,
                                                  12,
                                                  Colors.white,
                                                ),
                                                horizontalSpace(
                                                    customWidth * 0.02),
                                                customIcon(
                                                  Icons.arrow_forward,
                                                  Colors.white,
                                                  size: 15,
                                                ),
                                              ],
                                            ),
                                            () {
                                              Get.to(
                                                  () => const WhatIsFrontier());
                                            },
                                            Colors.black,
                                            4,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF9999A5),
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
                                                'filecoin',
                                                FontWeight.w500,
                                                18,
                                                Colors.white,
                                              ),
                                              circleAvatar(
                                                13,
                                                Colors.transparent,
                                                showAssetImage(
                                                    'assets/images/filecoin.png'),
                                              ),
                                            ],
                                          )),
                                      verticalSpace(customHeight * 0.01),
                                      text(
                                        'a Crypto & DeFi, NFT wallet where you can send, store & invest in 4,000+ crypto assets',
                                        FontWeight.w500,
                                        12,
                                        Colors.white,
                                      ),
                                      verticalSpace(customHeight * 0.01),
                                      index == 2
                                          ? Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: textWorkSans(
                                                'unlocks in 17:05:21',
                                                FontWeight.w500,
                                                14,
                                                Colors.white,
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                textWorkSans(
                                                  lockedUnlocked[index],
                                                  FontWeight.w500,
                                                  14,
                                                  Colors.white,
                                                ),
                                                customButton(
                                                  customHeight * 0.04,
                                                  customWidth * 0.42,
                                                  Obx(
                                                    () => text(
                                                      'use ${dataService.totalFlaqRewarded} flaq',
                                                      FontWeight.w700,
                                                      12,
                                                      Colors.black,
                                                    ),
                                                  ),
                                                  () {
                                                    Get.to(() =>
                                                        const WhatIsFrontier());
                                                  },
                                                  Colors.white,
                                                  4,
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                        );
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
