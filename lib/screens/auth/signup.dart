import 'package:flaq/screens/auth/login.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordLengthError = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _signupformKey = GlobalKey<FormState>();
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
                'sign up',
                FontWeight.w500,
                20,
                Colors.white,
              ),
              verticalSpace(customHeight * 0.02),
              text(
                'enter your credentials',
                FontWeight.w400,
                14,
                const Color(0xFF9999A5),
              ),
              verticalSpace(customHeight * 0.06),
              Form(
                key: _signupformKey,
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
                        false),
                    verticalSpace(customHeight * 0.04),
                    formField(
                        passwordController,
                        TextInputType.text,
                        'password',
                        RequiredValidator(errorText: 'password is required'),
                        true),
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
              verticalSpace(customHeight * 0.05),
              customButton(
                  customHeight * 0.06,
                  customWidth * 0.9,
                  text(
                    'sign up',
                    FontWeight.w700,
                    14,
                    Colors.black,
                  ), () {
                if (passwordController.text.length >= 8) {
                  setState(() {
                    passwordLengthError = false;
                  });
                  if (_signupformKey.currentState!.validate()) {
                    final AuthService authService = Get.find();
                    authService.signup(
                        emailController.text, passwordController.text);
                  }
                } else {
                  setState(() {
                    passwordLengthError = true;
                  });
                }
              }, Colors.white, 4),
              verticalSpace(customHeight * 0.02),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                  child: textWithUnderline(
                    'log in',
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
