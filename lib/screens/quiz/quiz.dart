import 'package:flaq/models/quizModel.dart';
import 'package:flaq/screens/quiz/quizResult.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flaq/utils/radioListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class QuizScreen extends StatefulWidget {
  final String participationId;
  final String campaignId;
  final String title;
  const QuizScreen(
      {Key? key,
      required this.participationId,
      required this.campaignId,
      required this.title})
      : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  late PageController _controller;
  final ItemScrollController _scrollController = ItemScrollController();
  int count = 0;
  List<String?> _value = [];
  int score = 0;
  bool isLoading = true;
  QuizResponse? quiz;
  List ans = [];
  bool isPassing = false;
  int totalQuestions = 0;
  int correctAns = 0;

  Widget smallDash(
    double customWidth,
    double customHeight,
  ) {
    return Container(
      color: Colors.black,
      width: customWidth * 0.12,
      height: customHeight * 0.007,
    );
  }

  Widget textUbuntu(
      String content, FontWeight fontweight, double fontsize, Color textcolor) {
    return Text(
      content,
      style: TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: fontweight,
        fontSize: fontsize,
        color: textcolor,
      ),
    );
  }

  Widget circleAvatar(Color color, Widget child, {double? radius}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: child,
    );
  }

  load() async {
    setState(() {
      isLoading = true;
    });
    EasyLoading.show();
    quiz = await Get.find<ApiService>().getQuiz(widget.campaignId);
    if (quiz != null) {
      if (mounted) {
        setState(() {
          for (int i = 0; i < quiz!.data.questions.length; i++) {
            _value.add('');
            ans.add('');
          }
          isLoading = false;
        });
        EasyLoading.dismiss();
      }
    }
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);

    score = 0;
    load();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      verticalSpace(customHeight * 0.07),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                horizontalSpace(customWidth * 0.025),
                                SizedBox(
                                  width: customWidth * 0.8,
                                  child: Text.rich(
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
                                ),
                              ],
                            ),
                            verticalSpace(customHeight * 0.015),
                            SizedBox(
                              width: customWidth * 0.7,
                              child: text(
                                'score more than 90% in order to claim your frontier reward tokens',
                                FontWeight.w500,
                                12,
                                const Color(0xFFB9B9B9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(customHeight * 0.02),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        width: customWidth,
                        height: customHeight,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            )),
                        child: Column(
                          children: [
                            verticalSpace(customHeight * 0.025),
                            smallDash(customWidth, customHeight),
                            SizedBox(
                              width: customWidth,
                              height: customHeight * 0.1,
                              child: ScrollablePositionedList.builder(
                                itemScrollController: _scrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return buildDot(index, context);
                                },
                                itemCount: quiz!.data.questions.length,
                              ),
                            ),
                            Expanded(
                              child: PageView.builder(
                                controller: _controller,
                                itemCount: quiz!.data.questions.length,
                                onPageChanged: (int index) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                itemBuilder: (_, i) {
                                  return Column(children: [
                                    verticalSpace(customHeight * 0.03),
                                    textUbuntu(
                                      quiz!.data.questions[i].question,
                                      FontWeight.w500,
                                      17,
                                      Colors.black,
                                    ),
                                    verticalSpace(customHeight * 0.02),
                                    SizedBox(
                                      width: customWidth,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: quiz!
                                              .data.questions[i].options.length,
                                          itemBuilder: (context, index) {
                                            return MyRadioListTile<String?>(
                                                value: quiz!.data.questions[i]
                                                    .options[index],
                                                groupValue: _value[i],
                                                leading: (index + 1).toString(),
                                                title: SizedBox(
                                                  width: customWidth * 0.6,
                                                  child: textUbuntu(
                                                    quiz!.data.questions[i]
                                                        .options[index],
                                                    FontWeight.w400,
                                                    14,
                                                    _value[i] ==
                                                            quiz!
                                                                .data
                                                                .questions[i]
                                                                .options[index]
                                                        ? Colors.black
                                                        : const Color(
                                                            0xFF9999A5),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value[i] = value!;
                                                    ans[i] = index;
                                                  });
                                                });
                                          }),
                                    ),
                                  ]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
      bottomNavigationBar: isLoading
          ? const SizedBox(
              height: 0,
              width: 0,
            )
          : BottomAppBar(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                height: customHeight * 0.125,
                child: currentIndex == 0 && quiz!.data.questions.length != 1
                    ? Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (ans[currentIndex] != '') {
                                currentIndex++;
                                if (currentIndex >
                                    quiz!.data.questions.length) {
                                  currentIndex =
                                      quiz!.data.questions.length - 1;
                                }
                                _controller.jumpToPage(currentIndex);
                              } else {
                                Helper.toast(
                                    'please select an option to proceed');
                              }
                            });
                          },
                          child: circleAvatar(
                            Colors.black,
                            customIcon(
                              Icons.arrow_forward_ios,
                              Colors.white,
                            ),
                            radius: 30,
                          ),
                        ),
                      )
                    : currentIndex == quiz!.data.questions.length - 1 ||
                            quiz!.data.questions.length == 1
                        ? Row(
                            children: [
                              quiz!.data.questions.length == 1
                                  ? const SizedBox(
                                      height: 0,
                                      width: 0,
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentIndex--;
                                          if (currentIndex < 0) {
                                            currentIndex = 0;
                                          }
                                          _controller.jumpToPage(currentIndex);
                                          _scrollController.scrollTo(
                                              index: currentIndex,
                                              duration:
                                                  const Duration(seconds: 1));
                                        });
                                      },
                                      child: circleAvatar(
                                        Colors.black,
                                        customIcon(
                                          Icons.arrow_back_ios,
                                          Colors.white,
                                        ),
                                        radius: 30,
                                      ),
                                    ),
                              horizontalSpace(customWidth * 0.05),
                              customButton(
                                customHeight * 0.07,
                                quiz!.data.questions.length == 1
                                    ? customWidth * 0.8
                                    : customWidth * 0.68,
                                text(
                                  'submit',
                                  FontWeight.w700,
                                  16,
                                  Colors.white,
                                ),
                                () async {
                                  if (ans[currentIndex] != '') {
                                    EasyLoading.show();
                                    var quizResult =
                                        await Get.find<ApiService>()
                                            .evaluateQuiz(ans, quiz!.data.id,
                                                widget.participationId);
                                    if (quizResult != null) {
                                      if (mounted) {
                                        setState(() {
                                          isPassing =
                                              quizResult['Data']['IsPassing'];
                                          totalQuestions = quizResult['Data']
                                              ['QuestionCount'];
                                          correctAns = quizResult['Data']
                                              ['CorrectCount'];
                                        });
                                        EasyLoading.dismiss();
                                        Navigator.pop(context);

                                        Get.to(() => QuizResultScreen(
                                              isPassing: isPassing,
                                              totalQuestion: totalQuestions,
                                              correctAns: correctAns,
                                              title: widget.title,
                                            ));
                                      }
                                    }
                                  } else {
                                    Helper.toast(
                                        'please select an option to proceed');
                                  }
                                },
                                Colors.black,
                                4,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    currentIndex--;
                                    if (currentIndex < 0) {
                                      currentIndex = 0;
                                    }
                                    _controller.jumpToPage(currentIndex);
                                    _scrollController.scrollTo(
                                        index: currentIndex,
                                        duration: const Duration(seconds: 1));
                                  });
                                },
                                child: circleAvatar(
                                  Colors.black,
                                  customIcon(
                                    Icons.arrow_back_ios,
                                    Colors.white,
                                  ),
                                  radius: 30,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (ans[currentIndex] != '') {
                                      currentIndex++;
                                      if (currentIndex >
                                          quiz!.data.questions.length) {
                                        currentIndex =
                                            quiz!.data.questions.length - 1;
                                      }
                                      _controller.jumpToPage(currentIndex);
                                      _scrollController.scrollTo(
                                          index: currentIndex,
                                          duration: const Duration(seconds: 1));
                                    } else {
                                      Helper.toast(
                                          'please select an option to proceed');
                                    }
                                  });
                                },
                                child: circleAvatar(
                                  Colors.black,
                                  customIcon(
                                    Icons.arrow_forward_ios,
                                    Colors.white,
                                  ),
                                  radius: 30,
                                ),
                              ),
                            ],
                          ),
              ),
              elevation: 0,
            ),
    );
  }

  buildDot(int index, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.13,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: index == currentIndex
                  ? Colors.black
                  : const Color(0xFFD4D4D4),
            ),
          ),
        ),
        child: circleAvatar(
          index == currentIndex ? Colors.black : const Color(0xFFD4D4D4),
          text(
            (index + 1).toString(),
            FontWeight.w500,
            16,
            Colors.white,
          ),
        ),
      ),
    );
  }
}
