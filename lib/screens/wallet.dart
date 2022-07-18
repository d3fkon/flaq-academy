import 'package:flaq/models/rewards.model.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

List<Color> assetListColors = [
  (const Color(0xFFF7CD76)),
  (const Color(0xFFE9F5FA)),
  (const Color(0xFFB5FFC1)),
];

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class AssetContainer extends StatelessWidget {
  final RewardDatum reward;
  final int randInt;
  const AssetContainer({Key? key, required this.reward, required this.randInt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: assetListColors[randInt % assetListColors.length],
          borderRadius: BorderRadius.circular(6),
        ),
        height: 84,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Image.network(
              reward.tickerImageUrl ?? '',
              height: 42,
              width: 42,
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.tickerName ?? "",
                  style: const TextStyle(
                    color: Color(0xff1A1A1A),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  reward.name ?? "",
                  style: const TextStyle(
                    color: Color(0xff1A1A1A),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  reward.amount.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  (((reward.amount ?? 0) * (reward.conversion ?? 0))
                          .toPrecision(3))
                      .toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class _WalletScreenState extends State<WalletScreen> {
  double totalAmount = 0;
  bool isLoading = false;
  List<RewardDatum> rewards = [];

  load() async {
    EasyLoading.show();
    setState(() {
      isLoading = true;
    });

    List<RewardDatum>? rewardsData = await Get.find<ApiService>().getRewards();
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
                                // text(
                                //   'hello, ankit sethi',
                                //   FontWeight.w400,
                                //   12,
                                //   Colors.white,
                                // ),
                                verticalSpace(customHeight * 0.02),
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
                              verticalSpace(32),
                              text(
                                'my assets',
                                FontWeight.w700,
                                18,
                                Colors.black,
                              ),
                              verticalSpace(customHeight * 0.02),
                              SizedBox(
                                width: customWidth,
                                height: customHeight * 0.43,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: rewards.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return AssetContainer(
                                        randInt: index,
                                        reward: rewards[index],
                                      );
                                    }),
                              ),
                              customButton(
                                customHeight * 0.07,
                                customWidth,
                                text(
                                  'withdraw coming soon',
                                  FontWeight.w700,
                                  14,
                                  Colors.white,
                                ),
                                () {},
                                Colors.black,
                                4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
    );
  }
}
