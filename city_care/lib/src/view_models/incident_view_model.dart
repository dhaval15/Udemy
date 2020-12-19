import '../models/incident_model.dart';

class IncidentViewModel {
  final IncidentModel _incident;

  IncidentViewModel(this._incident);

  String get title => _incident.title;
  String get description => _incident.description;
  String get imageURL => _incident.imageURL;
}
