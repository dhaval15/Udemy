import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel({
    this.id,
    this.deleted,
    this.type,
    this.by,
    this.time,
    this.text,
    this.dead,
    this.parent,
    this.kids,
    this.url,
    this.score,
    this.title,
    this.descendants,
  });

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deleted = json['deleted'] ?? false,
        type = json['type'],
        by = json['by'],
        time = json['time'],
        text = json['text'],
        dead = json['dead'] ?? false,
        parent = json['parent'],
        kids = json['kids'] ?? [],
        url = json['url'],
        score = json['score'],
        title = json['title'],
        descendants = json['descendants'];

  ItemModel.fromDb(Map<String, dynamic> json)
      : id = json['id'],
        deleted = json['deleted'] == 1,
        type = json['type'],
        by = json['by'],
        time = json['time'],
        text = json['text'],
        dead = json['dead'] == 1,
        parent = json['parent'],
        kids = jsonDecode(json['kids']),
        url = json['url'],
        score = json['score'],
        title = json['title'],
        descendants = json['descendants'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'deleted': deleted ? 1 : 0,
        'type': type,
        'by': by,
        'time': time,
        'text': text,
        'dead': dead ? 1 : 0,
        'parent': parent,
        'kids': jsonEncode(kids),
        'url': url,
        'score': score,
        'title': title,
        'descendants': descendants,
      };

  Map<String, dynamic> toJson() => {
        'id': id,
        'deleted': deleted,
        'type': type,
        'by': by,
        'time': time,
        'text': text,
        'dead': dead,
        'parent': parent,
        'kids': kids,
        'url': url,
        'score': score,
        'title': title,
        'descendants': descendants,
      };
}
