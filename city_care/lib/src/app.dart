import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/incidents_list_screen.dart';
import 'screens/report_incident_screen.dart';
import 'view_models/report_incident_view_model.dart';
import 'view_models/incident_list_view_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IncidentListViewModel>(
      create: (context) => IncidentListViewModel(),
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
      return MaterialPageRoute(builder: (context) => IncidentsListScreen());
    if (settings.name == '/report')
      return MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => ChangeNotifierProvider<ReportIncidentViewModel>(
          create: (context) => ReportIncidentViewModel(),
          child: ReportIncidentScreen(),
        ),
      );
    return null;
  }
}
