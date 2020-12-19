import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }

  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/')
      return MaterialPageRoute(builder: (context) => LoginScreen());
    if (settings.name == '/home')
      return MaterialPageRoute(builder: (context) => HomeScreen());
    if (settings.name == '/home/profile')
      return MaterialPageRoute(
          builder: (context) => ProfileScreen(
                user: settings.arguments,
              ));
    return null;
  }
}
