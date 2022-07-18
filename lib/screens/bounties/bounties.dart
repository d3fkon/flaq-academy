import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';

class BountiesScreen extends StatefulWidget {
  const BountiesScreen({Key? key}) : super(key: key);

  @override
  State<BountiesScreen> createState() => _BountiesScreenState();
}

class _BountiesScreenState extends State<BountiesScreen> {
  Widget circleAvatar(
    double radius,
    Color color,
    Widget child,
  ) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: child,
    );
  }

  Widget italicText(
    String content,
    FontWeight fontweight,
    double fontsize,
    Color textcolor,
  ) {
    return Text(
      content,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: fontweight,
        fontSize: fontsize,
        color: textcolor,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget bountyButton(
    Widget child,
    VoidCallback onPressed,
    Color color,
    double borderRadius,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF0E0C0E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(customHeight * 0.07),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(
                      'flaq bounties',
                      FontWeight.w500,
                      20,
                      Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onTap: () {},
                        child: circleAvatar(
                          12,
                          const Color(0xFF9999A5),
                          customIcon(
                            Icons.person,
                            Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(customHeight * 0.03),
                showAssetImage('assets/images/bounties.png'),
                verticalSpace(customHeight * 0.015),
                text(
                  'do bounties earn crypto',
                  FontWeight.w400,
                  14,
                  const Color(0xFF9999A5),
                ),
                verticalSpace(customHeight * 0.01),
                text(
                  'find opportunities and join us on this web3 journey.',
                  FontWeight.w500,
                  20,
                  Colors.white,
                ),
                verticalSpace(customHeight * 0.02),
                SizedBox(
                  width: customWidth,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.fromLTRB(0, 8, 0, 8)
                              : const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 8,
                                ),
                          child: index == 0
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              text(
                                                'frontier',
                                                FontWeight.w500,
                                                18,
                                                Colors.black,
                                              ),
                                              circleAvatar(
                                                13,
                                                Colors.transparent,
                                                showAssetImage(
                                                    'assets/images/frontier.png'),
                                              ),
                                            ],
                                          )),
                                      verticalSpace(customHeight * 0.01),
                                      text(
                                        'write a wallet introduction script for frontier wallet with emphasis on NFTS',
                                        FontWeight.w500,
                                        12,
                                        Colors.black,
                                      ),
                                      verticalSpace(customHeight * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              bountyButton(
                                                text(
                                                  'research',
                                                  FontWeight.w400,
                                                  12,
                                                  Colors.white,
                                                ),
                                                () {},
                                                const Color(0xFFAC663B),
                                                20,
                                              ),
                                              horizontalSpace(
                                                  customWidth * 0.02),
                                              bountyButton(
                                                text(
                                                  'writing',
                                                  FontWeight.w400,
                                                  12,
                                                  Colors.white,
                                                ),
                                                () {},
                                                const Color(0xFFAC663B),
                                                20,
                                              ),
                                            ],
                                          ),
                                          italicText(
                                            '\$1000',
                                            FontWeight.w600,
                                            16,
                                            Colors.black,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              text(
                                                'filecoin',
                                                FontWeight.w500,
                                                18,
                                                Colors.black,
                                              ),
                                              circleAvatar(
                                                13,
                                                Colors.white,
                                                showAssetImage(
                                                    'assets/images/filecoin-blue.png'),
                                              ),
                                            ],
                                          )),
                                      verticalSpace(customHeight * 0.01),
                                      text(
                                        'filecoin landing page redesign with branding focused on green change',
                                        FontWeight.w500,
                                        12,
                                        Colors.black,
                                      ),
                                      verticalSpace(customHeight * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              bountyButton(
                                                text(
                                                  'research',
                                                  FontWeight.w400,
                                                  12,
                                                  Colors.white,
                                                ),
                                                () {},
                                                Colors.blue,
                                                20,
                                              ),
                                              horizontalSpace(
                                                  customWidth * 0.02),
                                              bountyButton(
                                                text(
                                                  'writing',
                                                  FontWeight.w400,
                                                  12,
                                                  Colors.white,
                                                ),
                                                () {},
                                                Colors.blue,
                                                20,
                                              ),
                                            ],
                                          ),
                                          italicText(
                                            '\$1000',
                                            FontWeight.w600,
                                            16,
                                            Colors.black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      }),
                ),
                verticalSpace(customHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
