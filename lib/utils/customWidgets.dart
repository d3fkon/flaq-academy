import 'package:flutter/material.dart';

Widget text(
    String content, FontWeight fontweight, double fontsize, Color textcolor) {
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

Widget textWithUnderline(
    String content, FontWeight fontweight, double fontsize, Color textcolor) {
  return Text(
    content,
    style: TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: fontweight,
      fontSize: fontsize,
      color: textcolor,
      decoration: TextDecoration.underline,
    ),
  );
}

Widget textWorkSans(
    String content, FontWeight fontweight, double fontsize, Color textcolor) {
  return Text(
    content,
    style: TextStyle(
      fontFamily: 'WorkSans',
      fontWeight: fontweight,
      fontSize: fontsize,
      color: textcolor,
    ),
  );
}

textSpan(
    String content, FontWeight fontweight, double fontsize, Color textcolor) {
  return TextSpan(
    text: content,
    style: TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: fontweight,
      fontSize: fontsize,
      color: textcolor,
    ),
  );
}

textSpanWithUnderline(
    String content, FontWeight fontweight, double fontsize, Color textcolor) {
  return TextSpan(
    text: content,
    style: TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: fontweight,
      fontSize: fontsize,
      color: textcolor,
      decoration: TextDecoration.underline,
    ),
  );
}

Widget customIcon(IconData icon, Color color, {double? size}) {
  return Icon(
    icon,
    color: color,
    size: size,
  );
}

Widget customButton(
  var height,
  var width,
  Widget child,
  VoidCallback onPressed,
  Color color,
  double borderRadius,
) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: color,
        elevation: 0,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        )),
    onPressed: onPressed,
    child: child,
  );
}

Widget verticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget horizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget formField(
  TextEditingController controller,
  TextInputType inputType,
  String hintText,
  String? Function(String?)? validator,
  bool isObsecure,
) {
  return TextFormField(
    controller: controller,
    cursorColor: Colors.white,
    obscureText: isObsecure,
    keyboardType: inputType,
    style: const TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
    ),
    decoration: InputDecoration(
      hintText: hintText,
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
    validator: validator,
  );
}

Widget formfieldWithSuffix(
  TextEditingController controller,
  TextInputType inputType,
  String hintText,
  String? Function(String?)? validator,
  bool isObsecure,
  Widget suffix,
  VoidCallback suffixCallBack,
) {
  return TextFormField(
    controller: controller,
    cursorColor: Colors.white,
    keyboardType: TextInputType.text,
    style: const TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
    ),
    obscureText: isObsecure,
    decoration: InputDecoration(
      suffixIcon: InkWell(
        onTap: suffixCallBack,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: suffix,
        ),
      ),
      hintText: hintText,
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
    validator: validator,
  );
}

Widget showAssetImage(String image, {double? width, double? height}) {
  return Image.asset(
    image,
    height: height,
    width: width,
  );
}
