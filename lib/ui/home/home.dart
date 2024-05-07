import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/product.dart';
import 'package:shop_flutter/data/repo/banner_repository.dart';
import 'package:shop_flutter/data/repo/product_repository.dart';
import 'package:shop_flutter/ui/home/bloc/home_bloc.dart';
import 'package:shop_flutter/ui/product/product.dart';
import 'package:shop_flutter/ui/widgets/error.dart';
import 'package:shop_flutter/ui/widgets/slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(bannerRepository, productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: ((context, state) {
            if (state is HomeSuccess) {
              return ListView.builder(
                  physics: defaultscrollphysics,
                  itemCount: 5,
                  // padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/img/nike_logo.png',
                            height: 24,
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      case 2:
                        return BannerSlider(
                          banners: state.banners,
                        );
                      case 3:
                        return _HorizontalProductList(
                          title: 'جدیدترین',
                          products: state.latestProducts,
                          onTap: () {},
                        );
                      case 4:
                        return _HorizontalProductList(
                          title: 'پربازدیدترین',
                          products: state.popularProducts,
                          onTap: () {},
                        );
                      default:
                        return Container();
                    }
                  });
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return AppErrorWidget(
                exception: state.exception,
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                },
              );
            } else {
              throw Exception('state is not supported');
            }
          })),
        ),
      ),
    );
  }
}

class _HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;

  const _HorizontalProductList({
    required this.title,
    required this.onTap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(onPressed: onTap, child: const Text('مشاهده همه')),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
              physics: defaultscrollphysics,
              padding: const EdgeInsets.only(left: 8, right: 8),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductItem(
                  product: product,
                  borderRadius: BorderRadius.circular(12),
                );
              }),
        )
      ],
    );
  }
}
