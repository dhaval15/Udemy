import '../view_models/incident_view_model.dart';
import 'package:flutter/material.dart';

class IncidentTile extends StatelessWidget {
  final IncidentViewModel model;

  const IncidentTile({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.title),
      leading: Container(
        child: Image.network(
          model.imageURL,
          fit: BoxFit.cover,
        ),
        width: 100,
        height: 70,
      ),
    );
  }
}
