import 'package:flaq/screens/dashboard.dart';
import 'package:flaq/screens/wallet.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuizResultScreen extends StatefulWidget {
  final isPassing, totalQuestion, correctAns, title;
  const QuizResultScreen(
      {Key? key,
      required this.isPassing,
      required this.totalQuestion,
      required this.correctAns,
      required this.title})
      : super(key: key);

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  Widget circleAvatar(
    double radius,
    Color color,
    Widget child,
  ) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: child,
    );
  }

  Widget textCenter(
      String content, FontWeight fontweight, double fontsize, Color textcolor) {
    return Text(
      content,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: fontweight,
        fontSize: fontsize,
        color: textcolor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget scoreDisplay(
    Color progressColor,
  ) {
    return CircularPercentIndicator(
      radius: 130.0,
      animation: true,
      animationDuration: 800,
      lineWidth: 5.0,
      percent: (widget.correctAns / widget.totalQuestion),
      center: circleAvatar(
        110,
        const Color(0xFFECF0F3),
        text(
          '${widget.correctAns} / ${widget.totalQuestion}',
          FontWeight.w700,
          40,
          progressColor,
        ),
      ),
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: Colors.black,
      progressColor: progressColor,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(customHeight * 0.07),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        horizontalSpace(customWidth * 0.025),
                        Text.rich(
                          TextSpan(children: [
                            textSpan(
                              '${widget.title} ',
                              FontWeight.w400,
                              24,
                              const Color(0xFFa76237),
                            ),
                            textSpan(
                              'quiz?',
                              FontWeight.w400,
                              24,
                              Colors.white,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    verticalSpace(customHeight * 0.12),
                    !widget.isPassing
                        ? scoreDisplay(
                            const Color(0xFFDB4437),
                          )
                        : scoreDisplay(
                            const Color(0xFF0F9D58),
                          ),
                    verticalSpace(customHeight * 0.04),
                    !widget.isPassing
                        ? showAssetImage('assets/images/retake-quiz.png')
                        : showAssetImage('assets/images/quiz-complete.png'),
                    verticalSpace(customHeight * 0.01),
                    text(
                      'quiz completed',
                      FontWeight.w400,
                      24,
                      Colors.white,
                    ),
                    verticalSpace(customHeight * 0.01),
                    !widget.isPassing
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                            ),
                            child: textCenter(
                              'in order to claim your rewards you have to pass the quiz with a score of 90% or above! keep on learning',
                              FontWeight.w500,
                              12,
                              Colors.white,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                            ),
                            child: textCenter(
                              'congratulations you have scored more than 90% and are now eligible to claim rewards',
                              FontWeight.w500,
                              12,
                              Colors.white,
                            ),
                          ),
                    verticalSpace(customHeight * 0.1),
                    !widget.isPassing
                        ? customButton(
                            customHeight * 0.06,
                            customWidth * 0.9,
                            text(
                              'retake quiz',
                              FontWeight.w700,
                              14,
                              Colors.black,
                            ),
                            () {
                              Navigator.pop(context);
                            },
                            Colors.white,
                            4,
                          )
                        : customButton(
                            customHeight * 0.06,
                            customWidth * 0.9,
                            text(
                              'claim rewards',
                              FontWeight.w700,
                              14,
                              Colors.black,
                            ),
                            () async {
                              var rewardsData =
                                  await Get.find<ApiService>().getRewards();
                              if (rewardsData == null || rewardsData == []) {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  isDismissible: false,
                                  builder: (context) {
                                    return Container(
                                      width: customWidth,
                                      height: customHeight * 0.25,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 20,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          text(
                                            'failed to claim rewards',
                                            FontWeight.w600,
                                            18,
                                            Colors.black,
                                          ),
                                          verticalSpace(customHeight * 0.02),
                                          text(
                                            'sorry for the inconvenience',
                                            FontWeight.w500,
                                            14,
                                            Colors.grey,
                                          ),
                                          verticalSpace(customHeight * 0.04),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              children: [
                                                customIcon(
                                                  Icons.arrow_back_ios,
                                                  Colors.grey,
                                                  size: 18,
                                                ),
                                                text(
                                                  'Go Back',
                                                  FontWeight.w700,
                                                  14,
                                                  Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                Get.offAll(() {
                                  return const DashBoard(
                                    tab: 1,
                                  );
                                });
                              }
                            },
                            Colors.white,
                            4,
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
