import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home_screen.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.ondemand_video,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    Icons.menu,
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: screens.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: Size(size.width, 100),
                child: CustomAppBar(
                  currentUser: currentUser,
                  icons: icons,
                  selectedIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() {
                      this._selectedIndex = index;
                    });
                  },
                ),
              )
            : null,
        body: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
        bottomNavigationBar: Responsive.isDesktop(context)
            ? SizedBox.shrink()
            : CustomTabBar(
                icons: icons,
                selectedIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    this._selectedIndex = index;
                  });
                },
              ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;

  const CustomTabBar(
      {Key key,
      this.icons,
      this.selectedIndex,
      this.onTap,
      this.isBottomIndicator = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: isBottomIndicator
            ? Border(
                bottom: BorderSide(
                  color: Palette.facebookBlue,
                  width: 3,
                ),
              )
            : Border(
                top: BorderSide(
                  color: Palette.facebookBlue,
                  width: 3,
                ),
              ),
      ),
      onTap: onTap,
      tabs: icons
          .asMap()
          .map((i, icon) => MapEntry(
              i,
              Icon(
                icon,
                color:
                    i == selectedIndex ? Palette.facebookBlue : Colors.black54,
              )))
          .values
          .toList(),
    );
  }
}
