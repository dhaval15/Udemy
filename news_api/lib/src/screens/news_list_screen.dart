import 'package:flutter/material.dart';
import 'package:news_api/src/view_models/news_item_list_view_model.dart';
import 'package:news_api/src/widgets/news_tile.dart';
import 'package:provider/provider.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<NewsItemListViewModel>(context, listen: false).populateItems();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewsItemListViewModel>(context);
    return Scaffold(
      body: Column(
        children: [
          buildSearchField(vm),
          buildList(vm),
        ],
      ),
    );
  }

  Widget buildList(NewsItemListViewModel vm) {
    switch (vm.status) {
      case Status.completed:
        return Expanded(
          child: ListView.builder(
            itemCount: vm.items.length,
            itemBuilder: (BuildContext context, int index) => NewsTile(
              vm: vm.items[index],
            ),
          ),
        );
      case Status.empty:
        return Center(
          child: Text('No results'),
        );
      case Status.loading:
        return Center(child: CircularProgressIndicator());
    }
    return Text('');
  }

  Widget buildSearchField(NewsItemListViewModel vm) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(8),
        child: TextField(
          controller: controller,
          onSubmitted: (text) {
            if (text.isNotEmpty) vm.populateItemsWithKeyWord(controller.text);
          },
          decoration: InputDecoration(
              filled: true,
              labelText: 'Search',
              hintText: 'Search',
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                },
              )),
        ),
      ),
    );
  }

  buildBody() {}
}
