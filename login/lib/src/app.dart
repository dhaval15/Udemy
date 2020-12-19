import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'blocs/bloc_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        child: LoginScreen(),
      ),
    );
  }
}
