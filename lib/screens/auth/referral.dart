import 'package:flaq/screens/home.screen.dart';
import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/root.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  TextEditingController referralController = TextEditingController();
  final GlobalKey<FormState> _referralformKey = GlobalKey<FormState>();
  final Uri toLaunch =
      Uri(scheme: 'https', host: 't.me', path: '+pUwD3bO2KAA0NTI1');
  _launchUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(customHeight * 0.1),
              text(
                'just one last thing',
                FontWeight.w500,
                20,
                Colors.white,
              ),
              verticalSpace(customHeight * 0.02),
              text(
                'we need a referral code',
                FontWeight.w400,
                14,
                const Color(0xFF9999A5),
              ),
              verticalSpace(customHeight * 0.06),
              Form(
                key: _referralformKey,
                child: formField(
                  referralController,
                  TextInputType.text,
                  'referral code',
                  RequiredValidator(errorText: 'referral code is required'),
                  false,
                ),
              ),
              verticalSpace(customHeight * 0.2),
              customButton(
                customHeight * 0.06,
                customWidth * 0.9,
                text(
                  'finish',
                  FontWeight.w700,
                  14,
                  Colors.black,
                ),
                () async {
                  if (_referralformKey.currentState!.validate()) {
                    final apiService = Get.find<ApiService>();
                    await apiService.checkReferralCode(referralController.text);
                  }
                },
                Colors.white,
                4,
              ),
              verticalSpace(customHeight * 0.02),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {
                    await _launchUrl(toLaunch);
                  },
                  child: textWithUnderline(
                    'no referral code? join our telegram group',
                    FontWeight.w700,
                    12,
                    const Color(0xFF9999A5),
                  ),
                ),
              ),
              verticalSpace(customHeight * 0.2),
              Text.rich(
                TextSpan(
                  children: [
                    textSpan(
                      'by signing up you agree to our ',
                      FontWeight.w400,
                      10,
                      Colors.white,
                    ),
                    textSpanWithUnderline(
                      'terms of use, privacy policy, information collection,',
                      FontWeight.w400,
                      10,
                      const Color(0xFF363664),
                    ),
                    textSpan(
                      'and that you are over 18 years old',
                      FontWeight.w400,
                      10,
                      Colors.white,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
