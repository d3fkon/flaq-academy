import 'package:flaq/screens/home/inviteAndEarn.dart';
import 'package:flaq/screens/home/transactionHistory.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlaqBankScreen extends StatefulWidget {
  const FlaqBankScreen({Key? key}) : super(key: key);

  @override
  State<FlaqBankScreen> createState() => _FlaqBankScreenState();
}

class _FlaqBankScreenState extends State<FlaqBankScreen> {
  Widget divider(Color color) {
    return Divider(
      color: color,
    );
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
                    )),
                verticalSpace(customHeight * 0.02),
                Row(
                  children: [
                    text(
                      'flaq-a-bank',
                      FontWeight.w400,
                      18,
                      Colors.white,
                    ),
                    horizontalSpace(customWidth * 0.01),
                    showAssetImage('assets/images/bank.png'),
                  ],
                ),
                verticalSpace(customHeight * 0.02),
                Text.rich(
                  TextSpan(
                    children: [
                      textSpan(
                        'we reward you flaq points for every upi payment you make, see ',
                        FontWeight.w500,
                        12,
                        Colors.white,
                      ),
                      textSpanWithUnderline(
                        'terms and conditions',
                        FontWeight.bold,
                        12,
                        Colors.white,
                      ),
                    ],
                  ),
                ),
                verticalSpace(customHeight * 0.025),
                customButton(
                  customHeight * 0.06,
                  customWidth * 0.9,
                  text(
                    'transaction history',
                    FontWeight.w700,
                    14,
                    Colors.black,
                  ),
                  () {
                    Get.to(() => const TransactionHistoryScreen());
                  },
                  Colors.white,
                  4,
                ),
                verticalSpace(customHeight * 0.02),
                divider(const Color(0xFF1F1F1F)),
                verticalSpace(customHeight * 0.02),
                text(
                  'refer & earn flaq',
                  FontWeight.w400,
                  18,
                  Colors.white,
                ),
                verticalSpace(customHeight * 0.015),
                text(
                  'flaq is an invite only app',
                  FontWeight.w400,
                  14,
                  Colors.white,
                ),
                verticalSpace(customHeight * 0.02),
                text(
                  'invite a friend and earn upto 500 flaq',
                  FontWeight.w500,
                  12,
                  Colors.white,
                ),
                verticalSpace(customHeight * 0.025),
                customButton(
                  customHeight * 0.06,
                  customWidth * 0.9,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customIcon(
                        Icons.share,
                        Colors.black,
                        size: 15,
                      ),
                      horizontalSpace(customWidth * 0.02),
                      text(
                        'invite and earn',
                        FontWeight.w700,
                        14,
                        Colors.black,
                      ),
                    ],
                  ),
                  () {
                    Get.to(() => const InviteAndEarnScreen());
                  },
                  Colors.white,
                  4,
                ),
                verticalSpace(customHeight * 0.02),
                divider(const Color(0xFF1F1F1F)),
                verticalSpace(customHeight * 0.02),
                text(
                  'complete a campaign',
                  FontWeight.w400,
                  18,
                  Colors.white,
                ),
                verticalSpace(customHeight * 0.02),
                text(
                  'successfully complete a quiz and share the results with your friends to earn 1000 flaq',
                  FontWeight.w500,
                  12,
                  Colors.white,
                ),
                verticalSpace(customHeight * 0.025),
                customButton(
                  customHeight * 0.06,
                  customWidth * 0.9,
                  text(
                    'see active campaigns',
                    FontWeight.w700,
                    14,
                    Colors.black,
                  ),
                  () {},
                  Colors.white,
                  4,
                ),
                verticalSpace(customHeight * 0.04),
                divider(const Color(0xFF1F1F1F)),
                verticalSpace(customHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
