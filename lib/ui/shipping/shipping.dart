import 'package:flutter/material.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/ui/cart/price_info.dart';

class ShippingScreen extends StatelessWidget {
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;

  const ShippingScreen(
      {super.key,
      required this.payablePrice,
      required this.shippingCost,
      required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          physics: defaultscrollphysics,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TextField(
                decoration: InputDecoration(label: Text('نام و نام خانوادگی')),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                decoration: InputDecoration(label: Text('شماره تماس')),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                decoration: InputDecoration(label: Text('کد پستی')),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                decoration: InputDecoration(label: Text('آدرس')),
              ),
              const SizedBox(
                height: 12,
              ),
              PriceInfo(
                  payablePrice: payablePrice,
                  shippingCost: shippingCost,
                  totalPrice: totalPrice),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          // side: BorderSide(color: Colors.red)
                        )),
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         const PaymentReceiptScreen()));
                      },
                      child: const Text('پرداخت در محل')),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          // side: BorderSide(color: Colors.red)
                        )),
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.onPrimary),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary)),
                    onPressed: () {},
                    child: const Text('پرداخت اینترنتی'),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
