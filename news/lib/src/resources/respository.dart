import 'dart:async';

import '../models/item_model.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository with Source {
  final List<Source> sources = [
    // NewsDbProvider.instance,
    NewsApiProvider(),
  ];
  final List<Cache> caches = [
    // NewsDbProvider.instance,
  ];

  @override
  Future<List<int>> fetchIds() async {
    for (Source source in sources) {
      List<int> ids = await source.fetchIds();
      if (ids != null) return ids;
    }
    return null;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    var source;
    ItemModel item;
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }
    for (Cache cache in caches) {
      if (source != cache) cache.addItem(item);
    }
    return item;
  }

  purgeItems() async {
    for (Cache cache in caches) {
      cache.purgeItems();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> purgeItems();
}
