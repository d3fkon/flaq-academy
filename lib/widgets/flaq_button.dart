import 'package:flaq/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

enum FlaqButtonType { thick, medium, slider }

/// An extensive button for Flaq
class FlaqButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final FlaqButtonType type;
  final bool maxWidth;
  final bool isDark;
  const FlaqButton({
    Key? key,
    required this.type,
    required this.onTap,
    required this.title,
    this.maxWidth = false,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor = isDark ? Colors.black : const Color(0xffEFEFEF);
    Color textColor = isDark ? Colors.white : Colors.black;
    double height = 0;
    double width = 0;
    switch (type) {
      case FlaqButtonType.thick:
        height = 60;
        width = 233;
        break;
      case FlaqButtonType.medium:
        height = 48;
        width = 188;
        break;
      case FlaqButtonType.slider:
        width = 250;
        height = 60;
        break;
    }

    if (maxWidth) {
      width = MediaQuery.of(context).size.width;
    }

    Widget returnable;

    if (type == FlaqButtonType.slider) {
      returnable = Center(
        child: ConfirmationSlider(
          backgroundShape: FLAQ_BORDER_RADIUS,
          foregroundShape: FLAQ_BORDER_RADIUS,
          width: width,
          height: height,
          text: title,
          textStyle: const TextStyle(
            color: Color(0xff1A1A1A),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          sliderButtonContent: const Icon(Icons.arrow_forward),
          foregroundColor: Colors.black,
          onConfirmation: onTap,
        ),
      );
    } else {
      returnable = Center(
        child: ElevatedButton(
          // st: const Color(0xffEFEFEF),
          style: ElevatedButton.styleFrom(
            primary: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: FLAQ_BORDER_RADIUS,
            ),
            fixedSize: Size(width, height),
          ),
          onPressed: () {
            // TODO: Add vibrate
            onTap();
          },
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ),
      );
      var eturnable = Center(
        child: GestureDetector(
          onTap: () {
            // TODO: Add vibrate
            onTap();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: FLAQ_BORDER_RADIUS,
              color: const Color(0xffEFEFEF),
            ),
            width: width,
            height: height,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return returnable;
  }
}
