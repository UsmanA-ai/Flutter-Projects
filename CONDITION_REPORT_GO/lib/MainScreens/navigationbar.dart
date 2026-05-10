import 'package:condition_report/MainScreens/actions.dart';
import 'package:condition_report/MainScreens/assesments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int currentPageIndex = 0;
  bool bottomBarVisible = true;

  final List<Widget> _pages = [
    const AssesmentsScreen(),
    const ActionsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromRGBO(253, 253, 253, 1),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 167, 213, 252),
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset("assets/images/home-04.svg"),
            label: ("Home"),
          ),
          NavigationDestination(
            icon: SvgPicture.asset("assets/images/more-horiz.svg"),
            label: ("Actions"),
          ),
        ],
      ),
      body: _pages[currentPageIndex],
    );
  }
}
