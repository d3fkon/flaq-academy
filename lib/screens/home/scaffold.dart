import 'package:flaq/screens/explore/explore.screen.dart';
import 'package:flaq/screens/home/flaqBank.dart';
import 'package:flaq/screens/participations/participations.screen.dart';
import 'package:flaq/screens/wallet/wallet.screen.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/services/scaffold.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  Widget buildSelectedNavItem(Widget child) {
    return Container(
      height: 32,
      width: 64,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(85),
          right: Radius.circular(85),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: child,
      ),
    );
  }

  int index = 0;
  @override
  void initState() {
    super.initState();
    Get.find<DataService>().fetchData();

    Future.delayed(const Duration(milliseconds: 100), () {
      Get.find<ScaffoldService>().scaffoldIndex.listen((i) {
        if (mounted) {
          setState(() {
            index = i;
          });
        }
      });
    });
  }

  BottomNavigationBarItem buildNavItem(int index, Widget icon) {
    var widget = icon;
    if (Get.find<ScaffoldService>().index == index) {
      widget = buildSelectedNavItem(icon);
    }
    return BottomNavigationBarItem(icon: widget, label: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            enableFeedback: false,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: const Color(0xff1A1A1A),
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            selectedItemColor: Colors.white,
            unselectedItemColor: const Color(0xff9999A5),
            onTap: (i) {
              Get.find<ScaffoldService>().setIndex(i);
            },
            items: [
              buildNavItem(0, const Icon(TablerIcons.home)),
              buildNavItem(1, const Icon(TablerIcons.compass)),
              buildNavItem(2, const Icon(TablerIcons.wallet)),
              buildNavItem(3, const Icon(TablerIcons.comet)),
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          switch (Get.find<ScaffoldService>().index) {
            case 0:
              return const ParticipationScreen();
            case 1:
              return const ExploreScreen();
            case 2:
              return const WalletScreen();
            case 3:
              return const FlaqBankScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
