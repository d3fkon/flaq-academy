import 'package:flaq/models/campaignModel.dart';
import 'package:flaq/utils/constants.dart';
import 'package:flaq/widgets/common.dart';
import 'package:flutter/material.dart';

enum ParticipationCardType { large, small }

class ParticipationCardData {
  final String imageUrl;
  final String title;
  final String tickerImageUrl;
  final String tickerName;
  final String rewardPerUser;

  static fromCampaign(Campaign campaign) {
    return ParticipationCardData(
      imageUrl: campaign.image ?? '',
      title: campaign.title ?? '',
      tickerImageUrl: campaign.tickerImageUrl ?? '',
      rewardPerUser: campaign.airdropPerUser.toString() ?? '',
      tickerName: campaign.tickerName ?? '',
    );
  }

  ParticipationCardData({
    required this.imageUrl,
    required this.title,
    required this.tickerImageUrl,
    required this.rewardPerUser,
    required this.tickerName,
  });
}

class ParticipationCard extends StatelessWidget {
  final ParticipationCardData data;
  final ParticipationCardType type;
  const ParticipationCard({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var backgroundDecoration = BoxDecoration(
      border: Border.all(color: Colors.grey.withOpacity(0.3)),
      borderRadius: FLAQ_BORDER_RADIUS,
      color: Colors.black,
    );
    var image = Image.network(
      data.imageUrl,
      width: 74,
      height: 74,
    );
    if (type == ParticipationCardType.large) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: backgroundDecoration,
          height: 120,
          child: Row(
            children: [
              Empty.H(24),
              image,
              Empty.H(24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expand(),
                    Text(
                      'you learnt ${data.title}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff9999A5),
                      ),
                    ),
                    Empty.V(24),
                    const Text(
                      'earnings',
                      style: TextStyle(
                        color: Color(0xff9999A5),
                        fontSize: 10,
                      ),
                    ),
                    Row(
                      children: [
                        Text(data.rewardPerUser.toString()),
                        Empty.H(4),
                        Image.network(
                          data.tickerImageUrl,
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                    const Expand(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        Column(
          children: [
            Empty.V(12),
            Expanded(
              child: Container(
                width: 163,
                decoration: backgroundDecoration,
                child: Column(
                  children: [
                    Empty.V(24),
                    image,
                    Empty.V(24),
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: Color(0xffF7F7F7),
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Image.network(
            data.tickerImageUrl,
            width: 32,
            height: 32,
          ),
        ),
      ],
    );
  }
}
