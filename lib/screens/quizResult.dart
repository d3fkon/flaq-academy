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
              SizedBox(
                height: customHeight * 0.07,
              ),
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
                          child: const Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: customWidth * 0.025,
                        ),
                        const Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'frontier ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFFa76237),
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                            TextSpan(
                              text: 'quiz?',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: customHeight * 0.12,
                    ),
                    widget.score < 9
                        ? CircularPercentIndicator(
                            radius: 130.0,
                            animation: true,
                            animationDuration: 800,
                            lineWidth: 5.0,
                            percent: (widget.score / 10),
                            center: CircleAvatar(
                              radius: 110,
                              backgroundColor: const Color(0xFFECF0F3),
                              child: Text(
                                '${widget.score}/10',
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFFDB4437),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            circularStrokeCap: CircularStrokeCap.butt,
                            backgroundColor: Colors.black,
                            progressColor: const Color(0xFFDB4437),
                          )
                        : CircularPercentIndicator(
                            radius: 130.0,
                            animation: true,
                            animationDuration: 800,
                            lineWidth: 5.0,
                            percent: (widget.score / 10),
                            center: CircleAvatar(
                              radius: 110,
                              backgroundColor: const Color(0xFFECF0F3),
                              child: Text(
                                '${widget.score}/10',
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF0F9D58),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            circularStrokeCap: CircularStrokeCap.butt,
                            backgroundColor: Colors.black,
                            progressColor: const Color(0xFF0F9D58),
                          ),
                    SizedBox(
                      height: customHeight * 0.04,
                    ),
                    widget.score < 9
                        ? Image.asset('assets/images/retake-quiz.png')
                        : Image.asset('assets/images/quiz-complete.png'),
                    SizedBox(
                      height: customHeight * 0.01,
                    ),
                    const Text(
                      'quiz completed',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: customHeight * 0.01,
                    ),
                    widget.score < 9
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                            ),
                            child: Text(
                              'in order to claim your rewards you have to pass the quiz with a score of 90% or above! keep on learning',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                            ),
                            child: Text(
                              'congratulations you have scored more than 90% and are now eligible to claim rewards',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    SizedBox(
                      height: customHeight * 0.1,
                    ),
                    widget.score < 9
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 0,
                                fixedSize: Size(
                                    customWidth * 0.9, customHeight * 0.06),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )),
                            onPressed: () {},
                            child: const Text(
                              'retake quiz',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 0,
                                fixedSize: Size(
                                    customWidth * 0.9, customHeight * 0.06),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )),
                            onPressed: () {},
                            child: const Text(
                              'claim rewards',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            )),
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
