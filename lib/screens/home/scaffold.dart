import 'package:flaq/screens/explore/explore.screen.dart';
import 'package:flaq/screens/participations/participations.screen.dart';
import 'package:flaq/screens/wallet/wallet.screen.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  @override
  void initState() {
    super.initState();
    Get.find<DataService>().fetchData();
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color(0xff1A1A1A),
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xff9999A5),
        onTap: (i) {
          setState(() {
            selectedIndex = i;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(TablerIcons.home),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(TablerIcons.compass),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(TablerIcons.wallet),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(TablerIcons.world),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (selectedIndex) {
            case 0:
              return const ParticipationScreen();
            case 1:
              return const ExploreScreen();
            case 2:
              return const WalletScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
