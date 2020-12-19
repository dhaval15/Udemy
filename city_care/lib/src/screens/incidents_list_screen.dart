import 'package:provider/provider.dart';

import '../view_models/incident_list_view_model.dart';
import 'package:flutter/material.dart';
import '../widgets/incident_tile.dart';

class IncidentsListScreen extends StatefulWidget {
  @override
  _IncidentsListScreenState createState() => _IncidentsListScreenState();
}

class _IncidentsListScreenState extends State<IncidentsListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<IncidentListViewModel>(context, listen: false)
        .getAllIncidents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/report');
        },
      ),
    );
  }

  Widget buildList() {
    final vm = Provider.of<IncidentListViewModel>(context);
    switch (vm.status) {
      case Status.completed:
        return ListView.builder(
          itemCount: 0,
          itemBuilder: (BuildContext context, int index) {
            return IncidentTile();
          },
        );
      case Status.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
        break;
      case Status.empty:
        return Center(
          child: Text('No Incidents'),
        );
        break;
    }
    return null;
  }
}
