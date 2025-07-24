import 'package:prueba_tecnica_exito/src/features/categories/data/models/products_model.dart';

abstract class ProductsDatasource {
  Future<List<ProductsModel>> getAllProducts();
}
