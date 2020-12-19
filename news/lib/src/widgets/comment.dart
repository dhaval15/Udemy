import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/provider.dart';
import '../widgets/loading_container.dart';

class Comment extends StatelessWidget {
  final int id;
  final int depth;

  const Comment({Key key, this.id, this.depth = 1}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return StreamBuilder<Map<int, Future<ItemModel>>>(
      stream: bloc.items,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LoadingContainer();
        else
          return FutureBuilder<ItemModel>(
            future: snapshot.data[id],
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return LoadingContainer();
              else
                return buildComment(snapshot.data);
            },
          );
      },
    );
  }

  Widget buildComment(ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.text.replaceAll('&#x27;', '\'') ?? ''),
          subtitle: Text(item.dead || item.deleted ? '' : item.by),
          contentPadding: EdgeInsets.only(right: 16, left: depth * 16.0),
        ),
        Divider(),
        for (int id in item.kids)
          Comment(
            id: id,
            depth: depth + 1,
          ),
      ],
    );
  }
}
