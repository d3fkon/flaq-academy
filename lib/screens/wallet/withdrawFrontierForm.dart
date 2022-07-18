import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class WithDrawFrontierForm extends StatefulWidget {
  const WithDrawFrontierForm({Key? key}) : super(key: key);

  @override
  State<WithDrawFrontierForm> createState() => _WithDrawFrontierFormState();
}

class _WithDrawFrontierFormState extends State<WithDrawFrontierForm> {
  final GlobalKey<FormState> _withdrawFrontierformKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF0E0C0E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
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
                    SizedBox(
                      height: customHeight * 0.06,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: customHeight * 0.02,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'withdraw froniter',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: customHeight * 0.02,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'send frontier to crypto address',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Form(
                key: _withdrawFrontierformKey,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'address',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF9999A5),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: customHeight * 0.015,
                    ),
                    TextFormField(
                      controller: addressController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                      decoration: InputDecoration(
                        hintText: 'long press to paste',
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
                          RequiredValidator(errorText: 'address is required'),
                    ),
                    SizedBox(
                      height: customHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'available',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF9999A5),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '6 FRONT',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF9999A5),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: customHeight * 0.05,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'important',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF9999A5),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: customHeight * 0.02,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF9999A5)),
                        ),
                        SizedBox(
                          width: customWidth * 0.025,
                        ),
                        SizedBox(
                          width: customWidth * 0.8,
                          child: const Text(
                            'withdrawals to your crypto address will take a minimum of 24 hours to arrive',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF9999A5),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: customHeight * 0.02,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF9999A5)),
                        ),
                        SizedBox(
                          width: customWidth * 0.025,
                        ),
                        SizedBox(
                          width: customWidth * 0.8,
                          child: const Text(
                            'make sure the address is correct its always good to double check your crypto address',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF9999A5),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: customHeight * 0.125,
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white, width: 1))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'receive amount',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF9999A5),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: customHeight * 0.01,
                  ),
                  const Text(
                    '6 FRONT',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF9999A5),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: customHeight * 0.01,
                  ),
                  const Text(
                    '\u{20B9} 99.92',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      color: Color(0xFF9999A5),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                      fixedSize: Size(customWidth * 0.45, customHeight * 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )),
                  onPressed: () {},
                  child: const Text(
                    'withdraw frontier',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  )),
            ],
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
