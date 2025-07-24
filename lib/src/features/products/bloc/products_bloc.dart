import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_exito/src/core/error/exception.dart';
import 'package:prueba_tecnica_exito/src/core/error/exception_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/product_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/usecases/get_all_products_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetAllProductsUsecase getAllProductsUsecase;
  ProductsBloc({required this.getAllProductsUsecase})
    : super(ProductsInitialState()) {
    on<GetProductsEvent>((event, emit) => _getProducts(event, emit));
    on<AddProductToCartEvent>((event, emit) => _addProductToCart(event, emit));
    on<DeleteProductFromCartEvent>(
      (event, emit) => _deleteProductFromCart(event, emit),
    );
    on<UpdateProductListEvent>(
      (event, emit) =>
          emit(ProductListUpdatedState(products: event.addedProducts)),
    );
    on<ProductsInitialEvent>((event, emit) => emit(ProductsInitialState()));
  }

  Future<void> _getProducts(
    GetProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      emit(ProductsLoadingState());

      final List<ProductEntity> products = await getAllProductsUsecase.call(
        params: null,
      );

      emit(ProductsLoadedState(products: products));
    } on BasicException catch (e) {
      emit(
        ProductErrorState(
          exception: ExceptionEntity(
            code: e.exception.code,
            message: e.exception.message,
          ),
        ),
      );
    }
  }
}

FutureOr<void> _addProductToCart(
  AddProductToCartEvent event,
  Emitter<ProductsState> emit,
) {
  final List<ProductEntity> addedProducts = [
    ...event.addedProducts,
    event.product,
  ];

  emit(ProductListUpdatedState(products: addedProducts));
}

FutureOr<void> _deleteProductFromCart(
  DeleteProductFromCartEvent event,
  Emitter<ProductsState> emit,
) {
  final List<ProductEntity> updatedProducts = [...event.addedProducts];
  updatedProducts.removeAt(updatedProducts.lastIndexOf(event.product));

  emit(ProductListUpdatedState(products: updatedProducts.toList()));
}
