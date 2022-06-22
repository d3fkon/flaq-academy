import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleScreen extends StatefulWidget {
  final String title;
  final String content;
  const ArticleScreen({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
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
                    height: customHeight * 0.03,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF131212),
                      border:
                          Border.all(color: const Color(0xFF272727), width: 2),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: customHeight * 0.03,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: customHeight * 0.03,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            child: Text(
                              widget.content,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFFB9B9B9),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: customHeight * 0.05,
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
