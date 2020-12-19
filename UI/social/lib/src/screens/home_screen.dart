import 'package:flutter/material.dart';
import 'package:social/src/data/data.dart';
import 'package:social/src/models/post_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Frenzy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
            color: Theme.of(context).primaryColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 3,
          labelColor: Theme.of(context).primaryColor,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          tabs: [
            Tab(text: 'Trending'),
            Tab(text: 'Latest'),
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Text(
                  'Following',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = users[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                            image: AssetImage(user.profileImageUrl),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1, color: Colors.blue),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          PostCarasoul(
            pageController: _pageController,
            title: 'Posts',
            posts: posts,
          ),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                currentUser.backgroundImageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
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
                          currentUser.profileImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      currentUser.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          buildOption(Icons.dashboard, 'Home', () {
            Navigator.of(context).pushReplacementNamed('/home');
          }),
          buildOption(Icons.chat, 'Chat', null),
          buildOption(Icons.location_on, 'Map', null),
          buildOption(Icons.account_circle, 'Profile', () {
            Navigator.of(context)
                .pushReplacementNamed('/home/profile', arguments: currentUser);
          }),
          buildOption(Icons.settings, 'Settings', null),
          Expanded(
            child: SizedBox(),
          ),
          buildOption(Icons.directions_run, 'Logout', () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
        ],
      ),
    );
  }

  buildOption(IconData icon, String title, Function onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

class PostCarasoul extends StatelessWidget {
  final PageController pageController;
  final String title;
  final List<Post> posts;

  const PostCarasoul({Key key, this.pageController, this.title, this.posts})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          height: 400,
          child: PageView.builder(
            controller: pageController,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return buildPost(context, index);
            },
          ),
        )
      ],
    );
  }

  Widget buildPost(BuildContext context, int index) {
    final post = posts[index];
    final child = Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              post.imageUrl,
              width: 300,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(20),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  post.location,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.favorite_outline_sharp,
                      color: Colors.red,
                    ),
                    SizedBox(width: 6),
                    Text(post.likes.toString()),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Icon(
                      Icons.comment,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 6),
                    Text(post.comments.toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.25)).clamp(0, 1);
        }
        return Center(
          child: SizedBox(
            child: child,
            height: Curves.easeInOut.transform(value) * 400,
          ),
        );
      },
      child: child,
    );
  }
}
