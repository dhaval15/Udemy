class IncidentModel {
  final String title;
  final String description;
  final String imageURL;

  IncidentModel({
    this.title,
    this.description,
    this.imageURL,
  });

  IncidentModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        imageURL = json['imageURL'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'imageURL': imageURL,
      };
}
