import 'package:flaq/screens/campaign/campaign_detail.screen.dart';
import 'package:flaq/screens/participations/empty_campaigns.dart';
import 'package:flaq/screens/participations/participation_card.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticipationScreen extends StatefulWidget {
  const ParticipationScreen({Key? key}) : super(key: key);

  @override
  State<ParticipationScreen> createState() => _ParticipationScreenState();
}

class _ParticipationScreenState extends State<ParticipationScreen> {
  final authService = Get.find<AuthService>();
  final dataService = Get.find<DataService>();
  @override
  Widget build(BuildContext context) {
    Widget flaqPoints() {
      final user = Get.find<AuthService>().user;
      return (() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("flaq points"),
              Text(
                "${user.value?.flaqPoints ?? 0}",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ],
          ),
        );
      })();
    }

    Widget earnings() {
      return Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("earnings"),
              Text(
                "₹ ${authService.user.value?.totalEarnings ?? 0}",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ],
          ),
        );
      });
    }

    Widget _buildActiveCampaigns() {
      return Obx(
        () {
          if (dataService.participations.isEmpty) {
            return const EmptyCampaignsContainer();
          }
          if (dataService.getIncompeleteParticipations().isEmpty) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "active campaigns",
                style: flaqTitleTextStyle,
              ),
              Empty.V(20),
              SizedBox(
                height: 171,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...dataService.getIncompeleteParticipations().map(
                      (participation) {
                        var campaign = dataService
                            .getCampaignForId(participation.campaign!.id!);
                        return ParticipationCard(
                          type: ParticipationCardType.small,
                          data: ParticipationCardData.fromCampaign(campaign!),
                          onTap: () {
                            Get.to(
                                () => CampaignDetailScreen(campaign: campaign));
                          },
                        );
                      },
                    ),
                    Empty.V(24),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    Widget _buildFinishedCampaigns() {
      return Obx(() {
        if (dataService.participations.isEmpty ||
            dataService.getCompleteParticipations().isEmpty) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "finished campaigns",
              style: flaqTitleTextStyle,
            ),
            Empty.V(20),
            Column(
              children: [
                ...dataService.getCompleteParticipations().map(
                  (participation) {
                    var campaign = dataService
                        .getCampaignForId(participation.campaign!.id!);
                    return ParticipationCard(
                      type: ParticipationCardType.large,
                      data: ParticipationCardData.fromCampaign(campaign!),
                      onTap: () {
                        Get.to(() => CampaignDetailScreen(campaign: campaign));
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Empty.V(24),
              const Text(
                "participate in flaq",
                style: flaqTitleTextStyle,
              ),
              Empty.V(24),
              Row(
                children: [
                  Expanded(
                    child: GradientContainer(
                      rand: 0,
                      assetUrl: "assets/images/coins.png",
                      child: Row(
                        children: [
                          flaqPoints(),
                        ],
                      ),
                    ),
                  ),
                  Empty.H(16),
                  Expanded(
                    child: GradientContainer(
                      rand: 1,
                      assetUrl: "assets/images/Lightning.png",
                      scale: 1.3,
                      right: -20,
                      top: -5,
                      child: Row(
                        children: [
                          earnings(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Empty.V(24),
              _buildActiveCampaigns(),
              Empty.V(24),
              _buildFinishedCampaigns(),
              // const EmptyCampaignsContainer(),
            ],
          ),
        ),
      )),
    );
  }
}
