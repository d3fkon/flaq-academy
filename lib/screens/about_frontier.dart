import 'package:flaq/models/article_model.dart';
import 'package:flaq/models/campaignModel.dart';
import 'package:flaq/screens/article.dart';
import 'package:flaq/screens/quiz.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WhatIsFrontier extends StatefulWidget {
  final Campaign? campaign;
  final participationId;
  const WhatIsFrontier(
      {Key? key, required this.campaign, required this.participationId})
      : super(key: key);

  @override
  State<WhatIsFrontier> createState() => _WhatIsFrontierState();
}

class _WhatIsFrontierState extends State<WhatIsFrontier> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: Helper.ytId ?? '',
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
                        '${widget.campaign!.title}',
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
                          'learn how ${widget.campaign!.title} works',
                          FontWeight.w400,
                          18,
                          Colors.white,
                        ),
                      ),
                      verticalSpace(customHeight * 0.01),
                      Align(
                        alignment: Alignment.topLeft,
                        child: text(
                          '${widget.campaign!.description}',
                          FontWeight.w500,
                          12,
                          Colors.white,
                        ),
                      ),
                      verticalSpace(customHeight * 0.01),
                      widget.campaign!.ytVideoUrl == ''
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: text('video coming soon', FontWeight.w500,
                                  18, Colors.white),
                            )
                          : ytWidget(),
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
              widget.campaign!.articleUrls == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Center(
                        child: text(
                          'articles coming soon',
                          FontWeight.w500,
                          18,
                          Colors.white,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: customHeight * 0.2,
                      child: ListView.builder(
                          itemCount: widget.campaign!.articleUrls!.length,
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
                                        link: widget
                                            .campaign!.articleUrls![index],
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  width: customWidth * 0.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF272727),
                                        width: 2),
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
                                          'article ${index + 1}',
                                          FontWeight.w400,
                                          16,
                                          Colors.white,
                                          1,
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                      verticalSpace(customHeight * 0.01),
                                      // textWithOverflow(
                                      //   article[index].content,
                                      //   FontWeight.w400,
                                      //   14,
                                      //   Colors.white,
                                      //   3,
                                      //   TextOverflow.ellipsis,
                                      // ),
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
                  'take the ${widget.campaign!.title} quiz',
                  FontWeight.w700,
                  14,
                  Colors.black,
                ),
                () {
                  Get.to(() => QuizScreen(
                        participationId: widget.participationId,
                        campaignId: widget.campaign!.id ?? '',
                        title: widget.campaign!.title ?? '',
                      ));
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
