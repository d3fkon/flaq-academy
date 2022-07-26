import 'package:flaq/widgets/common.dart';
import 'package:flaq/widgets/flaq_button.dart';
import 'package:flutter/material.dart';

class EmptyCampaignsContainer extends StatelessWidget {
  const EmptyCampaignsContainer({Key? key}) : super(key: key);
  final text = "gm there! looks like you have\nno active campaigns";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Empty.V(42),
          Image.asset(
            'assets/images/sleep.png',
            height: 78,
            width: 78,
          ),
          Empty.V(15),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xffb9b9b9),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Empty.V(34),
          FlaqButton(
            type: FlaqButtonType.medium,
            title: "explore",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
