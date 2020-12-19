import 'package:news/src/models/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'respository.dart';

class NewsDbProvider implements Source, Cache {
  static final instance = NewsDbProvider();
  Database database;

  NewsDbProvider() {
    init();
  }

  @override
  Future<int> addItem(ItemModel item) {
    return database.insert('Items', item.toMap());
  }

  @override
  Future<List<int>> fetchIds() {
    return null;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final records = await database.query(
      'Items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (records.length > 1) return ItemModel.fromDb(records.first);
    return null;
  }

  init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'items.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (newDatabase, version) async {
        await newDatabase.execute('''
			      CREATE TABLE Items
			      (
   				id INTEGER PRIMERY KEY,
                                deleted INTEGER,
                                type TEXT,
                                by TEXT,
                                time INTEGER,
                                text TEXT,
                                dead INTEGER,
                                parent INTEGER,
                                kids BLOB,
                                url TEXT,
                                score INTEGER,
                                title TEXT,
                                descendants INTEGER
			      )
			      ''');
      },
    );
  }

  @override
  Future<int> purgeItems() {
    return database.delete('Items');
  }
}
