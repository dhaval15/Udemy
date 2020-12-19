import 'dart:convert';

import 'package:http/http.dart' show get;
import '../models/place_model.dart';

const API_KEY = 'AIzaSyAv0xluGVjGLXzHZynzL0HakViNjxPjHLc';

class PlacesApi {
  Future<List<PlaceModel>> fetchPlacesByKeyword(
      String keyword, double latitude, double longitude) async {
    final url = toSearchUrl(keyword, latitude, longitude);

    final response = await get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final Iterable results = jsonResponse["results"];
      return results.map((place) => PlaceModel.fromJson(place)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}

String toPhotoUrl(String photoReferenceId) {
  return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReferenceId&key=$API_KEY';
}

String toSearchUrl(String keyword, double lat, double lng) {
  return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=1500&type=restaurant&keyword=$keyword&key=$API_KEY';
}
