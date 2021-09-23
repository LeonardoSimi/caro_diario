import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './diary_page.dart';
import '../screens/main_diary_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/edit_diary_screen.dart';

class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

   final List<Map<String, dynamic>> _pages = [
    {
      'page': MainDiaryScreen(),
      'title': 'Home',
    },
     {
       'page': DiaryPage(),
       'title': 'Add Page',
     },
     {
       'page': EditDiaryScreen(null, null, null, null),
       'title': 'Your Diary'
     },
     {
       'page': SettingsScreen(),
       'title': 'Settings',
     }
  ];

   int _currentTabIndex = 0;

   void _selectPage(int index) {
     setState(() {
       _currentTabIndex = index;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _pages[_currentTabIndex]['page'],
      bottomNavigationBar: Hero(
        tag: 'bottomNavigationBar',
        child: BottomNavigationBar(
            type : BottomNavigationBarType.fixed,
            currentIndex: _currentTabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: _selectPage,
/*          onTap: (value) {
              if (value == 0)
                Navigator.of(context).pushReplacementNamed(MainDiaryScreen.routeName);
              if (value == 1)
                Navigator.of(context).pushReplacementNamed(DiaryPage.routeName);
              if (value == 2)
                Navigator.of(context).pushNamed(SettingsScreen.routeName);

              setState(() {
                _currentTabIndex = value;
              });
            },*/

            items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house), label: 'Home', activeIcon: Icon(CupertinoIcons.house, color: Colors.black,), tooltip: 'Home'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.book,), label: 'Your Diary', activeIcon: Icon(CupertinoIcons.book, color: Colors.black,), tooltip: 'Your Diary'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.pencil,), label: 'Edit Page', activeIcon: Icon(CupertinoIcons.pencil, color: Colors.black,), tooltip: 'Edit Page'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings', activeIcon: Icon(CupertinoIcons.settings, color: Colors.black,), tooltip: 'Settings'),
        ]
        ),
      ),
    );
  }
}
