import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  // Iterate over sources when dbprovider
  // get fetchTopIds implemented
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    try {
      print('fetch $id');
      item = await sources[1].fetchItem(id);
      caches[0].addItem(item);
      return item;
    } catch (e) {
      return null;
    }
  }

  Future<ItemModel> fetchItemCache(int id) async {
    ItemModel item;
    // print('from cache $id');
    item = await sources[0].fetchItem(id);
    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
