import 'package:flaq/screens/auth/signup.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class AddNewPassword extends StatefulWidget {
  const AddNewPassword({Key? key}) : super(key: key);

  @override
  State<AddNewPassword> createState() => _AddNewPasswordState();
}

class _AddNewPasswordState extends State<AddNewPassword> {
  bool passwordLengthError = false;
  bool matchingPasswords = true;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _passwordchangeformKey = GlobalKey<FormState>();
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
                key: _passwordchangeformKey,
                child: Column(
                  children: [
                    formField(
                        newPasswordController,
                        TextInputType.text,
                        'new password',
                        RequiredValidator(errorText: 'password is required'),
                        true),
                    verticalSpace(customHeight * 0.04),
                    formField(
                      confirmPasswordController,
                      TextInputType.text,
                      'confirm password',
                      RequiredValidator(errorText: 'password is required'),
                      true,
                    ),
                  ],
                ),
              ),
              verticalSpace(customHeight * 0.05),
              passwordLengthError
                  ? Align(
                      alignment: Alignment.center,
                      child: text(
                        'passwords must be at least 8 characters in length',
                        FontWeight.w400,
                        10,
                        const Color(0xFF9999A5),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              !matchingPasswords
                  ? Align(
                      alignment: Alignment.center,
                      child: text(
                        'passwords do not match, please try again',
                        FontWeight.w400,
                        10,
                        const Color(0xFF9999A5),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              verticalSpace(customHeight * 0.05),
              customButton(
                customHeight * 0.06,
                customWidth * 0.9,
                text('reset password', FontWeight.w700, 14, Colors.black),
                () {
                  if (newPasswordController.text.length >= 8 &&
                      confirmPasswordController.text.length >= 8) {
                    setState(() {
                      passwordLengthError = false;
                    });
                    if (_passwordchangeformKey.currentState!.validate()) {
                      if (newPasswordController.text ==
                          confirmPasswordController.text) {
                        setState(() {
                          matchingPasswords = true;
                        });
                        //add functionality here
                      } else {
                        setState(() {
                          matchingPasswords = false;
                        });
                      }
                    }
                  } else {
                    setState(() {
                      passwordLengthError = true;
                    });
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
