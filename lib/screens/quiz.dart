import 'package:flaq/utils/radioListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  late PageController _controller;
  final ItemScrollController _scrollController = ItemScrollController();
  int count = 0;
  String? _value;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF0E0C0E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: customHeight * 0.07,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
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
                            width: customWidth * 0.025,
                          ),
                          const Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'frontier ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFFa76237),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                ),
                              ),
                              TextSpan(
                                text: 'quiz?',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: customHeight * 0.015,
                      ),
                      SizedBox(
                        width: customWidth * 0.7,
                        child: const Text(
                          'score more than 90% in order to claim your frontier reward tokens',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFFB9B9B9),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  width: customWidth,
                  height: customHeight,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: customHeight * 0.025,
                      ),
                      Container(
                        color: Colors.black,
                        width: customWidth * 0.12,
                        height: customHeight * 0.007,
                      ),
                      SizedBox(
                        width: customWidth,
                        height: customHeight * 0.1,
                        child: ScrollablePositionedList.builder(
                          itemScrollController: _scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          itemBuilder: (context, index) {
                            return buildDot(index, context);
                          },
                          itemCount: 10,
                        ),
                      ),
                      Expanded(
                        child: PageView.builder(
                          controller: _controller,
                          itemCount: 10,
                          onPageChanged: (int index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          itemBuilder: (_, i) {
                            return Column(children: [
                              SizedBox(height: customHeight * 0.03),
                              const Text(
                                'which exchange/exchanges is frontier on ?',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height: customHeight * 0.02,
                              ),
                              MyRadioListTile<String?>(
                                value: 'frontier is on binance',
                                groupValue: _value,
                                leading: 'A',
                                title: Text(
                                  'frontier is on binance',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: _value == 'frontier is on binance'
                                        ? Colors.black
                                        : const Color(0xFF9999A5),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                onChanged: (value) =>
                                    setState(() => _value = value!),
                              ),
                              MyRadioListTile<String?>(
                                value: 'frontier is on binance & coinbase',
                                groupValue: _value,
                                leading: 'B',
                                title: Text(
                                  'frontier is on binance & coinbase',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: _value ==
                                            'frontier is on binance & coinbase'
                                        ? Colors.black
                                        : const Color(0xFF9999A5),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                onChanged: (value) =>
                                    setState(() => _value = value!),
                              ),
                              MyRadioListTile<String?>(
                                value: 'frontier is on gate.io & huobi global',
                                groupValue: _value,
                                leading: 'C',
                                title: Text(
                                  'frontier is on gate.io & huobi global',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: _value ==
                                            'frontier is on gate.io & huobi global'
                                        ? Colors.black
                                        : const Color(0xFF9999A5),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                onChanged: (value) =>
                                    setState(() => _value = value!),
                              ),
                              MyRadioListTile<String?>(
                                value: 'frontier is on kucoin & kraken',
                                groupValue: _value,
                                leading: 'D',
                                title: Text(
                                  'frontier is on kucoin & kraken',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: _value ==
                                            'frontier is on kucoin & kraken'
                                        ? Colors.black
                                        : const Color(0xFF9999A5),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                onChanged: (value) =>
                                    setState(() => _value = value!),
                              ),
                            ]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: customHeight * 0.125,
          child: currentIndex == 0
              ? Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex++;
                        if (currentIndex > 10) {
                          currentIndex = 9;
                        }
                        _controller.jumpToPage(currentIndex);
                      });
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : currentIndex == 9
                  ? Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex--;
                              if (currentIndex < 0) {
                                currentIndex = 0;
                              }
                              _controller.jumpToPage(currentIndex);
                              _scrollController.scrollTo(
                                  index: currentIndex,
                                  duration: const Duration(seconds: 1));
                            });
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: customWidth * 0.05,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                elevation: 0,
                                fixedSize: Size(
                                    customWidth * 0.68, customHeight * 0.07),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )),
                            onPressed: () {},
                            child: const Text(
                              'next',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            )),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex--;
                              if (currentIndex < 0) {
                                currentIndex = 0;
                              }
                              _controller.jumpToPage(currentIndex);
                              _scrollController.scrollTo(
                                  index: currentIndex,
                                  duration: const Duration(seconds: 1));
                            });
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex++;
                              if (currentIndex > 10) {
                                currentIndex = 9;
                              }
                              _controller.jumpToPage(currentIndex);
                              _scrollController.scrollTo(
                                  index: currentIndex,
                                  duration: const Duration(seconds: 1));
                            });
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
        elevation: 0,
      ),
    );
  }

  buildDot(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
          _controller.jumpToPage(currentIndex);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.13,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: index == currentIndex
                  ? Colors.black
                  : const Color(0xFFD4D4D4),
            ),
          ),
        ),
        child: CircleAvatar(
            backgroundColor:
                index == currentIndex ? Colors.black : const Color(0xFFD4D4D4),
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            )),
      ),
    );
  }
}
