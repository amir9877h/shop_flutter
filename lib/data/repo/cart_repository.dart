import 'package:shop_flutter/common/http_client.dart';
import 'package:shop_flutter/data/add_to_cart_response.dart';
import 'package:shop_flutter/data/cart_response.dart';
import 'package:shop_flutter/data/source/cart_data_source.dart';

final cartRepository = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<AddToCartResponse> add(int productId);
  Future<AddToCartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);
  @override
  Future<AddToCartResponse> add(int productId) => dataSource.add(productId);

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) {
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
  Future<CartResponse> getAll() => dataSource.getAll();
}
