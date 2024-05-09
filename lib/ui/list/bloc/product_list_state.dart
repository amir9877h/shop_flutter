part of 'product_list_bloc.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

final class ProductListLoading extends ProductListState {}

final class ProductListSuccess extends ProductListState {
  final List<ProductEntity> products;
  final int sort;
  final List<String> sortNames;

  const ProductListSuccess(
      {required this.products, required this.sort, required this.sortNames});

  @override
  List<Object> get props => [products, sort, sortNames];
}

final class ProductListError extends ProductListState {
  final AppException exception;

  const ProductListError({required this.exception});

  @override
  List<Object> get props => [exception];
}
