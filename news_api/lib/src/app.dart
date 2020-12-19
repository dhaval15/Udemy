import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/news_list_screen.dart';
import 'screens/news_screen.dart';
import 'view_models/news_item_list_view_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsItemListViewModel>(
      create: (BuildContext context) => NewsItemListViewModel(),
      child: MaterialApp(
        title: 'App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }

  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/')
      return MaterialPageRoute(
        builder: (context) => NewsListScreen(),
      );
    if (settings.name == '/news')
      return MaterialPageRoute(
          builder: (context) => NewsScreen(
                model: settings.arguments,
              ));
    return null;
  }
}
