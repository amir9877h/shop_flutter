import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/repo/auth_repository.dart';
import 'package:shop_flutter/data/repo/cart_repository.dart';
import 'package:shop_flutter/ui/auth/auth.dart';
import 'package:shop_flutter/ui/cart/bloc/cart_bloc.dart';
import 'package:shop_flutter/ui/cart/cart_item.dart';
import 'package:shop_flutter/ui/cart/price_info.dart';
import 'package:shop_flutter/ui/widgets/empty_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  StreamSubscription? stateStreamSubscription;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc?.add(
        CartAuthInfoChanged(authInfo: AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc?.close();
    stateStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("سبد خرید"),
      ),
      body: BlocProvider<CartBloc>(
        create: (context) {
          final bloc = CartBloc(cartRepository: cartRepository);
          stateStreamSubscription = bloc.stream.listen((state) {
            if (_refreshController.isRefresh) {
              if (state is CartSuccess) {
                _refreshController.refreshCompleted();
              } else if (state is CartError) {
                _refreshController.refreshFailed();
              }
            }
          });
          cartBloc = bloc;
          bloc.add(
              CartStarted(authInfo: AuthRepository.authChangeNotifier.value));
          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is CartSuccess) {
              return SmartRefresher(
                header: const ClassicHeader(
                  completeText: 'به روز رسانی با موفقیت انجام شد',
                  refreshingText: 'در حال به روزرسانی',
                  idleText: 'برای به روزرسانی پایین بکشید',
                  releaseText: 'رها کنید',
                  failedText: 'بعدا دوباره تلاش کنید',
                  refreshingIcon: CupertinoActivityIndicator(),
                  spacing: 2,
                  refreshStyle: RefreshStyle.Follow,
                ),
                controller: _refreshController,
                onRefresh: () {
                  cartBloc?.add(CartStarted(
                      authInfo: AuthRepository.authChangeNotifier.value,
                      isRefreshing: true));
                },
                child: ListView.builder(
                    physics: defaultscrollphysics,
                    itemCount: state.cartResponse.cartItems.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.cartResponse.cartItems.length) {
                        final data = state.cartResponse.cartItems[index];
                        return CartItem(
                          data: data,
                          onDeleteButtonClicked: () {
                            cartBloc?.add(
                                CartDeleteButtonClicked(cartItemId: data.id));
                          },
                        );
                      } else {
                        return PriceInfo(
                          payablePrice: state.cartResponse.payablePrice,
                          totalPrice: state.cartResponse.totalPrice,
                          shippingCost: state.cartResponse.shippingCost,
                        );
                      }
                    }),
              );
            } else if (state is CartAuthRequired) {
              return EmptyView(
                  message:
                      'برای مشاهده سبد خرید ابتدا وارد حساب کاربری خود شوید',
                  callToAction: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => const AuthScreen()));
                      },
                      child: const Text('ورود به حساب کاربری')),
                  image: SvgPicture.asset(
                    'assets/img/auth_required.svg',
                    width: 140,
                  ));
            } else if (state is CartEmpty) {
              return EmptyView(
                  message: 'تاکنون هیچ محصولی به سبد خرید خود اضافه نکرده اید',
                  image: SvgPicture.asset(
                    'assets/img/empty_cart.svg',
                    width: 200,
                  ));
            } else {
              throw 'State is Invalid';
            }
          },
        ),
      ),
      // ValueListenableBuilder<AuthInfo?>(
      //   valueListenable: AuthRepository.authChangeNotifier,
      //   builder: (context, authState, child) {
      //     bool isAuthenticated =
      //         authState != null && authState.accessToken.isNotEmpty;
      //     return SizedBox(
      //       width: MediaQuery.of(context).size.width,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Text(isAuthenticated
      //               ? 'خوش آمدید'
      //               : 'لطفا وارد حساب کاربری خود شوید'),
      //           isAuthenticated
      //               ? ElevatedButton(
      //                   onPressed: () {
      //                     authRepository.signOut();
      //                   },
      //                   child: const Text('خروج از حساب'))
      //               : ElevatedButton(
      //                   onPressed: () {
      //                     Navigator.of(context, rootNavigator: true).push(
      //                         MaterialPageRoute(
      //                             builder: (context) => const AuthScreen()));
      //                   },
      //                   child: const Text('ورود')),
      //           ElevatedButton(
      //               onPressed: () async {
      //                 await authRepository.refreshToken();
      //               },
      //               child: const Text('Refresh Token')),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
