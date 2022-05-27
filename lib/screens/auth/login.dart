import 'package:flaq/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();
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
                'login to flaq',
                FontWeight.w500,
                20,
                Colors.white,
              ),
              SizedBox(
                height: customHeight * 0.02,
              ),
              _text(
                'enter your credentials',
                FontWeight.w400,
                14,
                const Color(0xFF9999A5),
              ),
              SizedBox(
                height: customHeight * 0.06,
              ),
              Form(
                key: _loginformKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                      decoration: InputDecoration(
                        hintText: 'email',
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
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'email is required'),
                        EmailValidator(errorText: 'enter a valid email')
                      ]),
                    ),
                    SizedBox(
                      height: customHeight * 0.04,
                    ),
                    TextFormField(
                      controller: passwordController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'password',
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
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'forgot password?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color(0xFF9999A5),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
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
                  if (_loginformKey.currentState!.validate()) {
                    // add functionality here
                  }
                },
                child: const Text(
                  'log in',
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
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SignUp();
                    }));
                  },
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
              ),
            ],
          ),
        ),
      )),
    );
  }
}
