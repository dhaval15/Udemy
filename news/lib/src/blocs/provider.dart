import 'package:flutter/material.dart';

import 'stories_bloc.dart';
import 'comments_bloc.dart';
export 'stories_bloc.dart';
export 'comments_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final bloc = StoriesBloc();
  StoriesProvider({Key key, Widget child}) : super(key: key, child: child);

  static StoriesBloc of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<StoriesProvider>().bloc;

  @override
  updateShouldNotify(StoriesProvider oldWidget) {
    return true;
  }
}

class CommentsProvider extends InheritedWidget {
  final bloc = CommentsBloc();
  CommentsProvider({Key key, Widget child}) : super(key: key, child: child);

  static CommentsBloc of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CommentsProvider>().bloc;

  @override
  updateShouldNotify(StoriesProvider oldWidget) {
    return true;
  }
}
