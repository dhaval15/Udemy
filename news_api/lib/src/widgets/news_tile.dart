import 'package:flutter/material.dart';
import '../view_models/news_item_view_model.dart';

class NewsTile extends StatelessWidget {
  final NewsItemViewModel vm;

  const NewsTile({Key key, this.vm}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        child: vm.urlToImage != null
            ? Image.network(
                vm.urlToImage,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'images/news-placeholder.png',
                fit: BoxFit.cover,
              ),
        width: 100,
        height: 100,
      ),
      title: Text(vm.title),
      subtitle: Text(vm.description),
      onTap: () {
        Navigator.of(context).pushNamed('/news', arguments: vm);
      },
    );
  }
}
