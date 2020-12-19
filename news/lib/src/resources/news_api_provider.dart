import 'package:http/http.dart';
import 'respository.dart';
import '../models/item_model.dart';
import 'dart:convert';

const END_POINT = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  @override
  Future<List<int>> fetchIds() async {
    final response = await client.get('$END_POINT/topstories.json');
    return json.decode(response.body).cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$END_POINT/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
