import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/assets.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({Key key, this.scrollOffset = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: Responsive(
        mobile: MobileAppBar(),
        desktop: DesktopAppBar(),
      ),
    );
  }
}

class MobileAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppBarButton(title: 'Tv Shows'),
                AppBarButton(title: 'Movies'),
                AppBarButton(title: 'My List'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DesktopAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppBarButton(title: 'Home'),
                AppBarButton(title: 'Tv Shows'),
                AppBarButton(title: 'Movies'),
                AppBarButton(title: 'Latest'),
                AppBarButton(title: 'My List'),
              ],
            ),
          ),
          Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  iconSize: 20,
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                AppBarButton(title: 'KIDS'),
                AppBarButton(title: 'DVD'),
                IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  iconSize: 20,
                  icon: Icon(Icons.card_giftcard),
                  onPressed: () {},
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  iconSize: 20,
                  icon: Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final String title;

  const AppBarButton({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onTap: () {},
    );
  }
}
