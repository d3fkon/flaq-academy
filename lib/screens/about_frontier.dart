import 'package:flaq/models/article_model.dart';
import 'package:flaq/screens/article.dart';
import 'package:flaq/screens/quiz.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WhatIsFrontier extends StatefulWidget {
  const WhatIsFrontier({Key? key}) : super(key: key);

  @override
  State<WhatIsFrontier> createState() => _WhatIsFrontierState();
}

class _WhatIsFrontierState extends State<WhatIsFrontier> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'eZI95CU3iSE',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
  );
  Widget ytWidget() {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return player;
      },
    );
  }

  Widget textWithOverflow(
    String content,
    FontWeight fontweight,
    double fontsize,
    Color textcolor,
    int maxlines,
    TextOverflow overflow,
  ) {
    return Text(
      content,
      maxLines: maxlines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: fontweight,
        fontSize: fontsize,
        color: textcolor,
      ),
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
              Align(
                alignment: Alignment.topLeft,
                child: Text.rich(
                  TextSpan(
                    children: [
                      textSpan(
                        'what is ',
                        FontWeight.w400,
                        24,
                        Colors.white,
                      ),
                      textSpan(
                        'frontier',
                        FontWeight.w400,
                        24,
                        const Color(0xFFa76237),
                      ),
                      textSpan(
                        '?',
                        FontWeight.w400,
                        24,
                        Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(customHeight * 0.02),
              SizedBox(
                height: customHeight * 0.38,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: customWidth * 0.88,
                  decoration: BoxDecoration(
                    color: const Color(0xFF131212),
                    border:
                        Border.all(color: const Color(0xFF272727), width: 2),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: text(
                          'learn how frontier works',
                          FontWeight.w400,
                          18,
                          Colors.white,
                        ),
                      ),
                      verticalSpace(customHeight * 0.01),
                      text(
                        'here’s a short video on explaining how the wallet works and about the frontier team',
                        FontWeight.w500,
                        12,
                        Colors.white,
                      ),
                      verticalSpace(customHeight * 0.01),
                      ytWidget(),
                    ],
                  ),
                ),
              ),
              verticalSpace(customHeight * 0.05),
              Align(
                alignment: Alignment.topLeft,
                child: text(
                  'feed your mind',
                  FontWeight.w400,
                  18,
                  Colors.white,
                ),
              ),
              verticalSpace(customHeight * 0.01),
              SizedBox(
                width: customWidth * 0.8,
                child: text(
                  'here are some articles for you to read and learn about how the frontier works in depth',
                  FontWeight.w500,
                  12,
                  Colors.white,
                ),
              ),
              verticalSpace(customHeight * 0.01),
              SizedBox(
                height: customHeight * 0.26,
                child: ListView.builder(
                    itemCount: article.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(
                                left: 0, top: 5, bottom: 5, right: 5)
                            : const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ArticleScreen(
                                  title: article[index].title,
                                  content: article[index].content,
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            width: customWidth * 0.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF272727), width: 2),
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: showAssetImage(
                                    'assets/images/book.PNG',
                                  ),
                                ),
                                verticalSpace(customHeight * 0.01),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: textWithOverflow(
                                    article[index].title,
                                    FontWeight.w400,
                                    16,
                                    Colors.white,
                                    1,
                                    TextOverflow.ellipsis,
                                  ),
                                ),
                                verticalSpace(customHeight * 0.01),
                                textWithOverflow(
                                  article[index].content,
                                  FontWeight.w400,
                                  14,
                                  Colors.white,
                                  3,
                                  TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              verticalSpace(customHeight * 0.02),
              customButton(
                customHeight * 0.06,
                customWidth * 0.9,
                text(
                  'take the frontier quiz',
                  FontWeight.w700,
                  14,
                  Colors.black,
                ),
                () {
                  Get.to(() => const QuizScreen());
                },
                Colors.white,
                4,
              ),
              verticalSpace(customHeight * 0.07),
            ],
          ),
        ),
      )),
    );
  }
}
