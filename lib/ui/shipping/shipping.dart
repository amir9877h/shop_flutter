import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/order.dart';
import 'package:shop_flutter/data/repo/order_repository.dart';
import 'package:shop_flutter/ui/cart/price_info.dart';
import 'package:shop_flutter/ui/receipt/payment_receipt.dart';
import 'package:shop_flutter/ui/shipping/bloc/shipping_bloc.dart';

class ShippingScreen extends StatefulWidget {
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;

  const ShippingScreen(
      {super.key,
      required this.payablePrice,
      required this.shippingCost,
      required this.totalPrice});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController firstNameController = TextEditingController(text: 'تست 01');

  final TextEditingController lastNameController = TextEditingController(text: 'تستی');

  final TextEditingController phoneNumberController = TextEditingController(text: '09000000000');

  final TextEditingController postalCodeController = TextEditingController(text: '1234567890');

  final TextEditingController addressController = TextEditingController(text: 'ایران تهران تهران تهران تهران تهران تهران');

  StreamSubscription? subscription;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
        centerTitle: false,
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(repository: orderRepository);
          subscription = bloc.stream.listen((event) {
            if (event is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(event.exception.message)));
            } else if (event is ShippingSuccess) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentReceiptScreen(
                        orderId: event.result.orderId,
                      )));
            }
          });

          return bloc;
        },
        child: SingleChildScrollView(
            physics: defaultscrollphysics,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(label: Text('نام')),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: lastNameController,
                  decoration:
                      const InputDecoration(label: Text('نام خانوادگی')),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(label: Text('شماره تماس')),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: postalCodeController,
                  decoration: const InputDecoration(label: Text('کد پستی')),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(label: Text('آدرس')),
                ),
                const SizedBox(
                  height: 12,
                ),
                PriceInfo(
                    payablePrice: widget.payablePrice,
                    shippingCost: widget.shippingCost,
                    totalPrice: widget.totalPrice),
                BlocBuilder<ShippingBloc, ShippingState>(
                  builder: (context, state) {
                    return state is ShippingSuccess
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      // side: BorderSide(color: Colors.red)
                                    )),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ShippingBloc>(context).add(
                                        ShippingCreateOrder(
                                            parameters: CreateOrderParameters(
                                                firstName:
                                                    firstNameController.text,
                                                lastName:
                                                    lastNameController.text,
                                                phoneNumber:
                                                    phoneNumberController.text,
                                                postalCode:
                                                    postalCodeController.text,
                                                address: addressController.text,
                                                paymentMethod: PaymentMethod
                                                    .cashOnDelivery)));
                                  },
                                  child: const Text('پرداخت در محل')),
                              const SizedBox(
                                width: 16,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      // side: BorderSide(color: Colors.red)
                                    )),
                                    foregroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).colorScheme.primary)),
                                onPressed: () {},
                                child: const Text('پرداخت اینترنتی'),
                              ),
                            ],
                          );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
