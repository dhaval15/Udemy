import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/category_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: Colors.green,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/',
    );
  }

  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/')
      return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
    if (settings.name == '/category')
      return MaterialPageRoute(
          builder: (BuildContext context) => CategoryScreen(
                category: settings.arguments,
              ));

    return null;
  }
}
