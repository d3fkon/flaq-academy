import 'package:flaq/screens/quiz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WhatIsFrontier extends StatefulWidget {
  const WhatIsFrontier({Key? key}) : super(key: key);

  @override
  State<WhatIsFrontier> createState() => _WhatIsFrontierState();
}

class _WhatIsFrontierState extends State<WhatIsFrontier> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'FLlMfUaE2uo',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );
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
                height: customHeight * 0.05,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: customHeight * 0.02,
              ),
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
                            fontSize: 24,
                          ),
                        ),
                        TextSpan(
                          text: 'frontier',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFFa76237),
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                        TextSpan(
                          text: '?',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: customHeight * 0.02,
              ),
              SizedBox(
                height: customHeight * 0.38,
                child: Container(
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
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'learn how frontier works',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          )),
                      SizedBox(
                        height: customHeight * 0.01,
                      ),
                      const Text(
                        'here’s a short video on explaining how the wallet works and about the frontier team',
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
                      YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _controller,
                        ),
                        builder: (BuildContext, player) {
                          return player;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: customHeight * 0.05,
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'feed your mind',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  )),
              SizedBox(
                height: customHeight * 0.01,
              ),
              SizedBox(
                width: customWidth * 0.8,
                child: const Text(
                  'here are some articles for you to read and learn about how the frontier works in depth',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: customHeight * 0.01,
              ),
              SizedBox(
                height: customHeight * 0.26,
                child: ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(
                                left: 0, top: 5, bottom: 5, right: 5)
                            : const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: customWidth * 0.5,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF272727), width: 2),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  'assets/images/book.PNG',
                                ),
                              ),
                              SizedBox(
                                height: customHeight * 0.01,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'frontier and avax',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: customHeight * 0.01,
                              ),
                              const Text(
                                'how does frontier contribute to the avalanche ecosystem',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                      fixedSize: Size(customWidth * 0.9, customHeight * 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )),
                  onPressed: () {
                    Get.to(() => const QuizScreen());
                  },
                  child: const Text(
                    'take the frontier quiz',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  )),
              SizedBox(
                height: customHeight * 0.07,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
