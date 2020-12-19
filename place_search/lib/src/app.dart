import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'view_models/place_list_view_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlaceListViewModel>(
      create: (context) => PlaceListViewModel(),
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
      return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
    return null;
  }
}
