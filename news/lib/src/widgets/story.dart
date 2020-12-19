import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Story extends StatelessWidget {
  final ItemModel item;

  const Story({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(
        '${item.score} Votes',
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/comments', arguments: item);
      },
      trailing: Column(
        children: [
          Icon(Icons.comment),
          SizedBox(height: 4),
          Text('${item.descendants}'),
        ],
      ),
    );
  }
}
