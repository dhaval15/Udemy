class PlaceModel {
  final String name;
  final double lat;
  final double lng;
  final String placeId;
  final String photoURL;

  PlaceModel({
    this.name,
    this.lat,
    this.lng,
    this.placeId,
    this.photoURL,
  });

  PlaceModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        lat = json['geomentry']['location']['lat'],
        lng = json['geomentry']['location']['lng'],
        placeId = json['placeId'],
        photoURL = json['photos'].first['photo_reference'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'lat': lat,
        'lng': lng,
        'placeId': placeId,
        'photoURL': photoURL,
      };
}
