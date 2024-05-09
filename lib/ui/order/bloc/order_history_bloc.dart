import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_flutter/common/exceptions.dart';
import 'package:shop_flutter/data/order.dart';
import 'package:shop_flutter/data/repo/order_repository.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final IOrderRepository repository;

  OrderHistoryBloc({required this.repository}) : super(OrderHistoryLoading()) {
    on<OrderHistoryEvent>((event, emit) async {
      if (event is OrderHistoryStarted) {
        emit(OrderHistoryLoading());
        await repository.getOrders().then((value) {
          emit(OrderHistorySuccess(orders: value));
        }).catchError((error) {
          emit(OrderHistoryError(exception: AppException()));
        });
      }
    });
  }
}
