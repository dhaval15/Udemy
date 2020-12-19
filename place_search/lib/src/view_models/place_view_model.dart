import '../models/place_model.dart';

class PlaceViewModel {
  PlaceModel _place;

  PlaceViewModel(this._place);

  String get placeId => _place.placeId;

  String get photoURL => _place.photoURL;

  String get name => _place.name;

  double get latitude => _place.lat;

  double get longitude => _place.lng;
}
