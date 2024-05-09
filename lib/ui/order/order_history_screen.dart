import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/repo/order_repository.dart';
import 'package:shop_flutter/ui/order/bloc/order_history_bloc.dart';
import 'package:shop_flutter/ui/widgets/image.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderHistoryBloc>(
      create: (context) => OrderHistoryBloc(repository: orderRepository)
        ..add(OrderHistoryStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سوابق سفارش'),
        ),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistorySuccess) {
              final orders = state.orders;
              return ListView.builder(
                physics: defaultscrollphysics,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 0.1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('شناسه سفارش'),
                              Text(order.orderId.toString()),
                            ],
                          ),
                          const Divider(
                            thickness: 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('مبلغ'),
                              Text(order.payablePrice.toString()),
                            ],
                          ),
                          const Divider(
                            thickness: 0.05,
                          ),
                          SizedBox(
                            height: 132,
                            child: ListView.builder(
                              physics: defaultscrollphysics,
                              scrollDirection: Axis.horizontal,
                              itemCount: order.products.length,
                              itemBuilder: (context, index) {
                                final products = order.products;
                                return Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 100,
                                  width: 100,
                                  child: ImageLoadingService(
                                    imageUrl: products[index].imageUrl,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is OrderHistoryError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is OrderHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              throw 'invalid state';
            }
          },
        ),
      ),
    );
  }
}
