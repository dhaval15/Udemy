import 'dart:async';
import '../models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/respository.dart';

class CommentsBloc {
  final _repository = Repository();
  final _itemsFetcher = PublishSubject<int>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  CommentsBloc() {
    _itemsFetcher.transform(_itemTransformer()).pipe(_itemsOutput);
  }

  _itemTransformer() => ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
          (cache, id, index) {
        if (!cache.containsKey(id)) {
          final itemFuture = _repository.fetchItem(id);
          cache[id] = itemFuture;
          itemFuture.then((item) {
            item.kids.forEach(fetchItem);
          });
        }
        return cache;
      }, {});

  void dispose() {
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
