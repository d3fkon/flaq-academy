import 'package:dotted_border/dotted_border.dart';
import 'package:flaq/utils/customWidgets.dart';
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
  Widget circularDottedWidget(String number) {
    return DottedBorder(
      color: Colors.white,
      strokeWidth: 1,
      borderType: BorderType.Circle,
      dashPattern: const [5, 5],
      child: CircleAvatar(
        radius: 17,
        backgroundColor: Colors.black,
        child: text(
          number,
          FontWeight.w500,
          14,
          Colors.white,
        ),
      ),
    );
  }

  Widget dottedLine(double customWidth, double customHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 19,
        vertical: 5,
      ),
      child: CustomPaint(
          size: Size(customWidth * 0.01, customHeight * 0.05),
          painter: DashedLineVerticalPainter()),
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
                  ),
                ),
                verticalSpace(customHeight * 0.02),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  width: customWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xFF171717),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      showAssetImage(
                        'assets/images/icon-1-white.png',
                        width: customWidth * 0.09,
                        height: customHeight * 0.09,
                      ),
                      verticalSpace(customHeight * 0.005),
                      text(
                        'your unique referral code',
                        FontWeight.w600,
                        16,
                        Colors.white,
                      ),
                      verticalSpace(customHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          text(
                            '7bxu71ii',
                            FontWeight.w600,
                            14,
                            Colors.white,
                          ),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                      const ClipboardData(text: '7bxu71ii'))
                                  .then((value) {
                                Helper.toast('copied');
                              });
                            },
                            child: customIcon(
                              Icons.copy,
                              Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(customHeight * 0.04),
                    ],
                  ),
                ),
                verticalSpace(customHeight * 0.06),
                text(
                  'how flaq’s invitation system works',
                  FontWeight.w600,
                  16,
                  Colors.white,
                ),
                verticalSpace(customHeight * 0.02),
                Row(
                  children: [
                    circularDottedWidget('1'),
                    horizontalSpace(customWidth * 0.04),
                    SizedBox(
                      width: customWidth * 0.65,
                      child: text(
                        'your friend installs and signs up with flaq using your invitation code',
                        FontWeight.w500,
                        14,
                        Colors.white,
                      ),
                    ),
                  ],
                ),
                dottedLine(customWidth, customHeight),
                Row(
                  children: [
                    circularDottedWidget('2'),
                    horizontalSpace(customWidth * 0.04),
                    SizedBox(
                      width: customWidth * 0.65,
                      child: text(
                        'your friend completes their first transaction using flaq',
                        FontWeight.w500,
                        14,
                        Colors.white,
                      ),
                    ),
                  ],
                ),
                dottedLine(customWidth, customHeight),
                Row(
                  children: [
                    circularDottedWidget('3'),
                    horizontalSpace(customWidth * 0.04),
                    SizedBox(
                      width: customWidth * 0.65,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            textSpan(
                              'you receive ',
                              FontWeight.w500,
                              14,
                              Colors.white,
                            ),
                            textSpan(
                              '500 flaq tokens',
                              FontWeight.bold,
                              14,
                              Colors.white,
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
