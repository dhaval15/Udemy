import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';

void main() {
  test('NewsProvider.fetchIds', () async {
    final newsApiProvider = NewsApiProvider();
    newsApiProvider.client = MockClient((request) async {
      return Response(jsonEncode([0, 1, 2, 3]), 200);
    });
    final ids = await newsApiProvider.fetchIds();
    expect(ids, [0, 1, 2, 3]);
  });

  test('NewsProvider.fetchItem', () async {
    final newsApiProvider = NewsApiProvider();
    final map = {
      "by": "dhouston",
      "descendants": 71,
      "id": 400,
      "kids": [9224],
      "score": 104,
      "time": 1175714200,
      "title": "My YC app: Dropbox - Throw away your USB drive",
      "type": "story",
      "url": "http://www.getdropbox.com/u/2/screencast.html"
    };
    newsApiProvider.client = MockClient((request) async {
      return Response(jsonEncode(map), 200);
    });
    final item = await newsApiProvider.fetchItem(45);
    expect(rip(item.toJson()), map);
  });
}

rip(Map map) => map..removeWhere((_, value) => value == null);
