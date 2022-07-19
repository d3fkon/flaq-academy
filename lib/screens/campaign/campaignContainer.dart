import 'package:flaq/models/campaignModel.dart';
import 'package:flaq/screens/campaign/aboutFrontier.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CampaignContainer extends StatefulWidget {
  CampaignData? campaigns;
  final int index;
  List participationIds = [];
  List completed = [];

  CampaignContainer(
      {Key? key,
      required this.campaigns,
      required this.index,
      required this.participationIds,
      required this.completed})
      : super(key: key);

  @override
  State<CampaignContainer> createState() => _CampaignContainerState();
}

class _CampaignContainerState extends State<CampaignContainer> {
  String participationID = '';

  onClick(var customWidth, var customHeight) async {
    setState(() {
      Helper.ytId = Helper.getYoutubeVideoIdByURL(
          widget.campaigns!.campaigns![widget.index].ytVideoUrl);
      for (int i = 0; i < widget.campaigns!.participations!.length; i++) {
        if (widget.campaigns!.participations![i].campaign!.id ==
            widget.campaigns!.campaigns![widget.index].id) {
          participationID = widget.campaigns!.participations![i].id!;
        }
      }
    });

    widget.participationIds
            .contains(widget.campaigns!.campaigns![widget.index].id)
        ? Get.to(() => WhatIsFrontier(
              campaign: widget.campaigns!.campaigns![widget.index],
              participationId: participationID,
            ))
        : showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: text(
                  'Confirmation',
                  FontWeight.w600,
                  18,
                  Colors.black,
                ),
                content: text(
                  'are you sure you want to participate in this campaign using ${widget.campaigns!.campaigns![widget.index].requiredFlaq} flaq points?',
                  FontWeight.w500,
                  14,
                  Colors.grey,
                ),
                actions: [
                  customButton(
                    customHeight * 0.06,
                    customWidth * 0.3,
                    text(
                      'No',
                      FontWeight.w600,
                      14,
                      Colors.grey,
                    ),
                    () {
                      Navigator.pop(context);
                    },
                    Colors.white,
                    4,
                  ),
                  customButton(
                    customHeight * 0.06,
                    customWidth * 0.3,
                    text(
                      'Yes',
                      FontWeight.w600,
                      14,
                      Colors.white,
                    ),
                    () async {
                      var participated = await Get.find<ApiService>()
                          .participateInCampaign(
                              widget.campaigns!.campaigns![widget.index].id ??
                                  '');
                      if (participated) {
                        EasyLoading.show();
                        widget.campaigns =
                            await Get.find<ApiService>().getCampaigns();
                        if (widget.campaigns != null) {
                          if (mounted) {
                            setState(() {
                              for (int i = 0;
                                  i < widget.campaigns!.participations!.length;
                                  i++) {
                                if (widget.campaigns!.participations![i]
                                        .campaign!.id ==
                                    widget.campaigns!.campaigns![widget.index]
                                        .id) {
                                  participationID =
                                      widget.campaigns!.participations![i].id!;
                                }
                              }
                              Navigator.pop(context);
                              Get.to(() => WhatIsFrontier(
                                    campaign: widget
                                        .campaigns!.campaigns![widget.index],
                                    participationId: participationID,
                                  ));
                              EasyLoading.dismiss();
                            });
                          }
                        }
                      } else {
                        Navigator.pop(context);
                        Helper.toast('error participating, please try again');
                      }
                    },
                    Colors.black,
                    4,
                  ),
                ],
              );
            });
  }

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

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: widget.index == 0
            ? const EdgeInsets.fromLTRB(20, 0, 20, 8)
            : const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(
                      widget.campaigns!.campaigns![widget.index].title
                          .toString(),
                      FontWeight.w500,
                      18,
                      Colors.black,
                    ),
                    circleAvatar(
                      13,
                      Colors.transparent,
                      showNetworkImage(widget
                          .campaigns!.campaigns![widget.index].tickerImageUrl
                          .toString()),
                    ),
                  ],
                ),
              ),
              verticalSpace(customHeight * 0.01),
              Align(
                alignment: Alignment.topLeft,
                child: text(
                  widget.campaigns!.campaigns![widget.index].description
                      .toString(),
                  FontWeight.w500,
                  12,
                  Colors.black,
                ),
              ),
              verticalSpace(customHeight * 0.01),
              widget.completed[widget.index] == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: textWorkSans(
                        'quiz completed',
                        FontWeight.w500,
                        14,
                        Colors.black,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.participationIds.contains(
                                widget.campaigns!.campaigns![widget.index].id)
                            ? textWorkSans(
                                'unlocked',
                                FontWeight.w500,
                                14,
                                Colors.black,
                              )
                            : textWorkSans(
                                'earn ${widget.campaigns!.campaigns![widget.index].airdropPerUser} ${widget.campaigns!.campaigns![widget.index].tickerName}',
                                FontWeight.w500,
                                14,
                                Colors.black,
                              ),
                        customButton(
                          customHeight * 0.04,
                          customWidth * 0.42,
                          widget.participationIds.contains(
                                  widget.campaigns!.campaigns![widget.index].id)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    text(
                                      'take the quiz',
                                      FontWeight.w700,
                                      12,
                                      Colors.white,
                                    ),
                                    horizontalSpace(customWidth * 0.02),
                                    customIcon(
                                      Icons.arrow_forward,
                                      Colors.white,
                                      size: 15,
                                    ),
                                  ],
                                )
                              : text(
                                  'use ${widget.campaigns!.campaigns![widget.index].requiredFlaq} flaq',
                                  FontWeight.w700,
                                  12,
                                  Colors.white,
                                ),
                          () async {
                            await onClick(customWidth, customHeight);
                          },
                          Colors.black,
                          4,
                        ),
                      ],
                    ),
            ],
          ),
        ));
  }
}
