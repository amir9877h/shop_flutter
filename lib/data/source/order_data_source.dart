import 'package:dio/dio.dart';
import 'package:shop_flutter/data/order.dart';

abstract class IOrderDataSource {
  Future<CreateOrderResult> createOrder(CreateOrderParameters parameters);
}

class OrderRemoteDataSource implements IOrderDataSource {
  final Dio httpClient;

  OrderRemoteDataSource({required this.httpClient});

  @override
  Future<CreateOrderResult> createOrder(
      CreateOrderParameters parameters) async {
    final response = await httpClient.post('order/submit', data: {
      "first_name": parameters.firstName,
      "last_name": parameters.lastName,
      "mobile": parameters.phoneNumber,
      "postal_code": parameters.postalCode,
      "address": parameters.address,
      "payment_method": parameters.paymentMethod == PaymentMethod.online
          ? 'online'
          : 'cash_on_delivery'
    });

    return CreateOrderResult.fromJson(response.data);
  }
}
