part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsLoadingState extends ProductsState {}

final class ProductsInitialState extends ProductsState {}

final class ProductsLoadedState extends ProductsState {
  final List<ProductEntity> products;

  ProductsLoadedState({required this.products});
}

final class ProductListUpdatedState extends ProductsState {
  final List<ProductEntity> products;

  ProductListUpdatedState({required this.products});
}

final class ProductErrorState extends ProductsState {
  final ExceptionEntity exception;
  ProductErrorState({required this.exception});
}
