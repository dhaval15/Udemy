import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../resources/places_api.dart';
import 'place_view_model.dart';

class PlaceListViewModel extends ChangeNotifier {
  List<PlaceViewModel> places = [];
  MapType mapType = MapType.normal;

  void toggleLayers() {
    this.mapType =
        this.mapType == MapType.normal ? MapType.satellite : MapType.normal;
    notifyListeners();
  }

  Future<void> fetchPlacesByKeywordAndPosition(
      String keyword, double latitude, double longitude) async {
    final results =
        await PlacesApi().fetchPlacesByKeyword(keyword, latitude, longitude);
    places = results.map((place) => PlaceViewModel(place)).toList();
    notifyListeners();
  }
}
