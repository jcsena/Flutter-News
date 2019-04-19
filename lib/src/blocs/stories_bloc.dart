import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Map<int, Future<ItemModel>>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Getters to streams

  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Map<int, Future<ItemModel>>>> get items =>
      _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Map<int, Future<ItemModel>>> cache, int id, int index) {
      cache[id] = {};
      print(id);
      cache[id][0] = _repository.fetchItemCache(id);
      cache[id][1] = _repository.fetchItem(id);
      return cache;
    }, <int, Map<int, Future<ItemModel>>>{});
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
