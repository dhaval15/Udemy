import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import '../resources/places_api.dart';
import '../view_models/place_view_model.dart';

class PlacesBottomSheet extends StatelessWidget {
  final List<PlaceViewModel> places;

  PlacesBottomSheet({this.places});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.places.length,
      itemBuilder: (context, index) {
        final place = this.places[index];

        return ListTile(
            onTap: () => openMapExternaly(place),
            leading: Container(
                width: 100,
                height: 100,
                child: Image.network(toPhotoUrl(place.photoURL),
                    fit: BoxFit.cover)),
            title: Text(place.name));
      },
    );
  }

  void openMapExternaly(PlaceViewModel place) async {
    if (await MapLauncher.isMapAvailable(MapType.google)) {
      await MapLauncher.showMarker(
          mapType: MapType.google,
          coords: Coords(place.latitude, place.longitude),
          title: place.name,
          description: place.name);
    } else if (await MapLauncher.isMapAvailable(MapType.apple)) {
      await MapLauncher.showMarker(
          mapType: MapType.apple,
          coords: Coords(place.latitude, place.longitude),
          title: place.name,
          description: place.name);
    }
  }
}
