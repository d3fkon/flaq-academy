import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuizResultScreen extends StatefulWidget {
  final score;
  const QuizResultScreen({
    Key? key,
    required this.score,
  }) : super(key: key);

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
      percent: (widget.score / 10),
      center: circleAvatar(
        110,
        const Color(0xFFECF0F3),
        text(
          '${widget.score}/10',
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
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: customIcon(
                            Icons.arrow_back_outlined,
                            Colors.white,
                          ),
                        ),
                        verticalSpace(customHeight * 0.035),
                        Text.rich(
                          TextSpan(children: [
                            textSpan(
                              'frontier',
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
                    widget.score < 9
                        ? scoreDisplay(
                            const Color(0xFFDB4437),
                          )
                        : scoreDisplay(
                            const Color(0xFF0F9D58),
                          ),
                    verticalSpace(customHeight * 0.04),
                    widget.score < 9
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
                    widget.score < 9
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
                    widget.score < 9
                        ? customButton(
                            customHeight * 0.06,
                            customWidth * 0.9,
                            text(
                              'retake quiz',
                              FontWeight.w700,
                              14,
                              Colors.black,
                            ),
                            () {},
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
                            () {},
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
