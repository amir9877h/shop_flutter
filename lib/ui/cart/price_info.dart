import 'package:flutter/material.dart';
import 'package:shop_flutter/common/utils.dart';

class PriceInfo extends StatelessWidget {
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;

  const PriceInfo(
      {super.key,
      required this.payablePrice,
      required this.totalPrice,
      required this.shippingCost});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),
          child: Text(
            'جزئیات خرید',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 32),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1))
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12, 8, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ کل خرید'),
                    RichText(
                        text: TextSpan(
                            text: totalPrice.separateByComma,
                            style: DefaultTextStyle.of(context).style,
                            children: const [
                          TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.normal))
                        ]))
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 0.05,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12, 8, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('تخفیف'),
                    RichText(
                        text: TextSpan(
                            text: (totalPrice - payablePrice).separateByComma,
                            style: DefaultTextStyle.of(context).style,
                            children: const [
                          TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.normal))
                        ]))
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 0.05,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('هزینه ارسال'),
                    Text(
                      shippingCost.withPriceLable,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 0.05,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ قابل پرداخت'),
                    RichText(
                        text: TextSpan(
                            text: payablePrice.separateByComma,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            children: const [
                          TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.normal))
                        ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
