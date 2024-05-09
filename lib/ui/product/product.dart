import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/product.dart';
import 'package:shop_flutter/ui/product/product_details.dart';
import 'package:shop_flutter/ui/widgets/image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.borderRadius,
    this.itemWidth = 176,
    this.itemHeight = 189,
  });

  final ProductEntity product;
  final BorderRadius borderRadius;

  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product)));
        },
        child: SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 0.93,
                    child: ImageLoadingService(
                        imageUrl: product.imageUrl, borderRadius: borderRadius),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(
                        CupertinoIcons.heart,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 12,
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Text(
                  product.previousPrice.withPriceLable,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(decoration: TextDecoration.lineThrough),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
                child: Text(product.price.withPriceLable),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
