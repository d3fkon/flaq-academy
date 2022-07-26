import 'package:flaq/screens/userApproval/smsOpenSettings.dart';
import 'package:flaq/services/root.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsApprovalScreen extends StatefulWidget {
  const SmsApprovalScreen({Key? key}) : super(key: key);

  @override
  State<SmsApprovalScreen> createState() => _SmsApprovalScreenState();
}

class _SmsApprovalScreenState extends State<SmsApprovalScreen>
    with WidgetsBindingObserver {
  load() async {
    await Get.putAsync(() => RootService().init());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await (Permission.sms.status).isGranted) {
        await Get.find<RootService>().navigate();
      }
      if (await (Permission.sms.status).isDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
      }
      if (await (Permission.sms.status).isPermanentlyDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0C0E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF1D1D1D),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpace(customHeight * 0.06),
                      Align(
                        alignment: Alignment.topLeft,
                        child: text(
                          'Flaq requires your\napproval for messages',
                          FontWeight.w400,
                          18,
                          Colors.white,
                        ),
                      ),
                      verticalSpace(customHeight * 0.03),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: text(
                          'flaq application rewards you for every payment you make, which are detected using messages',
                          FontWeight.w500,
                          12,
                          Colors.white,
                        ),
                      ),
                      verticalSpace(customHeight * 0.05),
                      showAssetImage('assets/images/give-approval.png'),
                      verticalSpace(customHeight * 0.05),
                      customButton(
                        customHeight * 0.06,
                        customWidth * 0.85,
                        text(
                          'give approval',
                          FontWeight.w700,
                          14,
                          Colors.black,
                        ),
                        () async {
                          await load();
                        },
                        Colors.white,
                        4,
                      ),
                      verticalSpace(customHeight * 0.035),
                    ],
                  ),
                ),
              ),
              verticalSpace(customHeight * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: text(
                    'faqs',
                    FontWeight.w400,
                    18,
                    Colors.white,
                  ),
                ),
              ),
              verticalSpace(customHeight * 0.02),
              Container(
                height: customHeight * 0.21,
                child: ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(
                                left: 20, top: 5, bottom: 5, right: 5)
                            : const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: customWidth * 0.88,
                          decoration: BoxDecoration(
                            color: const Color(0xFF131212),
                            border: Border.all(
                                color: const Color(0xFF272727), width: 2),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: text(
                                  'how does flaq work?',
                                  FontWeight.w400,
                                  18,
                                  Colors.white,
                                ),
                              ),
                              verticalSpace(customHeight * 0.01),
                              text(
                                'flaq application rewards you for every payment you make, which are detected using messages',
                                FontWeight.w500,
                                12,
                                Colors.white,
                              ),
                              verticalSpace(customHeight * 0.04),
                              Align(
                                alignment: Alignment.topLeft,
                                child: text(
                                  'wallets are an integral part of your Web3 journey',
                                  FontWeight.w500,
                                  10,
                                  Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              verticalSpace(customHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
