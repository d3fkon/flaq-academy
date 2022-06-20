import 'package:flaq/main.dart';
import 'package:flaq/screens/sms_open_settings.dart';
import 'package:flaq/services/messaging.service.dart';
import 'package:flaq/services/root.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        Get.find<RootService>().isSmsPermissionGranted(true);
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
                      SizedBox(
                        height: customHeight * 0.06,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Flaq requires your\napproval for messages',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: customHeight * 0.03,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'flaq application rewards you for every payment you make, which are detected using messages',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: customHeight * 0.05,
                      ),
                      Image.asset('assets/images/give-approval.png'),
                      SizedBox(
                        height: customHeight * 0.05,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 0,
                              fixedSize:
                                  Size(customWidth * 0.85, customHeight * 0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              )),
                          onPressed: () async {
                            await load();
                            Get.find<RootService>().requestSmsPermission();
                          },
                          child: const Text(
                            'give approval',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          )),
                      SizedBox(
                        height: customHeight * 0.035,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: customHeight * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'faqs',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: customHeight * 0.02,
              ),
              Container(
                height: customHeight * 0.21,
                child: ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == 0
                            ? EdgeInsets.only(
                                left: 20, top: 5, bottom: 5, right: 5)
                            : EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'how does flaq work?',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: customHeight * 0.01,
                              ),
                              const Text(
                                'flaq application rewards you for every payment you make, which are detected using messages',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: customHeight * 0.04,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'wallets are an integral part of your Web3 journey',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: customHeight * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
