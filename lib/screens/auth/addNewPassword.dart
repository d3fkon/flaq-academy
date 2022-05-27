import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
    Widget _text(String content, FontWeight fontweight, double fontsize,
        Color textcolor) {
      return Text(
        content,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: fontweight,
          fontSize: fontsize,
          color: textcolor,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: customHeight * 0.1,
              ),
              _text(
                'forgot password',
                FontWeight.w500,
                20,
                Colors.white,
              ),
              SizedBox(
                height: customHeight * 0.02,
              ),
              _text(
                'reset your password',
                FontWeight.w400,
                14,
                const Color(0xFF9999A5),
              ),
              SizedBox(
                height: customHeight * 0.06,
              ),
              Form(
                key: _passwordchangeformKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: newPasswordController,
                      cursorColor: Colors.white,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                      decoration: InputDecoration(
                        hintText: 'new password',
                        hintStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF9999A5),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        fillColor: const Color(0xFF1A1A1A),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 0.2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 0.2,
                          ),
                        ),
                      ),
                      validator:
                          RequiredValidator(errorText: 'password is required'),
                    ),
                    SizedBox(
                      height: customHeight * 0.04,
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'confirm password',
                        hintStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF9999A5),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        fillColor: const Color(0xFF1A1A1A),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 0.2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 0.2,
                          ),
                        ),
                      ),
                      validator:
                          RequiredValidator(errorText: 'password is required'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: customHeight * 0.05,
              ),
              passwordLengthError
                  ? Align(
                      alignment: Alignment.center,
                      child: _text(
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
                      child: _text(
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
              SizedBox(
                height: customHeight * 0.05,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                    fixedSize: Size(customWidth * 0.9, customHeight * 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    )),
                onPressed: () {
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
                child: const Text(
                  'reset password',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: customHeight * 0.02,
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: const Text(
                    'new user? sign up',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF9999A5),
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: customHeight * 0.2,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'by signing up you agree to our ',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                    TextSpan(
                      text:
                          'terms of use, privacy policy, information collection,',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF363664),
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        fontSize: 10,
                      ),
                    ),
                    TextSpan(
                      text: 'and that you are over 18 years old',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      )),
    );
  }
}
