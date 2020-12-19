import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social/src/models/user_model.dart';

import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PageController _postController;
  PageController _favouriteController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _postController = PageController(initialPage: 0, viewportFraction: 0.8);
    _favouriteController =
        PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: ProfileClipper(),
                  child: Image.asset(
                    widget.user.backgroundImageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 20,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        widget.user.profileImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                widget.user.name,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Following',
                      style: TextStyle(color: Colors.black87, fontSize: 22),
                    ),
                    SizedBox(height: 6),
                    Text(
                      widget.user.following.toString(),
                      style: TextStyle(color: Colors.black54, fontSize: 22),
                    ),
                  ],
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  children: [
                    Text(
                      'Followers',
                      style: TextStyle(color: Colors.black87, fontSize: 22),
                    ),
                    SizedBox(height: 6),
                    Text(
                      widget.user.followers.toString(),
                      style: TextStyle(color: Colors.black54, fontSize: 22),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            PostCarasoul(
              posts: widget.user.posts,
              pageController: _postController,
              title: 'Your Posts',
            ),
            SizedBox(height: 10),
            PostCarasoul(
              posts: widget.user.favorites,
              pageController: _favouriteController,
              title: 'Favourites',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0.8 * size.height);
    Offset curvePoint1 = Offset(size.width / 2, size.height);
    Offset endPont = Offset(size.width, 0.8 * size.height);
    path.quadraticBezierTo(
        curvePoint1.dx, curvePoint1.dy, endPont.dx, endPont.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
