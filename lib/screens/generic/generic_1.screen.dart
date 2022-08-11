import 'package:flaq/widgets/flaq_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/common.dart';

enum GenericScreenType { simpleButton, slider }

class GenericScreenData {
  final GenericScreenType type;
  final String title;
  final String description;
  final String imageUrl;
  final String buttonText;
  final double imageScale;
  const GenericScreenData({
    required this.type,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.buttonText,
    this.imageScale = 1.0,
  });
  static GenericScreenData noBS = const GenericScreenData(
    type: GenericScreenType.simpleButton,
    title: "nO BS.no SuGaRcoAtiNg just knowledge",
    description:
        "eliminate the noise and learn about what really makes Web3 so special",
    imageUrl: "assets/images/Lightbulb.png",
    buttonText: "next",
    imageScale: 1,
  );

  static GenericScreenData earn$ = const GenericScreenData(
    type: GenericScreenType.slider,
    title: "earn actual \$\$\$ while just learning no kidding",
    description:
        "it’s kinda crazy but yeah we reward you for just educating yourself. you’re welcome ",
    imageUrl: "assets/images/coins.png",
    buttonText: "swipe to get started",
    imageScale: 0.8,
  );
}

/// A Generic Screen for Flaq, with any required information
class Generic1Screen extends StatelessWidget {
  final GenericScreenData data;
  final VoidCallback onTap;
  const Generic1Screen({Key? key, required this.data, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  width: 350,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(2000),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff211E41),
                        Color(0xff352A6E),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 350,
                  width: 350 * data.imageScale,
                  child: Image.asset(
                    data.imageUrl,
                    fit: data.imageScale == 1 ? BoxFit.cover : BoxFit.contain,
                  ),
                ),
                Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.17),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 34,
                      ),
                    ),
                    Empty.V(16),
                    Text(
                      data.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const Expand(),
                    if (data.type == GenericScreenType.simpleButton)
                      FlaqButton(
                        type: FlaqButtonType.thick,
                        onTap: onTap,
                        title: data.buttonText,
                        disabled: false,
                      )
                    else if (data.type == GenericScreenType.slider)
                      FlaqButton(
                        type: FlaqButtonType.slider,
                        onTap: onTap,
                        title: "       ${data.buttonText}",
                      ),
                    Empty.V(52)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
