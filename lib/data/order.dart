import 'package:shop_flutter/data/product.dart';

class CreateOrderResult {
  final int orderId;
  final String bankGatewayUrl;

  CreateOrderResult({required this.orderId, required this.bankGatewayUrl});

  CreateOrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGatewayUrl = json['bank_gateway_url'];
}

class CreateOrderParameters {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final PaymentMethod paymentMethod;

  CreateOrderParameters(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.postalCode,
      required this.address,
      required this.paymentMethod});
}

enum PaymentMethod {
  online,
  cashOnDelivery,
}

class OrderEntity {
  final int orderId;
  final int payablePrice;
  final List<ProductEntity> products;

  OrderEntity(
      {required this.orderId,
      required this.payablePrice,
      required this.products});

  OrderEntity.fromJson(Map<String, dynamic> json)
      : orderId = json['id'],
        payablePrice = json['payable'],
        products = (json['order_items'] as List)
            .map((e) => ProductEntity.fromJson(e['product']))
            .toList();
}
