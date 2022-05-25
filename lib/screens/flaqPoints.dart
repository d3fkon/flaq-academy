import 'package:flutter/material.dart';

class FalqPoints extends StatefulWidget {
  const FalqPoints({Key? key}) : super(key: key);

  @override
  State<FalqPoints> createState() => _FalqPointsState();
}

class _FalqPointsState extends State<FalqPoints> {
  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0C0E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'flaq points',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: customHeight * 0.005,
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/images/icon-1.png'),
                                  SizedBox(
                                    width: customWidth * 0.01,
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '1,201.12',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Image.asset('assets/images/icon-2.png'),
                                Positioned(
                                    bottom: 30,
                                    right: 30,
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: const Color(0xFF9999A5),
                                      child: Image.asset(
                                          'assets/images/icon-1-white.png'),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: customHeight * 0.025,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'flaq rewards you for every upi payment you make which you can then redeem for front tokens',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: customHeight * 0.025,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 0,
                              fixedSize:
                                  Size(customWidth * 0.9, customHeight * 0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              )),
                          onPressed: () {},
                          child: const Text(
                            'claim rewards',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          )),
                      SizedBox(
                        height: customHeight * 0.025,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: customHeight * 0.03,
              ),
              Container(
                height: customHeight * 0.26,
                child: ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(
                                left: 20, top: 5, bottom: 5, right: 5)
                            : const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: customWidth * 0.88,
                          decoration: BoxDecoration(
                            color: const Color(0xFF131212),
                            border: Border.all(
                                color: const Color(0xFF272727), width: 2),
                          ),
                          child: Column(
                            children: [
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'what is ',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'frontier',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFFa76237),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '?',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: customHeight * 0.01,
                              ),
                              const Text(
                                'Frontier is a Crypto & DeFi, NFT wallet where you can send, store & invest in 4,000+ crypto assets',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: customHeight * 0.01,
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
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        fixedSize: Size(customWidth * 0.32,
                                            customHeight * 0.04)),
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
                              SizedBox(
                                height: customHeight * 0.02,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'wallets are an integral part of your Web3 journey',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: customHeight * 0.025,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'transactions',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: customHeight * 0.015,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: customWidth,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: customHeight * 0.075,
                                    width: customWidth * 0.15,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF1A1A1A),
                                        border: Border.all(
                                            color: const Color(0xFF000000),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Image.asset(
                                        'assets/images/transactions.png'),
                                  ),
                                  SizedBox(
                                    width: customWidth * 0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Flaq earned',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF9999A5),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      const Text(
                                        '6 Flaq',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
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
                                  const Text(
                                    '- \u{20B9}500',
                                    style: TextStyle(
                                      fontFamily: 'WorkSans',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: customHeight * 0.01,
                                  ),
                                  const Text(
                                    '20/04',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF9999A5),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: customHeight * 0.02,
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'see more',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: customHeight * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
