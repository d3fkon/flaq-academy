import 'package:flutter/material.dart';

class FlaqBalance extends StatefulWidget {
  final bool walletConnected;
  const FlaqBalance({Key? key, required this.walletConnected})
      : super(key: key);

  @override
  State<FlaqBalance> createState() => _FlaqBalanceState();
}

class _FlaqBalanceState extends State<FlaqBalance> {
  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.white,
                                child:
                                    Image.asset('assets/images/frontier.png')),
                            SizedBox(
                              width: customWidth * 0.025,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'FRONT',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: customHeight * 0.01,
                                ),
                                Text(
                                  'Qty 1.2 FRONT',
                                  style: const TextStyle(
                                    fontFamily: 'WorkSans',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\u{20B9}115.10',
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: customHeight * 0.01,
                            ),
                            Text(
                              'claimable',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
          SizedBox(
            height: customHeight * 0.03,
          ),
          widget.walletConnected
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: customWidth * 0.88,
                  decoration: BoxDecoration(
                    color: const Color(0xFF131212),
                    border:
                        Border.all(color: const Color(0xFF272727), width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'what is flaq balance and your wallet?',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: customHeight * 0.02,
                      ),
                      const Text(
                        'flaq wallet is where you accumalate rewards and your wallet is a self custodial frontier wallet where you can withdraw your rewards',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: customHeight * 0.02,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF0E0C0E),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                fixedSize: Size(
                                    customWidth * 0.32, customHeight * 0.04)),
                            onPressed: () {},
                            child: Row(
                              children: [
                                const Text(
                                  'learn more',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: customWidth * 0.02,
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 15,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'withdraw rewards',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: customHeight * 0.02,
                    ),
                    Text(
                      'connect your frontier wallet to claim rewards',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: customHeight * 0.025,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0E0C0E),
                            elevation: 0,
                            fixedSize:
                                Size(customWidth * 0.9, customHeight * 0.06),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            )),
                        onPressed: () {},
                        child: const Text(
                          'connect your wallet',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        )),
                  ],
                ),
          SizedBox(
            height: widget.walletConnected
                ? customHeight * 0.1
                : customHeight * 0.2,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  fixedSize: Size(customWidth * 0.9, customHeight * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
              onPressed: widget.walletConnected ? () {} : () {},
              child: widget.walletConnected
                  ? Text(
                      'withdraw frontier',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    )
                  : Text(
                      'withdraw frontier',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    )),
          SizedBox(
            height: customHeight * 0.05,
          ),
        ],
      ),
    );
  }
}
