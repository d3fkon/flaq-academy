import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

// A simple service to handle the home scaffold navigation
class ScaffoldService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    debugPrint("Initialized ScaffoldService");
  }

  final Rx<int> _scaffoldIndex = Rx(0);
  int get index => _scaffoldIndex.value;
  Rx<int> get scaffoldIndex => _scaffoldIndex;

  // Set the scaffold index
  setIndex(int index) {
    _scaffoldIndex(index);
  }
}
