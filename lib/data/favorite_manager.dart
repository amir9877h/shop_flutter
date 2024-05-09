import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_flutter/data/product.dart';

final favoriteManager = FavoriteManager();

class FavoriteManager {
  static const String _boxName = 'favorites';
  final _box = Hive.box<ProductEntity>(_boxName);
  ValueListenable<Box<ProductEntity>> get listenable => Hive.box<ProductEntity>(_boxName).listenable();

  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductEntityAdapter());
    Hive.openBox<ProductEntity>(_boxName);
  }

  void addToFavorites(ProductEntity product) {
    _box.put(product.id, product);
  }

  void removeFromFavorites(int productId) {
    _box.delete(productId);
  }

  List<ProductEntity> get favorites => _box.values.toList();

  bool isInFavorites(int productId) {
    return _box.containsKey(productId);
  }
}
