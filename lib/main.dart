import 'package:flaq/screens/approval.dart';
import 'package:flaq/screens/flaqPoints.dart';
import 'package:flaq/screens/takeSettings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FalqPoints(),
    );
  }
}
