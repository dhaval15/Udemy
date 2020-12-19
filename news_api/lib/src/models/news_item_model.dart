class NewsItemModel {
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  NewsItemModel({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
  });

  NewsItemModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        url = json['url'],
        urlToImage = json['urlToImage'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
      };
}
