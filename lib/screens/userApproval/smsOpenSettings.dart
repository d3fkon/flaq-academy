import 'package:flaq/services/root.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsOpenSettingsScreen extends StatefulWidget {
  const SmsOpenSettingsScreen({Key? key}) : super(key: key);

  @override
  State<SmsOpenSettingsScreen> createState() => _OpenSettingsScreenState();
}

class _OpenSettingsScreenState extends State<SmsOpenSettingsScreen>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      if (await (Permission.sms.status).isGranted) {
        await Get.find<RootService>().navigate();
      }
      if (await (Permission.sms.status).isDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
        return;
      }
      if (await (Permission.sms.status).isPermanentlyDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
        return;
      }
    }
    if (state == AppLifecycleState.resumed) {
      if (await (Permission.sms.status).isGranted) {
        await Get.find<RootService>().navigate();
      }
      if (await (Permission.sms.status).isDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
        return;
      }
      if (await (Permission.sms.status).isPermanentlyDenied) {
        Get.offAll(() => const SmsOpenSettingsScreen());
        debugPrint('navigate to open settings screen');
        return;
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
                    )),
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
                          'sms permission need to be enabled',
                          FontWeight.w400,
                          18,
                          Colors.white,
                        ),
                      ),
                      verticalSpace(customHeight * 0.03),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: text(
                            'flaq needs access to sms',
                            FontWeight.w500,
                            12,
                            Colors.white,
                          ),
                        ),
                      ),
                      verticalSpace(customHeight * 0.05),
                      showAssetImage('assets/images/give-approval.png'),
                      verticalSpace(customHeight * 0.05),
                      customButton(
                        customHeight * 0.06,
                        customWidth * 0.85,
                        text(
                          'take me to settings',
                          FontWeight.w700,
                          14,
                          Colors.black,
                        ),
                        () async {
                          await openAppSettings();
                          // Get.find<RootService>().requestSmsPermission();
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
              SizedBox(
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
