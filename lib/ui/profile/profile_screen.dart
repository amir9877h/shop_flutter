import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/data/auth_info.dart';
import 'package:shop_flutter/data/repo/auth_repository.dart';
import 'package:shop_flutter/data/repo/cart_repository.dart';
import 'package:shop_flutter/ui/auth/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // authRepository.signOut();
              // CartRepository.cartItemCountNotifier.value = 0;
              // Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, authInfo, child) {
          final isLogin = authInfo != null && authInfo.accessToken.isNotEmpty;
          return Center(
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
                Text(
                  isLogin ? authInfo.email : 'کاربر مهمان',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 32,
                ),
                const Divider(
                  thickness: 0.05,
                ),
                if (isLogin)
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
                if (isLogin)
                  const Divider(
                    thickness: 0.05,
                  ),
                if (isLogin)
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
                if (isLogin)
                  const Divider(
                    thickness: 0.05,
                  ),
                InkWell(
                  onTap: () {
                    if (isLogin) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                              title: const Text('خروج از حساب کاربری'),
                              content: const Text(
                                  'آیا میخواهید از حساب خود خارج شوید؟'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('خیر')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      CartRepository
                                          .cartItemCountNotifier.value = 0;
                                      authRepository.signOut();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'خروج با موفقیت انجام شد')));
                                    },
                                    child: const Text('بله')),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      children: [
                        Icon(isLogin ? Icons.logout : Icons.login_rounded),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(isLogin
                            ? 'خروج از حساب کاربری'
                            : 'ورود به حساب کاربری'),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 0.05,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
