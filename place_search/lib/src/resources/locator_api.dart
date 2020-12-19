import 'package:geolocator/geolocator.dart';

class LocatorApi {
  Future<Position> getCurrentLocation() => Geolocator.getCurrentPosition();
}
