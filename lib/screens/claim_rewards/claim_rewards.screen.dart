import 'package:flaq/screens/claim_rewards/tabs/flaqBalance.dart';
import 'package:flaq/screens/claim_rewards/tabs/yourWallet.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClaimRewardsScreen extends StatefulWidget {
  const ClaimRewardsScreen({Key? key}) : super(key: key);

  @override
  State<ClaimRewardsScreen> createState() => _ClaimRewardsScreenState();
}

class _ClaimRewardsScreenState extends State<ClaimRewardsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool walletConnected = false;
  late final DataService dataService;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    dataService = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFF0E0C0E),
        body: SafeArea(
            child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: Column(children: [
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
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: customHeight * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            walletConnected
                                ? Row(
                                    children: [
                                      Text(
                                        '0x67b',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        width: customWidth * 0.011,
                                      ),
                                      // Image.asset(
                                      //     'assets/images/walletConnectedIcon.png'
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 12,
                                        child: Image.asset(
                                          'assets/images/walletConnectedIcon.png',
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                          ],
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
                    SizedBox(
                      height: customHeight * 0.025,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'user your flaq balance in order to withdraw your frontier rewards into your wallet',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: customHeight * 0.03,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: customHeight * 0.02,
            ),
            Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  indicatorWeight: 2,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                  tabs: [
                    Tab(
                      text: 'FLAQ BALANCE',
                    ),
                    Tab(
                      text: 'YOUR WALLET',
                    )
                  ],
                ),
                Container(
                  width: customWidth * 0.9,
                  height: customHeight * 0.6,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      FlaqBalance(
                        walletConnected: walletConnected,
                      ),
                      YourWallet(
                        walletConnected: walletConnected,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
        )));
  }
}
