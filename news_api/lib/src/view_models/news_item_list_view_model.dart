import 'package:flutter/widgets.dart';
import 'news_item_view_model.dart';
import '../resources/news_api_provider.dart';

enum Status {
  loading,
  completed,
  empty,
}

class NewsItemListViewModel extends ChangeNotifier {
  Status status = Status.loading;
  List<NewsItemViewModel> items = [];

  void populateItems() async {
    status = Status.loading;
    notifyListeners();
    final news = await NewsApiProvider().fetchNews();
    items = news.map((n) => NewsItemViewModel(n)).toList();
    status = items.length > 0 ? Status.completed : Status.empty;
    notifyListeners();
  }

  void populateItemsWithKeyWord(String text) async {
    status = Status.loading;
    notifyListeners();
    final news = await NewsApiProvider().searchNews(text);
    items = news.map((n) => NewsItemViewModel(n)).toList();
    status = items.length > 0 ? Status.completed : Status.empty;
    notifyListeners();
  }
}
