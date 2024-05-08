import 'package:shop_flutter/common/http_client.dart';
import 'package:shop_flutter/data/cart_item.dart';
import 'package:shop_flutter/data/cart_response.dart';
import 'package:shop_flutter/data/source/cart_data_source.dart';

final cartRepository=CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<CartResponse> add(int productId);
  Future<CartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartItemEntity>> getAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);
  @override
  Future<CartResponse> add(int productId) => dataSource.add(productId);

  @override
  Future<CartResponse> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CartItemEntity>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
