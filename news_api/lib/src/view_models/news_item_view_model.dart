import '../models/news_item_model.dart';

class NewsItemViewModel {
  final NewsItemModel _item;

  NewsItemViewModel(this._item);

  String get title => _item.title;
  String get description => _item.description;
  String get url => _item.url;
  String get urlToImage => _item.urlToImage;
}
