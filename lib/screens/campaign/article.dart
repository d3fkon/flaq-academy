import 'package:flaq/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  final String link;
  const ArticleScreen({Key? key, required this.link}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: widget.link,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child:
      // child: Padding(
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: 20,
      //   ),
      //   child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         verticalSpace(customHeight * 0.05),
      //         InkWell(
      //           onTap: () {
      //             Get.back();
      //           },
      //           child: customIcon(
      //             Icons.arrow_back_outlined,
      //             Colors.white,
      //           ),
      //         ),
      //         verticalSpace(customHeight * 0.03),
      //         Container(
      //           padding: const EdgeInsets.symmetric(horizontal: 15),
      //           decoration: BoxDecoration(
      //             color: const Color(0xFF131212),
      //             border:
      //                 Border.all(color: const Color(0xFF272727), width: 2),
      //           ),
      //           child: Column(
      //             children: [
      //               verticalSpace(customHeight * 0.03),
      //               Align(
      //                 alignment: Alignment.topLeft,
      //                 child: text(
      //                   widget.title,
      //                   FontWeight.w400,
      //                   22,
      //                   Colors.white,
      //                 ),
      //               ),
      //               verticalSpace(customHeight * 0.03),
      //               Align(
      //                 alignment: Alignment.topLeft,
      //                 child: SizedBox(
      //                   child: text(
      //                     widget.content,
      //                     FontWeight.w500,
      //                     16,
      //                     const Color(0xFFB9B9B9),
      //                   ),
      //                 ),
      //               ),
      //               verticalSpace(customHeight * 0.05),
      //             ],
      //           ),
      //         ),
      //       ]),
      // ),
      // ),
      // ),
    );
  }
}
