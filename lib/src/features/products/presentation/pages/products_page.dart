import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_exito/src/core/constants/styles.dart';
import 'package:prueba_tecnica_exito/src/core/utils/utils.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/category_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/product_entity.dart';
import 'package:prueba_tecnica_exito/src/features/products/bloc/products_bloc.dart';
import 'package:prueba_tecnica_exito/src/features/products/presentation/widget/products_list_item_widget.dart';
import 'package:prueba_tecnica_exito/src/shared/custom_appbar_widget.dart';
import 'package:prueba_tecnica_exito/src/shared/deliver_mode_banner_widget.dart';
import 'package:prueba_tecnica_exito/src/shared/inputs/search_input_widget.dart';
import 'package:prueba_tecnica_exito/src/shared/loading_widget.dart';

class ProductsPage extends StatefulWidget {
  final CategoryEntity category;
  final bool expressExperience;
  const ProductsPage({
    super.key,
    required this.category,
    required this.expressExperience,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _searchInputController = TextEditingController();
  List<ProductEntity> _products = [];
  List<ProductEntity> _originalProductsList = [];
  ProductsState _addedProductsState = ProductsInitialState();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchInputController.addListener(_searchInputListener);
    _loadInitialProducts();
  }

  void _loadInitialProducts() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<ProductsBloc>().state;
      if (state is ProductListUpdatedState) {
        _addedProductsState = state;
      }
      context.read<ProductsBloc>().add(GetProductsEvent());
    });
  }

  void _searchInputListener() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      if (_searchInputController.text.isEmpty) {
        _resetProducts();
      } else {
        _filterProducts(_searchInputController.text.toLowerCase());
      }
    });
  }

  void _resetProducts() {
    setState(() => _products = List.from(_originalProductsList));
  }

  void _filterProducts(String query) {
    setState(() {
      _products = _originalProductsList
          .where((product) => product.title.toLowerCase().contains(query))
          .toList();
    });
  }

  void _handleStateChange(BuildContext context, ProductsState state) {
    if (state is ProductErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.exception.message)),
      );
    }
    if (state is ProductsLoadedState) {
      _updateProducts(state.products);
    }
  }

  void _updateProducts(List<ProductEntity> products) {
    setState(() {
      _originalProductsList = products;
      _products = List.from(products);
    });
    _validatePreviousState();
  }

  void _validatePreviousState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_addedProductsState is ProductListUpdatedState) {
        context.read<ProductsBloc>().add(
          UpdateProductListEvent(
            addedProducts:
                (_addedProductsState as ProductListUpdatedState).products,
          ),
        );
      } else {
        context.read<ProductsBloc>().add(ProductsInitialEvent());
      }
    });
  }

  void _handleProductCartAction(
    ProductEntity product,
    bool isAdding,
  ) {
    final state = context.read<ProductsBloc>().state;
    final List<ProductEntity> products = state is ProductListUpdatedState
        ? state.products
        : [];

    final event = isAdding
        ? AddProductToCartEvent(product: product, addedProducts: products)
        : DeleteProductFromCartEvent(product: product, addedProducts: products);

    context.read<ProductsBloc>().add(event);
  }

  _buildContent(ProductsState state) {
    if (state is ProductsLoadingState) {
      return const LoadingWidget();
    }
    if (state is ProductsLoadedState) {
      return _buildLoadedContent();
    }

    return _buildDefaultContent();
  }

  _buildLoadedContent() => const SizedBox();

  _buildDefaultContent() {
    final filteredProducts = _products
        .where((product) => product.category == widget.category.name)
        .toList();

    return filteredProducts.isEmpty
        ? const Center(child: Text("No hay productos"))
        : _ProductPageContentWidget(
            addedProducts: _addedProductsState is ProductListUpdatedState
                ? (_addedProductsState as ProductListUpdatedState).products
                : [],
            products: filteredProducts,
            categoryName: widget.category.name,
            onAddProduct: (product) => _handleProductCartAction(product, true),
            onDeleteProduct: (product) =>
                _handleProductCartAction(product, false),
            expressExperience: widget.expressExperience,
          );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchInputController.removeListener(_searchInputListener);
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor,
    appBar: MainAppbarWidget(
      centerWidget: SearchInputWidget(
        controller: _searchInputController,
        hint: "¿Qué buscas?",
      ),
      showBackButton: true,
      actions: const _CartWidget(),
    ),
    body: SafeArea(
      child: BlocConsumer<ProductsBloc, ProductsState>(
        listener: _handleStateChange,
        builder: (context, state) => _buildContent(state),
      ),
    ),
  );
}

