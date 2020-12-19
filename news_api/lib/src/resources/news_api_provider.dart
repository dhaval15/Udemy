import 'package:http/http.dart' show get;
import 'dart:convert';

import '../models/news_item_model.dart';

const END_POINT =
    'https://newsapi.org/v2/top-headlines?country=us&apiKey=84082011d9304f53823e02511b7def1e';

String searchUrl(String keyword) =>
    'https://newsapi.org/v2/everything?q=$keyword&apiKey=84082011d9304f53823e02511b7def1e';

class NewsApiProvider {
  Future<List<NewsItemModel>> fetchNews() async {
    final response = await get(END_POINT);
    if (response.statusCode == 200) {
      Iterable records = jsonDecode(response.body)['articles'];
      return records.map((json) => NewsItemModel.fromJson(json)).toList();
    }
    throw 'Problem Fetching News';
  }

  Future<List<NewsItemModel>> searchNews(String text) async {
    final response = await get(searchUrl(text));
    if (response.statusCode == 200) {
      Iterable records = jsonDecode(response.body)['articles'];
      return records.map((json) => NewsItemModel.fromJson(json)).toList();
    }
    throw 'Problem Fetching News';
  }
}
