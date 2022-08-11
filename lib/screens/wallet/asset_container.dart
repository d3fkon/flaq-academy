import 'package:flaq/models/rewards.model.dart';
import 'package:flaq/utils/constants.dart';
import 'package:flutter/material.dart';

List<Color> assetListColors = [
  (const Color(0xFFF7CD76)),
  (const Color(0xFFE9F5FA)),
  (const Color(0xFFB5FFC1)),
];

class AssetContainer extends StatelessWidget {
  final Reward reward;
  final int randInt;
  const AssetContainer({Key? key, required this.reward, required this.randInt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: assetListColors[randInt % assetListColors.length],
          borderRadius: FLAQ_BORDER_RADIUS,
        ),
        height: 84,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Image.network(
              reward.tickerImageUrl ?? '',
              height: 42,
              width: 42,
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.tickerName ?? "",
                  style: const TextStyle(
                    color: Color(0xff1A1A1A),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  reward.name ?? "",
                  style: const TextStyle(
                    color: Color(0xff1A1A1A),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\u{20B9}${(reward.conversion! * reward.amount!).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  (((reward.amount!)).toStringAsFixed(3)),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
