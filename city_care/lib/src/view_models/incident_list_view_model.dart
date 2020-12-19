import '../resources/city_care_api.dart';
import 'package:flutter/material.dart';

import 'incident_view_model.dart';

enum Status {
  loading,
  empty,
  completed,
}

class IncidentListViewModel extends ChangeNotifier {
  List<IncidentViewModel> incidents = List<IncidentViewModel>();
  Status status = Status.empty;

  Future<void> getAllIncidents() async {
    status = Status.loading;
    final results = await CityCareApi().fetchIncidents();
    incidents = results.map((incident) => IncidentViewModel(incident)).toList();
    status = incidents.isEmpty ? Status.empty : Status.completed;
    notifyListeners();
  }
}
