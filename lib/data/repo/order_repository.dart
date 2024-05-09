import 'package:shop_flutter/common/http_client.dart';
import 'package:shop_flutter/data/order.dart';
import 'package:shop_flutter/data/payment_receipt.dart';
import 'package:shop_flutter/data/source/order_data_source.dart';

final orderRepository =
    OrderRepository(dataSource: OrderRemoteDataSource(httpClient: httpClient));

abstract class IOrderRepository {
  Future<CreateOrderResult> createOrder(CreateOrderParameters parameters);
  Future<PaymentReceiptData> getPaymentReceipt(int orderId);
}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource dataSource;

  OrderRepository({required this.dataSource});

  @override
  Future<CreateOrderResult> createOrder(CreateOrderParameters parameters) {
    return dataSource.createOrder(parameters);
  }
  
  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) {
    return dataSource.getPaymentReceipt(orderId);
  }
}
