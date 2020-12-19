import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import '../blocs/provider.dart';
import '../widgets/comment.dart';

class CommentsScreen extends StatelessWidget {
  final ItemModel item;

  const CommentsScreen({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Story'),
      ),
      body: SafeArea(
        child: buildBody(bloc),
      ),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return ListView(
      children: [
        buildTitle(item),
        for (int id in item.kids)
          Comment(
            id: id,
          ),
      ],
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
