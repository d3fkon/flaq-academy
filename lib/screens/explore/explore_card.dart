import 'package:flaq/models/campaignModel.dart';
import 'package:flaq/screens/campaign/campaign_detail.screen.dart';
import 'package:flaq/utils/constants.dart';
import 'package:flaq/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ExploreCardType { large, small }

/// Class to accomodate the Explore Card.
class ExploreCardData {
  final String imageUrl;
  final String tickerImageUrl;
  final String tickerName;
  final String description;
  final String title;

  static ExploreCardData placeholder() {
    return ExploreCardData(
      imageUrl:
          'https://flaq-assets.s3.ap-south-1.amazonaws.com/eth-placeholder.png',
      tickerImageUrl:
          "https://flaq-assets.s3.ap-south-1.amazonaws.com/usdt.png",
      tickerName: "USDT",
      description: "learn about whether defi really is what the hypes about",
      title: "wtf is defi",
    );
  }

  static fromCampaign(Campaign campaign) {
    return ExploreCardData(
      imageUrl: campaign.image ?? "",
      tickerImageUrl: campaign.tickerImageUrl ?? "",
      tickerName: campaign.tickerName ?? "-",
      description: campaign.description ?? "-",
      title: campaign.title ?? "-",
    );
  }

  ExploreCardData({
    required this.imageUrl,
    required this.tickerImageUrl,
    required this.tickerName,
    required this.description,
    required this.title,
  });
}

// TODO: Remove ExploreData class and use Campaign for all requirements
/// Card to Help users explore Flaq.
class ExploreCard extends StatelessWidget {
  final ExploreCardData data;
  final ExploreCardType type;
  final Campaign campaign;
  const ExploreCard({
    Key? key,
    required this.data,
    required this.type,
    required this.campaign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );
    const descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 10,
      color: Color(0xffB9B9B9),
    );
    const tickerNameTextStyle = TextStyle(
      color: Color(0xff9999A5),
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );
    var earnRow = Row(
      mainAxisAlignment: type == ExploreCardType.large
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        Text(
          "earn ${data.tickerName}",
          style: tickerNameTextStyle,
        ),
        Empty.H(8),
        Image.network(
          data.tickerImageUrl,
          height: 32,
          width: 32,
        )
      ],
    );
    var title = Text(
      data.title,
      style: titleTextStyle,
    );
    var description = Text(
      data.description,
      style: descriptionTextStyle,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
    var image = Image.network(
      data.imageUrl,
      height: 74,
      width: 74,
    );
    var border = type == ExploreCardType.large
        ? Border.all(
            color: const Color(0xffEFEFEF).withOpacity(0.3),
            width: 1,
          )
        : null;
    var backgroundDecoration = BoxDecoration(
      color: const Color(0xff0E0C0E),
      borderRadius: FLAQ_BORDER_RADIUS,
      border: border,
    );

    Widget returnable;

    /// Render the small explore card
    if (type == ExploreCardType.small) {
      returnable = Container(
        decoration: backgroundDecoration,
        height: 163,
        width: 171,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Empty.V(16),
            image,
            title,
            Empty.V(9),
            earnRow,
          ],
        ),
      );
    } else {
      /// Render the large explore card
      returnable = Container(
        decoration: backgroundDecoration,
        height: 140,
        child: Row(
          children: [
            Empty.H(24),
            image,
            Empty.H(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Empty.V(20),
                  title,
                  Empty.V(12),
                  description,
                  Empty.V(16),
                  earnRow,
                ],
              ),
            ),
            Empty.H(24),
          ],
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        Get.to(
          () => CampaignDetailScreen(
            campaign: campaign,
          ),
        );
      },
      child: returnable,
    );
  }
}
