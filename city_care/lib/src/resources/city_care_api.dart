import 'dart:io';

import '../models/incident_model.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

const END_POINT = 'https://vast-savannah-75068.herokuapp.com/incidents';

class CityCareApi {
  Future<List<IncidentModel>> fetchIncidents() async {
    final response = await Dio().get(END_POINT);
    if (response.statusCode == 200) {
      List json = response.data;
      return json.map((incident) => IncidentModel.fromJson(incident)).toList();
    } else {
      throw Exception('Unable to fetch incidents');
    }
  }

  Future postIncident(IncidentModel incident) async {
    File file = File(incident.imageURL);
    final filename = basename(file.path.replaceAll('', ''));

    FormData data = FormData.fromMap({
      "title": incident.title,
      "description": incident.description,
      "image":
          await MultipartFile.fromFile(incident.imageURL, filename: filename)
    });

    await Dio().post(END_POINT, data: data);
  }
}
