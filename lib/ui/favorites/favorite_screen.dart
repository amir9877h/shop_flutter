import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/favorite_manager.dart';
import 'package:shop_flutter/data/product.dart';
import 'package:shop_flutter/theme.dart';
import 'package:shop_flutter/ui/product/product_details.dart';
import 'package:shop_flutter/ui/widgets/image.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('لیست علاقه مندی ها'),
        ),
        body: ValueListenableBuilder<Box<ProductEntity>>(
            valueListenable: favoriteManager.listenable,
            builder: (context, box, child) {
              final products = box.values.toList();
              return products.isEmpty ? Center(child: Text('محصولی به علاقه مندی ها اضافه نکرده اید'),) : ListView.builder(
                physics: defaultscrollphysics,
                padding: const EdgeInsets.only(top: 8, bottom: 100),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8.0, 16, 8),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 110,
                              height: 110,
                              child: ImageLoadingService(
                                imageUrl: product.imageUrl,
                                borderRadius: BorderRadius.circular(8),
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .apply(
                                          color: LightThemeColors
                                              .primaryTextColor),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  product.previousPrice.withPriceLable,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                Text(product.price.withPriceLable),
                              ],
                            ),
                          )),
                          IconButton(
                              onPressed: () {
                                favoriteManager.removeFromFavorites(product.id);
                              },
                              icon: const Icon(
                                  Icons.remove_circle_outline_sharp)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
