import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './diary_page.dart';
import '../screens/main_diary_screen.dart';
import '../screens/settings_screen.dart';

class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {

    int _currentTabIndex = 0;

    _onTapped (int index){
      setState(() {
        _currentTabIndex = index;
      });
    }

    return BottomNavigationBar(
        currentIndex: _currentTabIndex,
        //onTap: _onTapped,
        onTap: (value) {
          if (value == 0)
            Navigator.of(context).pushReplacementNamed(MainDiaryScreen.routeName);
          if (value == 1)
            Navigator.of(context).pushReplacementNamed(DiaryPage.routeName);
          if (value == 2)
            Navigator.of(context).pushNamed(SettingsScreen.routeName);
        },
        items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.house), label: '', activeIcon: Icon(CupertinoIcons.house, color: Colors.black,), tooltip: 'Home'),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.plus_circle, size: 40,), label: '', activeIcon: Icon(CupertinoIcons.plus_circle, color: Colors.black,), tooltip: 'Add Page'),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: '', activeIcon: Icon(CupertinoIcons.settings, color: Colors.black,), tooltip: 'Settings'),
    ]);
  }
}
