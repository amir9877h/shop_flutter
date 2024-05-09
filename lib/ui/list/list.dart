import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/repo/product_repository.dart';
import 'package:shop_flutter/ui/list/bloc/product_list_bloc.dart';
import 'package:shop_flutter/ui/product/product.dart';

class ProductListScreen extends StatelessWidget {
  final int sort;

  const ProductListScreen({super.key, required this.sort});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('کفش های ورزشی'),
        ),
        body: BlocProvider<ProductListBloc>(
          create: (context) => ProductListBloc(productRepository)
            ..add(ProductListStarted(sort: sort)),
          child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListSuccess) {
                final products = state.products;
                return GridView.builder(
                  physics: defaultscrollphysics,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.65,
                    crossAxisCount: 2,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItem(
                        product: product,
                        borderRadius: BorderRadius.circular(0));
                  },
                );
              } else if (state is ProductListError) {
                return Text(state.exception.message);
              } else if (state is ProductListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                throw 'Invalid state';
              }
            },
          ),
        ));
  }
}
