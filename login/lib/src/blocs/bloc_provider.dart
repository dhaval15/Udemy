import 'package:flutter/material.dart';
import 'bloc.dart';

class BlocProvider extends InheritedWidget {
  final bloc = Bloc();
  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  static Bloc of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<BlocProvider>().bloc;

  @override
  updateShouldNotify(BlocProvider oldWidget) {
    return true;
  }
}
