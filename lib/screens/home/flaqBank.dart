import 'package:flaq/screens/home/inviteAndEarn.dart';
import 'package:flaq/screens/home/scaffold.dart';
import 'package:flaq/screens/home/transactionHistory.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/scaffold.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flaq/widgets/common.dart';
import 'package:flaq/widgets/flaq_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlaqBankScreen extends StatefulWidget {
  const FlaqBankScreen({Key? key}) : super(key: key);

  @override
  State<FlaqBankScreen> createState() => _FlaqBankScreenState();
}

class _FlaqBankScreenState extends State<FlaqBankScreen> {
  Widget divider(Color color) {
    return Divider(
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;
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

    return Scaffold(
      backgroundColor: const Color(0xFF0E0C0E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(25),
                const Text("flaq-a-bank", style: flaqTitleTextStyle),
                verticalSpace(16),
                SizedBox(
                  width: 155,
                  child: GradientContainer(
                    rand: 1,
                    assetUrl: "assets/images/Lightning.png",
                    scale: 1.3,
                    right: -20,
                    top: -5,
                    child: Row(
                      children: [
                        flaqPoints(),
                      ],
                    ),
                  ),
                ),
                verticalSpace(40),
                text(
                  'refer & earn flaq',
                  FontWeight.w400,
                  18,
                  Colors.white,
                ),
                verticalSpace(16),
                text(
                  'flaq is an invite only app',
                  FontWeight.w400,
                  14,
                  const Color(0xffB9B9B9),
                ),
                text(
                  'invite a friend and earn upto 500 flaq',
                  FontWeight.w400,
                  12,
                  const Color(0xffB9B9B9),
                ),
                Empty.V(24),
                FlaqButton(
                  type: FlaqButtonType.medium,
                  onTap: () {
                    Get.to(() => const InviteAndEarnScreen());
                  },
                  maxWidth: true,
                  title: '💬 invite & earn',
                ),
                Empty.V(24),
                divider(const Color(0xFF1F1F1F)),
                Empty.V(24),
                text(
                  'complete a campaign',
                  FontWeight.w400,
                  18,
                  Colors.white,
                ),
                verticalSpace(24),
                text(
                  'successfully complete a quiz and share the results with your friends to earn 1000 flaq',
                  FontWeight.w400,
                  12,
                  const Color(0xffB9B9B9),
                ),
                Empty.V(24),
                FlaqButton(
                  type: FlaqButtonType.medium,
                  onTap: () {
                    Get.find<ScaffoldService>().setIndex(1);
                  },
                  maxWidth: true,
                  title: '✅ complete a campaign',
                ),
                verticalSpace(24),
                divider(const Color(0xFF1F1F1F)),
                verticalSpace(24),
                FlaqButton(
                  type: FlaqButtonType.medium,
                  onTap: () {
                    Get.find<AuthService>().signOut();
                  },
                  maxWidth: true,
                  title: 'log out',
                ),
                verticalSpace(24),
                divider(const Color(0xFF1F1F1F)),
                verticalSpace(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
