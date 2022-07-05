import 'package:flaq/screens/about_frontier.dart';
import 'package:flaq/screens/claim_rewards/claim_rewards.screen.dart';
import 'package:flaq/screens/flaqBank.dart';
import 'package:flaq/screens/quiz.dart';
import 'package:flaq/screens/withdrawFrontierForm.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/services/messaging.service.dart';
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
                        SizedBox(
                          height: customHeight * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'flaq points',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: customHeight * 0.005,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon-1.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: customWidth * 0.01,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Obx(
                                        () => Text(
                                          '${dataService.totalFlaqRewarded}',
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30,
                                          ),
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
                                child: const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Color(0xFF9999A5),
                                  child: Icon(
                                    Icons.person,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: customHeight * 0.025,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'flaq rewards you for every upi payment you make which you can then redeem for front tokens',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: customHeight * 0.025,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 0,
                                fixedSize: Size(
                                    customWidth * 0.9, customHeight * 0.06),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )),
                            onPressed: () {
                              Get.to(() => const FlaqBankScreen());
                              // Get.snackbar(
                              //   "Coming Soon",
                              //   "Claiming Rewards is coming soon",
                              //   backgroundColor: Colors.black,
                              //   colorText: Colors.white,
                              // );
                            },
                            child: const Text(
                              'earn flaq',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            )),
                        SizedBox(
                          height: customHeight * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.022,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'learn and earn',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.022,
                ),
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
                                              const Text(
                                                'frontier',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 13,
                                                child: Image.asset(
                                                    'assets/images/frontier.png'),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      const Text(
                                        'a Crypto & DeFi, NFT wallet where you can send, store & invest in 4,000+ crypto assets',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            lockedUnlocked[index],
                                            style: const TextStyle(
                                              fontFamily: 'WorkSans',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  fixedSize: Size(
                                                      customWidth * 0.42,
                                                      customHeight * 0.04)),
                                              onPressed: () {
                                                Get.to(() =>
                                                    const WhatIsFrontier());
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'take the quiz',
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: customWidth * 0.02,
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_forward,
                                                    size: 15,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              )),
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
                                              const Text(
                                                'filecoin',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 13,
                                                backgroundColor:
                                                    const Color(0xFF9999A5),
                                                child: Image.asset(
                                                    'assets/images/filecoin.png'),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      const Text(
                                        'a Crypto & DeFi, NFT wallet where you can send, store & invest in 4,000+ crypto assets',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      index == 2
                                          ? const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Text(
                                                'unlocks in 17:05:21',
                                                style: TextStyle(
                                                  fontFamily: 'WorkSans',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  lockedUnlocked[index],
                                                  style: const TextStyle(
                                                    fontFamily: 'WorkSans',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                            fixedSize: Size(
                                                                customWidth *
                                                                    0.42,
                                                                customHeight *
                                                                    0.04)),
                                                    onPressed: () {
                                                      Get.to(() =>
                                                          const WhatIsFrontier());
                                                    },
                                                    child: Obx(() => Text(
                                                          'use ${dataService.totalFlaqRewarded} flaq',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                          ),
                                                        ))),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                        );
                      }),
                ),
                SizedBox(
                  height: customHeight * 0.025,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
