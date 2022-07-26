import 'package:flaq/screens/bounties/bounties.dart';
import 'package:flaq/screens/wallet/wallet.screen.dart';
import 'package:flaq/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

List<Widget> tabs = const [
  WalletScreen(),
  BountiesScreen(),
];

class DashBoard extends StatefulWidget {
  final tab;
  const DashBoard({Key? key, required this.tab}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _bottomTab = 0;
  int pageIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.tab, keepPage: true);
    _bottomTab = widget.tab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: tabs[_bottomTab],
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(size: 30),
        elevation: 0,
        currentIndex: _bottomTab,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        iconSize: 30.0,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: _bottomTab == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 7),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          TablerIcons.home,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Icon(
                        TablerIcons.home,
                        color: Colors.grey,
                      ),
                    )),
          BottomNavigationBarItem(
              label: 'Wallet',
              icon: _bottomTab == 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 7),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          TablerIcons.wallet,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Icon(
                        TablerIcons.wallet,
                        color: Colors.grey,
                      ),
                    )),
          BottomNavigationBarItem(
              label: 'Bounties',
              icon: _bottomTab == 2
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 7),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          TablerIcons.briefcase,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(
                        TablerIcons.briefcase,
                        color: Colors.grey,
                      ),
                    )),
        ],
        onTap: (i) {
          if (i == 2) {
            Helper.toast('coming soon');
          } else {
            setState(() {
              _bottomTab = i;
              pageIndex = i;

              _pageController.jumpToPage(i);
            });
          }
        },
      ),
    );
  }
}
