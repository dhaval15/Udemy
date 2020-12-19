import 'package:flutter/material.dart';
import '../blocs/provider.dart';
import '../models/item_model.dart';
import '../widgets/loading_container.dart';
import '../widgets/story.dart';
import '../widgets/refresh.dart';

class StoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Refresh(
        child: buildBody(bloc),
      ),
    );
  }

  Widget buildBody(StoriesBloc bloc) {
    return StreamBuilder<List<int>>(
      stream: bloc.topIds,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return CircularProgressIndicator();
        else
          return buildStories(bloc, snapshot.data);
      },
    );
  }

  Widget buildStories(StoriesBloc bloc, List<int> ids) {
    return ListView.builder(
      itemCount: ids.length,
      itemBuilder: (context, index) {
        final id = ids[index];
        bloc.fetchItem(id);
        return StoryFetcher(id: id);
      },
    );
  }
}

class StoryFetcher extends StatelessWidget {
  final int id;

  const StoryFetcher({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder<Map<int, Future<ItemModel>>>(
      key: Key('$id'),
      stream: bloc.items,
      builder: (context, itemSnapshot) {
        if (!itemSnapshot.hasData)
          return LoadingContainer();
        else
          return buildStory(itemSnapshot.data[id]);
      },
    );
  }

  Widget buildStory(Future<ItemModel> future) {
    return FutureBuilder<ItemModel>(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LoadingContainer();
        else
          return Story(
            item: snapshot.data,
          );
      },
    );
  }
}
