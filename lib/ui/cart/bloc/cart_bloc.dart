import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_flutter/common/exceptions.dart';
import 'package:shop_flutter/data/auth_info.dart';
import 'package:shop_flutter/data/cart_response.dart';
import 'package:shop_flutter/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc({required this.cartRepository}) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        final authInfo = event.authInfo;
        if (authInfo == null || authInfo.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          await loadCartItems(emit, event.isRefreshing);
        }
      } else if (event is CartDeleteButtonClicked) {
        try {
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            final index = successState.cartResponse.cartItems
                .indexWhere((element) => element.id == event.cartItemId);
            successState.cartResponse.cartItems[index].deleteButtonLoading =
                true;
            emit(CartSuccess(cartResponse: successState.cartResponse));
          }
          await Future.delayed(const Duration(seconds: 2));
          await cartRepository.delete(event.cartItemId);
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            successState.cartResponse.cartItems
                .removeWhere((element) => element.id == event.cartItemId);
            if (successState.cartResponse.cartItems.isEmpty) {
              emit(CartEmpty());
            } else {
              emit(calculatePriceInfo(successState.cartResponse));
            }
          }
        } catch (e) {
          emit(CartError(exception: AppException()));
        }
      } else if (event is CartAuthInfoChanged) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            await loadCartItems(emit, false);
          }
        }
      }
    });
  }
  Future<void> loadCartItems(Emitter<CartState> emit, bool isRefreshing) async {
    try {
      if (!isRefreshing) {
        emit(CartLoading());
      }
      final result = await cartRepository.getAll();
      if (result.cartItems.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartSuccess(cartResponse: result));
      }
    } catch (e) {
      emit(CartError(exception: AppException()));
    }
  }

  CartSuccess calculatePriceInfo(CartResponse cartResponse) {
    int totalPrice = 0;
    int payablePrice = 0;
    int shippingCost = 0;

    for (var element in cartResponse.cartItems) {
      totalPrice += element.product.previousPrice * element.count;
      payablePrice += element.product.price * element.count;
    }
    shippingCost = payablePrice >= 250000 ? 0 : 85000;

    cartResponse.payablePrice = payablePrice;
    cartResponse.totalPrice = totalPrice;
    cartResponse.shippingCost = shippingCost;
    return CartSuccess(cartResponse: cartResponse);
  }
}
