import 'package:flaq/screens/auth/signup.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController vcodeController = TextEditingController();
  final GlobalKey<FormState> _forgotpasswordformKey = GlobalKey<FormState>();
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
                'forgot password',
                FontWeight.w500,
                20,
                Colors.white,
              ),
              verticalSpace(customHeight * 0.02),
              text(
                'reset your password',
                FontWeight.w400,
                14,
                const Color(0xFF9999A5),
              ),
              verticalSpace(customHeight * 0.06),
              Form(
                key: _forgotpasswordformKey,
                child: Column(
                  children: [
                    formField(
                      emailController,
                      TextInputType.emailAddress,
                      'email',
                      MultiValidator([
                        RequiredValidator(errorText: 'email is required'),
                        EmailValidator(errorText: 'enter a valid email')
                      ]),
                      false,
                    ),
                    verticalSpace(customHeight * 0.04),
                    formfieldWithSuffix(
                      vcodeController,
                      TextInputType.text,
                      'verification code',
                      RequiredValidator(
                          errorText: 'verification code is required'),
                      false,
                      text(
                        'send code',
                        FontWeight.w500,
                        12,
                        Colors.white,
                      ),
                      () {},
                    ),
                  ],
                ),
              ),
              verticalSpace(customHeight * 0.05),
              Align(
                alignment: Alignment.topRight,
                child: text(
                  'forgot password?',
                  FontWeight.w400,
                  12,
                  const Color(0xFF9999A5),
                ),
              ),
              verticalSpace(customHeight * 0.05),
              customButton(
                customHeight * 0.06,
                customWidth * 0.9,
                text(
                  'log in',
                  FontWeight.w700,
                  14,
                  Colors.black,
                ),
                () {
                  if (_forgotpasswordformKey.currentState!.validate()) {
                    // add functionality here
                  }
                },
                Colors.white,
                4,
              ),
              verticalSpace(customHeight * 0.02),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Get.offAll(() => const SignUp());
                  },
                  child: textWithUnderline(
                    'new user? sign up',
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