class _CartWidget extends StatelessWidget {
  const _CartWidget();

  @override
  Widget build(BuildContext context) => const Badge(
    backgroundColor: Colors.deepOrange,
    label: Text(
      "999",
      style: TextStyle(color: Colors.white),
    ),
    child: Icon(
      Icons.shopping_cart_outlined,
      color: Colors.black,
      size: 30,
    ),
  );
}

class _ProductPageContentWidget extends StatelessWidget {
  final List<ProductEntity> products;
  final List<ProductEntity> addedProducts;
  final String categoryName;
  final Function(ProductEntity) onAddProduct;
  final Function(ProductEntity) onDeleteProduct;
  final bool expressExperience;

  const _ProductPageContentWidget({
    required this.products,
    required this.addedProducts,
    required this.categoryName,
    required this.onAddProduct,
    required this.onDeleteProduct,
    required this.expressExperience,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const DeliveryModeBannerWidget(
        text: "Katerine recíbelo en Cra 74 a # 27-47 bloque 3 apartamento 205",
      ),

      Expanded(
        child: _ProductsListWidget(
          categoryName: categoryName,
          addedProducts: addedProducts,
          products: products,
          onAddProduct: (product) => onAddProduct(product),
          onDeleteProduct: (product) => onDeleteProduct(product),
          expressExperience: expressExperience,
        ),
      ),
    ],
  );
}

class _ProductsListHeaderWidget extends StatelessWidget {
  const _ProductsListHeaderWidget({
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      child: Text(
        categoryName.capitalize(),
        style: const TextStyle(
          color: Color(0xff575859),
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

class _ProductsListWidget extends StatelessWidget {
  final Function onAddProduct;
  final Function onDeleteProduct;
  final String categoryName;
  final List<ProductEntity> products;
  final List<ProductEntity> addedProducts;
  final bool expressExperience;

  const _ProductsListWidget({
    required this.categoryName,
    required this.products,
    required this.addedProducts,
    required this.onAddProduct,
    required this.onDeleteProduct,
    required this.expressExperience,
  });

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      _ProductsListHeaderWidget(
        categoryName: categoryName,
      ),
      _ProductsListContentWidget(
        products: products,
        addedProducts: addedProducts,
        onAddProduct: (product) => onAddProduct(product),
        onDeleteProduct: (product) => onDeleteProduct(product),
        expressExperience: expressExperience,
      ),
    ],
  );
}

class _ProductsListContentWidget extends StatelessWidget {
  final List<ProductEntity> products;
  final List<ProductEntity> addedProducts;
  final ValueChanged<ProductEntity> onAddProduct;
  final ValueChanged<ProductEntity> onDeleteProduct;
  final bool expressExperience;

  const _ProductsListContentWidget({
    required this.products,
    required this.addedProducts,
    required this.onAddProduct,
    required this.onDeleteProduct,
    required this.expressExperience,
  });

  Widget _buildProductItem(BuildContext context, int index) =>
      BlocSelector<ProductsBloc, ProductsState, List<ProductEntity>>(
        selector: _selectAddedProducts,
        builder: (context, updatedProducts) {
          final product = products[index];

          return ProductsListItemWidget(
            product: product,
            onAddProduct: () => onAddProduct(product),
            onDeleteProduct: () => onDeleteProduct(product),
            addedProducts: updatedProducts,
            expressExperience: expressExperience,
          );
        },
      );

  List<ProductEntity> _selectAddedProducts(ProductsState state) =>
      state is ProductListUpdatedState ? state.products : addedProducts;

  @override
  Widget build(BuildContext context) => SliverGrid(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.53,
    ),
    delegate: SliverChildBuilderDelegate(
      (context, index) => _buildProductItem(context, index),
      childCount: products.length,
    ),
  );
}
