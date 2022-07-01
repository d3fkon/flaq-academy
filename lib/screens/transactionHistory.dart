import 'package:flaq/screens/home.screen.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/services/messaging.service.dart';
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
                SizedBox(
                  height: customHeight * 0.05,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        const Text(
                          'transactions',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        IconButton(
                          onPressed: dataService.fetchTransactions,
                          icon: const Icon(Icons.refresh, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.015,
                ),
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
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: customHeight * 0.075,
                                        width: customWidth * 0.15,
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF1A1A1A),
                                            border: Border.all(
                                                color: const Color(0xFF000000),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Image.asset(
                                            'assets/images/transactions.png'),
                                      ),
                                      SizedBox(
                                        width: customWidth * 0.02,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Flaq earned',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF9999A5),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: customHeight * 0.01,
                                          ),
                                          Text(
                                            '${dataService.txnList[index].rewardFlaq} Flaq',
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '- \u{20B9}${dataService.txnList[index].amount}',
                                        style: const TextStyle(
                                          fontFamily: 'WorkSans',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      Text(
                                        formatDate(DateTime.parse(dataService
                                            .txnList[index].createdAt)),
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF9999A5),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                InkWell(
                  onTap: () {},
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'see more',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
