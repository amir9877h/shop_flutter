import 'package:shop_flutter/data/product.dart';

class CartItemEntity {
  final ProductEntity product;
  final int id;
  final int count;

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json['product']),
        id = json['cart_item_id'],
        count = json['count'];

  static List<CartItemEntity> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItemEntity> cartItems = [];
    for (var element in jsonArray) {
      cartItems.add(CartItemEntity.fromJson(element));
    }
    return cartItems;
  }
}
