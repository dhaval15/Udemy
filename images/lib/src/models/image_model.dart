class ImageModel {
  final int id;
  final String title;
  final String url;

  ImageModel({
    this.id,
    this.title,
    this.url,
  });

  ImageModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        url = json['url'];
}
