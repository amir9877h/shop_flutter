part of 'cart_bloc.dart';

sealed class CartState {
  const CartState();
}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartResponse cartResponse;

  const CartSuccess({required this.cartResponse});
}

final class CartError extends CartState {
  final AppException exception;

  const CartError({required this.exception});
}

final class CartAuthRequired extends CartState {}

final class CartEmpty extends CartState {}
