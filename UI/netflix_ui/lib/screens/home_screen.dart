import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/data/data.dart';
import '../widgets/widgets.dart';

double _scrollOffset = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen(Key key) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = controller.offset;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50),
        child: CustomAppBar(
          scrollOffset: _scrollOffset,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        onPressed: () {},
        child: Icon(Icons.cast),
      ),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: Previews(
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(title: 'My list', contentList: myList),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              title: 'Netflix Originals ',
              contentList: originals,
              originals: true,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                title: 'Trending',
                contentList: trending,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
