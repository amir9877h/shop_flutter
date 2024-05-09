import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/data/repo/auth_repository.dart';
import 'package:shop_flutter/data/repo/cart_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authRepository.signOut();
              CartRepository.cartItemCountNotifier.value = 0;
              // Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 65,
                height: 65,
                margin: const EdgeInsets.only(top: 32, bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).dividerColor, width: 0.1),
                ),
                child: Image.asset('assets/img/nike_logo.png')),
            const Text('Email'),
            const SizedBox(
              height: 32,
            ),
            const Divider(
              thickness: 0.05,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.heart),
                    SizedBox(
                      width: 16,
                    ),
                    Text('لیست علاقه مندهی ها'),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 0.05,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.shopping_cart),
                    SizedBox(
                      width: 16,
                    ),
                    Text('سوابق سفارش'),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
