import 'package:flutter/material.dart';
import 'package:prueba_tecnica_exito/src/core/constants/assets_path_constants.dart';
import 'package:prueba_tecnica_exito/src/core/utils/utils.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/product_entity.dart';

class ProductsListItemWidget extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onAddProduct;
  final VoidCallback onDeleteProduct;
  final List<ProductEntity> addedProducts;
  final bool expressExperience;
  const ProductsListItemWidget({
    super.key,
    required this.product,
    required this.onAddProduct,
    required this.onDeleteProduct,
    required this.addedProducts,
    required this.expressExperience,
  });

  _validateCart() {
    if (expressExperience) {
      return _ExpressExperienceCartWidget(
        addedProducts: addedProducts,
        product: product,
        onAddProduct: onAddProduct,
        onDeleteProduct: onDeleteProduct,
      );
    } else if (!addedProducts.contains(product)) {
      return _AddButton(
        product: product,
        onAddProduct: onAddProduct,
      );
    } else {
      return _QuantitySelectorWidget(
        addedProducts: addedProducts,
        onAddProduct: onAddProduct,
        onDeleteProduct: onDeleteProduct,

        product: product,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Card(
    elevation: 5,
    child: Container(
      width: 160,
      height: 169,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ImageWidget(
            product: product,
            expressExperience: expressExperience,
          ),
          _NameWidget(product: product),
          _DescriptionWidget(product: product),
          _PriceWidget(product: product),

          _validateCart(),
        ],
      ),
    ),
  );
}

class _ImageWidget extends StatelessWidget {
  final ProductEntity product;
  final bool expressExperience;
  const _ImageWidget({
    required this.product,
    required this.expressExperience,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FadeInImage.assetNetwork(
        placeholder: AssetsPathConstants.loadingGif,
        image: product.image,
        width: expressExperience ? 110 : 145,
        height: expressExperience ? 110 : 145,
      ),
    ),
  );
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
    child: Text(
      product.title,

      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    ),
  );
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.only(left: 10, right: 10, top: 6),
    child: Text(
      "Ingresa para ver más",

      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.visible,
    ),
  );
}

class _PriceWidget extends StatelessWidget {
  const _PriceWidget({
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
    child: Text(
      "\$${convertIntIntoCurrency(product.price * 1000)}",

      style: const TextStyle(
        color: Color.fromARGB(255, 225, 15, 0),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.visible,
    ),
  );
}

class _AddButton extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onAddProduct;
  const _AddButton({
    required this.product,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
    child: MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      color: Colors.deepOrange,
      minWidth: double.infinity,
      height: 50,
      onPressed: onAddProduct,
      child: const Center(
        child: Text(
          "AGREGAR",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ),
  );
}

class _QuantitySelectorWidget extends StatelessWidget {
  final List<ProductEntity> addedProducts;
  final ProductEntity product;
  final VoidCallback onAddProduct;
  final VoidCallback onDeleteProduct;
  const _QuantitySelectorWidget({
    required this.addedProducts,
    required this.product,
    required this.onAddProduct,
    required this.onDeleteProduct,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.black.withAlpha(30),
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _QuantityButtonWidget(
          icon: Icons.remove,
          onClick: onDeleteProduct,
        ),

        Text(
          "${addedProducts.where((addedProduct) => addedProduct == product).length} und",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        _QuantityButtonWidget(
          icon: Icons.add,
          onClick: onAddProduct,
        ),
      ],
    ),
  );
}

class _QuantityButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onClick;
  final Color? color;
  const _QuantityButtonWidget({
    required this.icon,
    required this.onClick,
    this.color = Colors.deepOrange,
  });

  @override
  Widget build(BuildContext context) => OutlinedButton(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: color!, width: 2),
      shape: const CircleBorder(),
      padding: EdgeInsets.zero,
      minimumSize: const Size(10, 10),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    ),
    onPressed: onClick,
    child: Icon(
      icon,
      color: color,
      size: 25,
    ),
  );
}

class _ExpressExperienceCartWidget extends StatelessWidget {
  static const _buttonPadding = EdgeInsets.all(10);
  static const _containerPadding = EdgeInsets.symmetric(horizontal: 10);
  static const _textStyle = TextStyle(color: Colors.white, fontSize: 18);
  static const _quantityTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const _borderRadius = 15.0;
  static const _iconColor = Colors.white;
  static const _buttonColor = Colors.cyan;

  final List<ProductEntity> addedProducts;
  final ProductEntity product;
  final VoidCallback onAddProduct;
  final VoidCallback onDeleteProduct;

  const _ExpressExperienceCartWidget({
    required this.addedProducts,
    required this.product,
    required this.onAddProduct,
    required this.onDeleteProduct,
  });

  _buildPurchaseButton() => Padding(
    padding: const EdgeInsets.only(bottom: 10.0, top: 5),
    child: MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      padding: _buttonPadding,
      color: _buttonColor,
      onPressed: () {},
      minWidth: double.infinity,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Comprar", style: _textStyle),
          Icon(Icons.shopping_cart_outlined, color: _iconColor),
        ],
      ),
    ),
  );

  _buildQuantityControl(int productCount) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.black.withAlpha(30),
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
    padding: _containerPadding,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: addedProducts.isNotEmpty ? onDeleteProduct : null,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text("$productCount und", style: _quantityTextStyle),
        ),
        _QuantityButtonWidget(
          icon: Icons.add,
          onClick: onAddProduct,
          color: _buttonColor,
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final productCount = addedProducts.where((p) => p == product).length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          _buildPurchaseButton(),
          const SizedBox(height: 10),
          _buildQuantityControl(productCount),
        ],
      ),
    );
  }
}
