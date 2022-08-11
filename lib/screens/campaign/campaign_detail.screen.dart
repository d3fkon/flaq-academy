import 'dart:ui';

import 'package:flaq/models/campaignModel.dart';
import 'package:flaq/screens/quiz/quiz.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flaq/widgets/common.dart';
import 'package:flaq/widgets/flaq_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CampaignDetailScreen extends StatefulWidget {
  final Campaign campaign;
  const CampaignDetailScreen({
    Key? key,
    required this.campaign,
  }) : super(key: key);

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  bool isFullScreen = false;
  late final YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.campaign.yTVideoUrl!)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    super.initState();
  }

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

  handleQuizButton() {
    var dataService = Get.find<DataService>();
    // Check for campaign participation
    var res = Get.find<DataService>().getParticipationId(widget.campaign.id);
    // This means that the user is already participating in the campaign
    if (res != null) {
      Get.to(
        () => QuizScreen(
          title: "wtf",
          participationId: res,
          campaignId: widget.campaign.id,
        ),
      );
      return;
    }
    Helper.dialog(
      title: 'Unlock ${widget.campaign.title}',
      description:
          "Spend ${widget.campaign.requiredFlaq} Flaq Points to a unlock ${widget.campaign.title}",
      onYes: () async {
        // Close the modal
        Get.back();
        // Register to campaign
        var campaignReg =
            await dataService.enrollForCampaign(widget.campaign.id);
        // Get the participation ID
        if (!campaignReg) {
          return;
        }
        var participationId =
            dataService.getParticipationId(widget.campaign.id);
        // Navigate
        if (participationId == null) {
          return;
        }
        Get.to(
          () => QuizScreen(
            title: "wtf",
            participationId: participationId,
            campaignId: widget.campaign.id,
          ),
        );
      },
    );
  }

  final descriptionTextStyle = const TextStyle(
    color: Color(0xffB9B9B9),
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  final titleTextStyle = const TextStyle(
    color: Color(0xffF7F7F7),
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );

  Widget buildArticles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "feed your mind",
          style: titleTextStyle,
        ),
        Empty.V(12),
        Text(
          "here are some not so boring articles and threads for you to become better",
          style: descriptionTextStyle,
        ),
        Empty.V(12),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.campaign.articles?.length,
            itemBuilder: (context, i) {
              final article = widget.campaign.articles![i];
              return GestureDetector(
                onTap: () {
                  launchUrlString(article.url!);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 17.0),
                  child: Container(
                    width: 170,
                    decoration: BoxDecoration(
                      gradient: flaqGradients[i % flaqGradients.length],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            article.iconUrl!,
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                          const Expand(),
                          Text(
                            article.title!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          const Expand(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var campaign = widget.campaign;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: YoutubePlayerBuilder(
          onEnterFullScreen: () {
            setState(() {
              isFullScreen = true;
            });
          },
          onExitFullScreen: () {
            SystemChrome.restoreSystemUIOverlays();
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual,
              overlays: SystemUiOverlay.values,
            );
            setState(() {
              isFullScreen = false;
            });
          },
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            if (isFullScreen) {
              return player;
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Empty.V(24),
                    GestureDetector(
                      onTap: Get.back,
                      child: const Icon(Icons.arrow_back),
                    ),
                    Empty.V(24),
                    Text(
                      campaign.title,
                      style: titleTextStyle,
                    ),
                    Empty.V(24),
                    player,
                    Empty.V(24),
                    Text(
                      campaign.description,
                      style: descriptionTextStyle,
                    ),
                    Empty.V(24),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color(0xff323232),
                    ),
                    Empty.V(24),
                    if (campaign.articles!.isNotEmpty) buildArticles(),
                    Empty.V(24),
                    if (campaign.quizzes?.ids?.isNotEmpty ?? false)
                      if (Get.find<DataService>().isCampaignActive(campaign.id))
                        FlaqButton(
                          type: FlaqButtonType.thick,
                          onTap: handleQuizButton,
                          title: "complete the quiz",
                          maxWidth: true,
                        )
                      else if (Get.find<DataService>()
                          .isCampaignComplete(campaign.id))
                        FlaqButton(
                          disabled: true,
                          title: "completed",
                          type: FlaqButtonType.medium,
                          onTap: () {},
                        )
                      else
                        FlaqButton(
                          maxWidth: true,
                          type: FlaqButtonType.slider,
                          onTap: handleQuizButton,
                          title: "take the quiz",
                        )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
