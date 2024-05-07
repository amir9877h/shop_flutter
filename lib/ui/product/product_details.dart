import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/product.dart';
import 'package:shop_flutter/theme.dart';
import 'package:shop_flutter/ui/product/comment/comment_list.dart';
import 'package:shop_flutter/ui/widgets/image.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          child: FloatingActionButton.extended(
            backgroundColor: LightThemeColors.secondaryColor,
            onPressed: () {},
            label: const Text(
              'افزودن به سبد خرید',
            ),
          ),
        ),
        body: CustomScrollView(
          physics: defaultscrollphysics,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(
                imageUrl: product.imageUrl,
                borderRadius: BorderRadius.circular(0),
              ),
              foregroundColor: LightThemeColors.primaryTextColor,
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
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
                          product.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.previousPrice.withPriceLable,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(
                                      decoration: TextDecoration.lineThrough),
                            ),
                            Text(product.price.withPriceLable),
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
            CommentList(productId: product.id)
          ],
        ),
      ),
    );
  }
}
