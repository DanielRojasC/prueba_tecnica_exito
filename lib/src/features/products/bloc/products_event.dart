part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

final class GetProductsEvent extends ProductsEvent {}

final class ProductsInitialEvent extends ProductsEvent {}

final class AddProductToCartEvent extends ProductsEvent {
  final List<ProductEntity> addedProducts;
  final ProductEntity product;

  AddProductToCartEvent({required this.product, required this.addedProducts});
}

final class DeleteProductFromCartEvent extends ProductsEvent {
  final List<ProductEntity> addedProducts;
  final ProductEntity product;

  DeleteProductFromCartEvent({
    required this.product,
    required this.addedProducts,
  });
}

final class UpdateProductListEvent extends ProductsEvent {
  final List<ProductEntity> addedProducts;

  UpdateProductListEvent({
    required this.addedProducts,
  });
}
