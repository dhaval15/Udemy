import 'package:flutter/material.dart';
import '../src/models/item_model.dart';
import 'blocs/provider.dart';
import 'screens/stories_screen.dart';
import 'screens/comments_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }

  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/')
      return MaterialPageRoute(builder: (context) {
        final bloc = StoriesProvider.of(context);
        bloc.fetchTopIds();
        return StoriesScreen();
      });
    else if (settings.name == '/comments')
      return MaterialPageRoute(builder: (context) {
        final ItemModel item = settings.arguments;
        final bloc = CommentsProvider.of(context);
        bloc.fetchItem(item.id);
        return CommentsScreen(item: item);
      });
    return null;
  }
}
