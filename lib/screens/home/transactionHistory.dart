import 'package:flaq/services/data.service.dart';
import 'package:flaq/services/messaging.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late final DataService dataService;
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(customHeight * 0.05),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: customIcon(
                    Icons.arrow_back_outlined,
                    Colors.white,
                  ),
                ),
                verticalSpace(customHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text(
                          'transactions',
                          FontWeight.w400,
                          18,
                          Colors.white,
                        ),
                        IconButton(
                          onPressed: dataService.fetchTransactions,
                          icon: customIcon(
                            Icons.refresh,
                            Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(customHeight * 0.015),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: customWidth,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataService.txnList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: customHeight * 0.075,
                                      width: customWidth * 0.15,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF1A1A1A),
                                          border: Border.all(
                                              color: const Color(0xFF000000),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: showAssetImage(
                                          'assets/images/transactions.png'),
                                    ),
                                    horizontalSpace(customWidth * 0.02),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        text(
                                          'Flaq earned',
                                          FontWeight.w400,
                                          14,
                                          const Color(0xFF9999A5),
                                        ),
                                        verticalSpace(customHeight * 0.01),
                                        text(
                                          '${dataService.txnList[index].flaqReward} Flaq',
                                          FontWeight.w400,
                                          14,
                                          Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    textWorkSans(
                                      '- \u{20B9}${dataService.txnList[index].amount}',
                                      FontWeight.w400,
                                      14,
                                      Colors.white,
                                    ),
                                    verticalSpace(customHeight * 0.01),
                                    text(
                                      (DateTime.parse(dataService
                                              .txnList[index].createdAt
                                              .toString()))
                                          .toString(),
                                      FontWeight.w400,
                                      12,
                                      const Color(0xFF9999A5),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                verticalSpace(customHeight * 0.02),
                InkWell(
                  onTap: () {},
                  child: Align(
                    alignment: Alignment.center,
                    child: text(
                      'see more',
                      FontWeight.w500,
                      14,
                      Colors.white,
                    ),
                  ),
                ),
                verticalSpace(customHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
