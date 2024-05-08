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
          await loadCartItems(emit);
        }
      } else if (event is CartDeleteButton) {
      } else if (event is CartAuthInfoChanged) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            await loadCartItems(emit);
          }
        }
      }
    });
  }
  Future<void> loadCartItems(Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
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
}
