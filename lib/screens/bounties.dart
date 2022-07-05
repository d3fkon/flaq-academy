import 'package:flutter/material.dart';

class BountiesScreen extends StatefulWidget {
  const BountiesScreen({Key? key}) : super(key: key);

  @override
  State<BountiesScreen> createState() => _BountiesScreenState();
}

class _BountiesScreenState extends State<BountiesScreen> {
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
                SizedBox(
                  height: customHeight * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'flaq bounties',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xFF9999A5),
                          child: Icon(
                            Icons.person,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: customHeight * 0.03,
                ),
                Image.asset('assets/images/bounties.png'),
                SizedBox(
                  height: customHeight * 0.015,
                ),
                const Text(
                  'do bounties earn crypto',
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
                  'find opportunities and join us on this web3 journey.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
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
                                              const Text(
                                                'frontier',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 13,
                                                child: Image.asset(
                                                    'assets/images/frontier.png'),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      const Text(
                                        'write a wallet introduction script for frontier wallet with emphasis on NFTS',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    primary:
                                                        const Color(0xFFAC663B),
                                                  ),
                                                  child: const Text('research',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                      ))),
                                              SizedBox(
                                                width: customWidth * 0.02,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    primary:
                                                        const Color(0xFFAC663B),
                                                  ),
                                                  child: const Text('writing',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                      ))),
                                            ],
                                          ),
                                          const Text(
                                            '\$1000',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic,
                                            ),
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
                                              const Text(
                                                'filecoin',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 13,
                                                backgroundColor: Colors.white,
                                                child: Image.asset(
                                                    'assets/images/filecoin-blue.png'),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      const Text(
                                        'filecoin landing page redesign with branding focused on green change',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: customHeight * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    primary:
                                                        const Color(0xFF0090FF),
                                                  ),
                                                  child: const Text('research',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                      ))),
                                              SizedBox(
                                                width: customWidth * 0.02,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    primary:
                                                        const Color(0xFF0090FF),
                                                  ),
                                                  child: const Text('writing',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                      ))),
                                            ],
                                          ),
                                          const Text(
                                            '\$1000',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      }),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
