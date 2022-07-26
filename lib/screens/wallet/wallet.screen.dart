import 'package:flaq/models/rewards.model.dart';
import 'package:flaq/screens/wallet/asset_container.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flaq/widgets/common.dart';
import 'package:flaq/widgets/flaq_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double totalAmount = 0;
  bool isLoading = false;
  List<Reward> rewards = [];

  load() async {
    EasyLoading.show();
    setState(() {
      isLoading = true;
    });

    List<Reward>? rewardsData = await Get.find<ApiService>().getRewards();
    for (final reward in rewardsData ?? []) {
      totalAmount += (reward.amount ?? 0) * (reward.conversion ?? 0);
    }

    if (mounted) {
      setState(() {
        isLoading = false;
        rewards = rewardsData ?? [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    load();
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(customHeight * 0.05),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(
                                'flaq portfolio',
                                FontWeight.w600,
                                18,
                                Colors.white,
                              ),
                              verticalSpace(customHeight * 0.015),
                              text(
                                '\u{20B9}$totalAmount',
                                FontWeight.w600,
                                24,
                                Colors.white,
                              ),
                            ],
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              showAssetImage(
                                'assets/images/bitcoin.png',
                                height: customHeight * 0.2,
                                width: customWidth * 0.2,
                              ),
                              Positioned(
                                top: 20,
                                right: 40,
                                child: showAssetImage(
                                  'assets/images/Polygon.png',
                                  height: customHeight * 0.2,
                                  width: customWidth * 0.2,
                                ),
                              ),
                              Positioned(
                                top: 40,
                                child: showAssetImage(
                                  'assets/images/Tether.png',
                                  height: customHeight * 0.2,
                                  width: customWidth * 0.2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(customHeight * 0.02),
                    Container(
                      width: customWidth,
                      height: customHeight,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Empty.V(32),
                            text(
                              'my assets',
                              FontWeight.w700,
                              18,
                              Colors.black,
                            ),
                            verticalSpace(customHeight * 0.02),
                            for (final reward in rewards)
                              AssetContainer(
                                randInt: rewards.indexOf(reward),
                                reward: reward,
                              ),
                            Empty.V(24),
                            FlaqButton(
                              maxWidth: true,
                              type: FlaqButtonType.thick,
                              isDark: true,
                              onTap: () {},
                              title: "withdraw coming soon",
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
