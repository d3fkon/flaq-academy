import 'package:flaq/screens/home/inviteAndEarn.dart';
import 'package:flaq/screens/home/scaffold.dart';
import 'package:flaq/screens/home/transactionHistory.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flaq/widgets/common.dart';
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
                verticalSpace(55.67),
                InkWell(
                    onTap: () {
                      // Get.back();
                    },
                    child: customIcon(
                      Icons.arrow_back_outlined,
                      Colors.white,
                    )),
                verticalSpace(25),
                text(
                  'flaq-a-bank',
                  FontWeight.w400,
                  18,
                  Colors.white,
                ),
                verticalSpace(16),
                SizedBox(
                  width: 155,
                  child: GradientContainer(
                    rand: 0,
                    assetUrl: "assets/images/Lightning.png",
                    top: -13,
                    right: -20,
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
                  Colors.white,
                ),
                verticalSpace(24),
                text(
                  'invite a friend and earn upto 500 flaq',
                  FontWeight.w400,
                  12,
                  Colors.white,
                ),
                verticalSpace(24),
                customButton(
                  customHeight * 0.06,
                  customWidth * 0.9,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customIcon(
                        Icons.share,
                        const Color(0xFF3D3D3D),
                        size: 15,
                      ),
                      horizontalSpace(customWidth * 0.02),
                      text(
                        'invite and earn',
                        FontWeight.w600,
                        14,
                        const Color(0xFF3D3D3D),
                      ),
                    ],
                  ),
                  () {
                    Get.to(() => const InviteAndEarnScreen());
                  },
                  Colors.white,
                  4,
                ),
                verticalSpace(24),
                divider(const Color(0xFF1F1F1F)),
                verticalSpace(24),
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
                  Colors.white,
                ),
                verticalSpace(16),
                customButton(
                  customHeight * 0.06,
                  customWidth * 0.9,
                  text(
                    'see active campaigns',
                    FontWeight.w700,
                    14,
                    const Color(0xFF1A1A1A),
                  ),
                  () {
                    Get.offAll(() {
                      return const HomeScaffold(
                        tab: 1,
                      );
                    });
                  },
                  Colors.white,
                  4,
                ),
                verticalSpace(24),
                divider(const Color(0xFF1F1F1F)),
                verticalSpace(24),
                customButton(
                  customHeight * 0.06,
                  customWidth * 0.9,
                  text(
                    'logout',
                    FontWeight.w700,
                    14,
                    const Color(0xFF1A1A1A),
                  ),
                  () {
                    Get.find<AuthService>().signOut();
                  },
                  Colors.white,
                  4,
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
