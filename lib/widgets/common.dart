import 'package:flaq/utils/constants.dart';
import 'package:flutter/material.dart';

List<LinearGradient> flaqGradients = [
  const LinearGradient(
    colors: [Color(0xffF64545), Color(0xff3384F5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  const LinearGradient(
    colors: [Color(0xffF6B364), Color(0xff9E58F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
];

/// Empty Spacers
class Empty {
  // A Horizontal Spacer
  static H(double i) => SizedBox(width: i);
  // A Vertical spacer
  static V(double i) => SizedBox(height: i);
}

/// A convenience for Expanded
class Expand extends StatelessWidget {
  const Expand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container());
  }
}

class GradientContainer extends StatelessWidget {
  final Widget child;
  final String assetUrl;
  final int rand;
  final double? top;
  final double? right;
  const GradientContainer(
      {Key? key,
      required this.child,
      required this.assetUrl,
      required this.rand,
      this.top,
      this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 88 + 57 / 2,
          child: Column(
            children: [
              const SizedBox(
                height: 57 / 2,
              ),
              Container(
                height: 88,
                decoration: BoxDecoration(
                  gradient: flaqGradients[rand],
                  borderRadius: FLAQ_BORDER_RADIUS,
                ),
                child: child,
              ),
            ],
          ),
        ),
        Positioned(
          top: top ?? 0,
          right: right ?? -3,
          child: Image.asset(assetUrl),
        ),
      ],
    );
  }
}

const flaqTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);
