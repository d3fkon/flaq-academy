import 'package:flaq/screens/explore/explore_card.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  var dataService = Get.find<DataService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Empty.V(24),
              const Text(
                "explore flaq",
                style: flaqTitleTextStyle,
              ),
              Empty.V(24),
              if (dataService.campaigns.isNotEmpty)
                ExploreCard(
                  campaign: dataService.campaigns[0],
                  type: ExploreCardType.large,
                  data: ExploreCardData.fromCampaign(dataService.campaigns[0]),
                ),
              Empty.V(16),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  children: [
                    for (final i in [
                      for (var i = 1; i < dataService.campaigns.length; i += 1)
                        i
                    ])
                      ExploreCard(
                        campaign: dataService.campaigns[i],
                        type: ExploreCardType.small,
                        data: ExploreCardData.fromCampaign(
                          dataService.campaigns[i],
                        ),
                      ),
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
