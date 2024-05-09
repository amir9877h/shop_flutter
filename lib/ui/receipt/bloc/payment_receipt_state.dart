part of 'payment_receipt_bloc.dart';

sealed class PaymentReceiptState extends Equatable {
  const PaymentReceiptState();

  @override
  List<Object> get props => [];
}

final class PaymentReceiptLoading extends PaymentReceiptState {}

final class PaymentReceiptSuccess extends PaymentReceiptState {
  final PaymentReceiptData data;

  const PaymentReceiptSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

final class PaymentReceiptError extends PaymentReceiptState {
  final AppException exception;

  const PaymentReceiptError({required this.exception});

  @override
  List<Object> get props => [exception];
}
