import 'package:flaq/services/api.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  var rewardsData;
  List amount = [];
  List tickerName = [];
  List tickerImage = [];
  List<Color> listColors = [];
  bool isLoading = true;
  double totalAmount = 0;
  var conversions;
  List coinAmount = [];
  List coinName = [];

  load() async {
    EasyLoading.show();
    setState(() {
      isLoading = true;
    });
    rewardsData = await Get.find<ApiService>().getRewards();
    conversions = await Get.find<ApiService>().getConversions();
    if (mounted) {
      if (rewardsData != null) {
        setState(() {
          for (int i = 0; i < rewardsData.length; i++) {
            amount.add(rewardsData[i]['Amount']);
            totalAmount = totalAmount + rewardsData[i]['Amount'];
            tickerName.add(rewardsData[i]['TickerName']);
            tickerImage.add(rewardsData[i]['TickerImageUrl']);
            listColors.add(const Color(0xFFF7CD76));
            listColors.add(const Color(0xFFE9F5FA));
            listColors.add(const Color(0xFFB5FFC1));
          }
          for (int j = 0; j < rewardsData.length; j++) {
            for (int k = 0; k < conversions.length; k++) {
              if (conversions[k]['TickerName'] ==
                  rewardsData[j]['TickerName']) {
                coinAmount.add(amount[j] * conversions[k]['Conversion']);
                coinName.add(conversions[k]['Name']);
              }
            }
          }
          isLoading = false;
        });

        EasyLoading.dismiss();
      }
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
                                topRight: Radius.circular(24))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(customHeight * 0.02),
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
                                    itemCount: rewardsData.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: listColors[index],
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: showNetworkImage(
                                                        tickerImage[index],
                                                        height:
                                                            customHeight * 0.05,
                                                        width:
                                                            customWidth * 0.09),
                                                  ),
                                                  horizontalSpace(
                                                      customWidth * 0.02),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      text(
                                                        tickerName[index],
                                                        FontWeight.w400,
                                                        16,
                                                        Colors.black,
                                                      ),
                                                      verticalSpace(
                                                          customHeight * 0.01),
                                                      text(
                                                        coinName[index],
                                                        FontWeight.w700,
                                                        12,
                                                        Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  text(
                                                    coinAmount[index]
                                                        .toString(),
                                                    FontWeight.w500,
                                                    16,
                                                    Colors.black,
                                                  ),
                                                  verticalSpace(
                                                      customHeight * 0.01),
                                                  text(
                                                    '\u{20B9}${amount[index].toString()}',
                                                    FontWeight.w500,
                                                    14,
                                                    Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              verticalSpace(customHeight * 0.02),
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
