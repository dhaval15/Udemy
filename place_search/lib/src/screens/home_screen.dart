import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../resources/locator_api.dart';
import '../widgets/places_bottom_sheet.dart';
import '../view_models/place_list_view_model.dart';
import '../view_models/place_view_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  Position _currentLocation;
  GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlaceListViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          buildMap(vm),
          buildSearchField(vm),
          buildLayerButton(vm),
        ],
      ),
      floatingActionButton: buildPlacesButton(vm),
    );
  }

  Widget buildPlacesButton(PlaceListViewModel vm) => Positioned(
        bottom: 20,
        left: 20,
        child: Visibility(
          visible: vm.places.isNotEmpty,
          child: FlatButton(
            child: Text('Places'),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => PlacesBottomSheet(),
              );
            },
          ),
        ),
      );

  Widget buildSearchField(PlaceListViewModel vm) => SafeArea(
        child: TextField(
          controller: _searchController,
          onSubmitted: (text) {
            vm.fetchPlacesByKeywordAndPosition(
                text, _currentLocation.latitude, _currentLocation.longitude);
          },
          decoration: InputDecoration(
            hintText: 'Search',
            fillColor: Colors.white,
          ),
        ),
      );

  Widget buildLayerButton(PlaceListViewModel vm) => Positioned(
        top: 120,
        right: 12,
        child: FloatingActionButton(
          child: Icon(Icons.layers),
          onPressed: vm.toggleLayers,
        ),
      );

  Widget buildMap(PlaceListViewModel vm) => GoogleMap(
        mapType: vm.mapType,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        markers: _getPlaceMarkers(vm.places),
        initialCameraPosition: CameraPosition(
          target: LatLng(24.17, 72.43),
          zoom: 14,
        ),
      );

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    _currentLocation = await LocatorApi().getCurrentLocation();
    _controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      zoom: 14,
      target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
    )));
  }

  Set<Marker> _getPlaceMarkers(List<PlaceViewModel> places) {
    return places.map((place) {
      return Marker(
          markerId: MarkerId(place.placeId),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: place.name),
          position: LatLng(place.latitude, place.longitude));
    }).toSet();
  }
}
