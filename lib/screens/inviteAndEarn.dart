import 'package:dotted_border/dotted_border.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InviteAndEarnScreen extends StatefulWidget {
  const InviteAndEarnScreen({Key? key}) : super(key: key);

  @override
  State<InviteAndEarnScreen> createState() => _InviteAndEarnScreenState();
}

class _InviteAndEarnScreenState extends State<InviteAndEarnScreen> {
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  width: customWidth,
                  decoration: BoxDecoration(
                    color: Color(0xFF171717),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/icon-1-white.png',
                        width: customWidth * 0.09,
                        height: customHeight * 0.09,
                      ),
                      SizedBox(
                        height: customHeight * 0.005,
                      ),
                      const Text(
                        'your unique referral code',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: customHeight * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '7bxu71ii',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                      const ClipboardData(text: '7bxu71ii'))
                                  .then((value) {
                                Helper.toast('copied');
                              });
                            },
                            child: const Icon(
                              Icons.copy,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: customHeight * 0.04,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.06,
                ),
                const Text(
                  'how flaq’s invitation system works',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                Row(
                  children: [
                    DottedBorder(
                      color: Colors.white,
                      strokeWidth: 1,
                      borderType: BorderType.Circle,
                      dashPattern: [5, 5],
                      child: const CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.black,
                        child: Text(
                          '1',
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
                      width: customWidth * 0.04,
                    ),
                    SizedBox(
                      width: customWidth * 0.65,
                      child: const Text(
                        'your friend installs and signs up with flaq using your invitation code',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 19,
                    vertical: 5,
                  ),
                  child: CustomPaint(
                      size: Size(customWidth * 0.01, customHeight * 0.05),
                      painter: DashedLineVerticalPainter()),
                ),
                Row(
                  children: [
                    DottedBorder(
                      color: Colors.white,
                      strokeWidth: 1,
                      borderType: BorderType.Circle,
                      dashPattern: [5, 5],
                      child: const CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.black,
                        child: Text(
                          '2',
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
                      width: customWidth * 0.04,
                    ),
                    SizedBox(
                      width: customWidth * 0.65,
                      child: const Text(
                        'your friend completes their first transaction using flaq',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 19,
                    vertical: 5,
                  ),
                  child: CustomPaint(
                      size: Size(customWidth * 0.01, customHeight * 0.05),
                      painter: DashedLineVerticalPainter()),
                ),
                Row(
                  children: [
                    DottedBorder(
                      color: Colors.white,
                      strokeWidth: 1,
                      borderType: BorderType.Circle,
                      dashPattern: [5, 5],
                      child: const CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.black,
                        child: Text(
                          '3',
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
                      width: customWidth * 0.04,
                    ),
                    SizedBox(
                      width: customWidth * 0.65,
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'you receive ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: '500 flaq tokens',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
