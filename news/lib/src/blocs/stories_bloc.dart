import 'dart:async';
import '../models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/respository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsFetcher = PublishSubject<int>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchIds();
    _topIds.add(ids);
  }

  StoriesBloc() {
    _itemsFetcher.transform(_itemTransformer()).pipe(_itemsOutput);
  }

  _itemTransformer() => ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
          (cache, id, index) {
        if (!cache.containsKey(id)) cache[id] = _repository.fetchItem(id);
        return cache;
      }, {});

  void dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }

  purge() {
    return _repository.purgeItems();
  }
}
