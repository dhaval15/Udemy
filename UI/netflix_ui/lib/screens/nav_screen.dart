import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

import 'home_screen.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final screens = [
    HomeScreen(PageStorageKey('home_screen')),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  final icons = {
    'Home': Icons.home,
    'Search ': Icons.search,
    'Coming Soon': Icons.queue_play_next,
    'Downloads': Icons.file_download,
    'Menu': Icons.menu,
  };

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Responsive.isDesktop(context)
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              currentIndex: _currentIndex,
              selectedItemColor: Colors.white,
              selectedFontSize: 11,
              unselectedItemColor: Colors.grey,
              unselectedFontSize: 11,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: icons
                  .map((title, icon) => MapEntry(
                      title,
                      BottomNavigationBarItem(
                          label: title,
                          icon: Icon(
                            icon,
                            size: 30,
                          ))))
                  .values
                  .toList(),
            ),
    );
  }
}
