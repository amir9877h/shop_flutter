import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_flutter/common/exceptions.dart';
import 'package:shop_flutter/data/order.dart';
import 'package:shop_flutter/data/repo/order_repository.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final IOrderRepository repository;

  ShippingBloc({required this.repository}) : super(ShippingInitial()) {
    on<ShippingEvent>((event, emit) async {
      if (event is ShippingCreateOrder) {
        try {
          emit(ShippingLoading());
          final result = await repository.createOrder(event.parameters);
          emit(ShippingSuccess(result: result));
        } catch (e) {
          emit(ShippingError(AppException()));
        }
      }
    });
  }
}
