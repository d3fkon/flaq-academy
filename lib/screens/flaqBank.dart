import 'package:flaq/screens/inviteAndEarn.dart';
import 'package:flaq/screens/transactionHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlaqBankScreen extends StatefulWidget {
  const FlaqBankScreen({Key? key}) : super(key: key);

  @override
  State<FlaqBankScreen> createState() => _FlaqBankScreenState();
}

class _FlaqBankScreenState extends State<FlaqBankScreen> {
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
                Row(
                  children: [
                    const Text(
                      'flaq-a-bank',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: customWidth * 0.01,
                    ),
                    Image.asset('assets/images/bank.png'),
                  ],
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'we reward you flaq points for every upi payment you make, see ',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: 'terms and conditions',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.025,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        fixedSize: Size(customWidth * 0.9, customHeight * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        )),
                    onPressed: () {
                      Get.to(() => const TransactionHistoryScreen());
                    },
                    child: const Text(
                      'transaction history',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    )),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                const Divider(
                  color: Color(0xFF1F1F1F),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                const Text(
                  'refer & earn flaq',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.015,
                ),
                const Text(
                  'flaq is an invite only app',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                const Text(
                  'invite a friend and earn upto 500 flaq',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.025,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        fixedSize: Size(customWidth * 0.9, customHeight * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        )),
                    onPressed: () {
                      Get.to(() => const InviteAndEarnScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.share,
                          color: Colors.black,
                          size: 15,
                        ),
                        SizedBox(
                          width: customWidth * 0.02,
                        ),
                        const Text(
                          'invite and earn',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                const Divider(
                  color: Color(0xFF1F1F1F),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                const Text(
                  'complete a campaign',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                const Text(
                  'successfully complete a quiz and share the results with your friends to earn 1000 flaq',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.025,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        fixedSize: Size(customWidth * 0.9, customHeight * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        )),
                    onPressed: () {
                      // Get.to(() => const FlaqBankScreen());
                    },
                    child: const Text(
                      'see active campaigns',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    )),
                SizedBox(
                  height: customHeight * 0.04,
                ),
                const Divider(
                  color: Color(0xFF1F1F1F),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
