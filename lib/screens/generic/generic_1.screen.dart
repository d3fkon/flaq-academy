import 'package:flaq/utils/constants.dart';
import 'package:flaq/widgets/flaq_button.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import '../../widgets/common.dart';

enum GenericScreenType { simpleButton, slider }

/// A Generic Screen for Flaq, with any required information
class Generic1Screen extends StatelessWidget {
  final GenericScreenType type;
  final String title = "nO BS\nnO SuGarCoaTing\nJuSt KnOwleDge";
  final String description =
      'eliminate the noise and learn about what really makes Web3 so special';
  const Generic1Screen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              width: 350,
              color: Colors.grey,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 34,
                      ),
                    ),
                    Empty.V(16),
                    Text(
                      description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const Expand(),
                    if (type == GenericScreenType.simpleButton)
                      FlaqButton(
                        type: FlaqButtonType.thick,
                        onTap: () {},
                        title: "next",
                      )
                    else if (type == GenericScreenType.slider)
                      FlaqButton(
                        type: FlaqButtonType.slider,
                        onTap: () {},
                        title: "       slide to get started",
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
