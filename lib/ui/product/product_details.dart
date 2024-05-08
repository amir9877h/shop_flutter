import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/product.dart';
import 'package:shop_flutter/data/repo/cart_repository.dart';
import 'package:shop_flutter/theme.dart';
import 'package:shop_flutter/ui/product/bloc/product_bloc.dart';
import 'package:shop_flutter/ui/product/comment/comment_list.dart';
import 'package:shop_flutter/ui/widgets/image.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  StreamSubscription<ProductState>? stateSubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void dispose() {
    stateSubscription?.cancel();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository: cartRepository);
          stateSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              _scaffoldKey.currentState?.showSnackBar(const SnackBar(
                  // behavior: SnackBarBehavior.floating,
                  content: Text('محصول به سبد خرید افزوده شد')));
            } else if (state is ProductAddToCartError) {
              _scaffoldKey.currentState?.showSnackBar(SnackBar(
                  // behavior: SnackBarBehavior.fixed,
                  content: Text(state.exception.message)));
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return FloatingActionButton.extended(
                    backgroundColor: LightThemeColors.secondaryColor,
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context).add(
                          CartAddButtonClick(productId: widget.product.id));
                    },
                    label: state is ProductAddToCartButtonLoading
                        ? CupertinoActivityIndicator(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )
                        : const Text(
                            'افزودن به سبد خرید',
                          ),
                  );
                },
              ),
            ),
            body: CustomScrollView(
              physics: defaultscrollphysics,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  flexibleSpace: ImageLoadingService(
                    imageUrl: widget.product.imageUrl,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  foregroundColor: LightThemeColors.primaryTextColor,
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.heart))
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              widget.product.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLable,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                Text(widget.product.price.withPriceLable),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود',
                          style: TextStyle(height: 1.4),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کاربران',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton(
                                onPressed: () {}, child: const Text('ثبت نظر'))
                          ],
                        ),
                        // Container(
                        //   color: Colors.blue,
                        //   height: 1000,
                        //   width: 300,
                        // )
                      ],
                    ),
                  ),
                ),
                CommentList(productId: widget.product.id)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
