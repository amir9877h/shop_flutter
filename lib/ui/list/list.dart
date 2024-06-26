import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/product.dart';
import 'package:shop_flutter/data/repo/product_repository.dart';
import 'package:shop_flutter/ui/list/bloc/product_list_bloc.dart';
import 'package:shop_flutter/ui/product/product.dart';

class ProductListScreen extends StatefulWidget {
  final int sort;

  const ProductListScreen({super.key, required this.sort});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum ProductViewType {
  grid,
  list,
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? bloc;
  ProductViewType productViewType = ProductViewType.list;

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('کفش های ورزشی'),
        ),
        body: BlocProvider<ProductListBloc>(
          create: (context) {
            bloc = ProductListBloc(productRepository)
              ..add(ProductListStarted(sort: widget.sort));
            return bloc!;
          },
          child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListSuccess) {
                final products = state.products;
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 0.05)),
                          color: Theme.of(context).colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 5,
                                color: Colors.black.withOpacity(0.2))
                          ]),
                      height: 56,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                //Container()
                                height: 300,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 24.0, bottom: 24),
                                  child: Column(
                                    children: [
                                      Text(
                                        'انتخاب نوع مرتب سازی',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: state.sortNames.length,
                                          itemBuilder: (context, index) {
                                            final selectedSortIndex =
                                                state.sort;
                                            return InkWell(
                                              onTap: () {
                                                bloc!.add(ProductListStarted(
                                                    sort: index));
                                                Navigator.of(context).pop();
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 8, 16, 8),
                                                child: SizedBox(
                                                  height: 24,
                                                  child: Row(
                                                    children: [
                                                      Text(state
                                                          .sortNames[index]),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      if (index ==
                                                          selectedSortIndex)
                                                        Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled_solid,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.sort)),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('مرتب سازی'),
                                        Text(
                                          ProductSort.names[state.sort],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        )
                                      ],
                                    )
                                  ]),
                            )),
                            Container(
                              width: 0.05,
                              color: Theme.of(context).dividerColor,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      productViewType = productViewType ==
                                              ProductViewType.grid
                                          ? ProductViewType.list
                                          : ProductViewType.grid;
                                    });
                                  },
                                  icon: productViewType == ProductViewType.list
                                      ? const Icon(
                                          CupertinoIcons.square_grid_2x2)
                                      : const Icon(CupertinoIcons
                                          .list_bullet_below_rectangle)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        physics: defaultscrollphysics,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.65,
                          crossAxisCount:
                              productViewType == ProductViewType.grid ? 2 : 1,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductItem(
                              product: product,
                              borderRadius: BorderRadius.circular(0));
                        },
                      ),
                    ),
                  ],
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
