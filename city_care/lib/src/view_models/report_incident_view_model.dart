import '../models/incident_model.dart';
import '../resources/city_care_api.dart';
import 'package:flutter/material.dart';

class ReportIncidentViewModel extends ChangeNotifier {
  String title;
  String description;
  String _imagePath;
  String get imagePath => _imagePath;

  Future<void> saveIncident() async {
    final incident = IncidentModel(
        title: title, description: description, imageURL: imagePath);
    await CityCareApi().postIncident(incident);
    notifyListeners();
  }

  set imagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }
}
