import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_flutter/common/exceptions.dart';
import 'package:shop_flutter/data/payment_receipt.dart';
import 'package:shop_flutter/data/repo/order_repository.dart';

part 'payment_receipt_event.dart';
part 'payment_receipt_state.dart';

class PaymentReceiptBloc
    extends Bloc<PaymentReceiptEvent, PaymentReceiptState> {
  final IOrderRepository repository;

  PaymentReceiptBloc({required this.repository})
      : super(PaymentReceiptLoading()) {
    on<PaymentReceiptEvent>((event, emit) async {
      if (event is PaymentReceiptStarted) {
        // try {
        //   emit(PaymentReceiptLoading());
        //   final result = await repository.getPaymentReceipt(event.orderId);
        //   emit(PaymentReceiptSuccess(data: result));
        // } catch (e) {
        //   emit(PaymentReceiptError(exception: AppException()));
        // }
        emit(PaymentReceiptLoading());
        await repository.getPaymentReceipt(event.orderId).then((value) {
          emit(PaymentReceiptSuccess(data: value));
        }).catchError((error) {
          emit(PaymentReceiptError(exception: AppException()));
        });
      }
    });
  }
}
