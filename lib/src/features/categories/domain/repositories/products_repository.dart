import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductEntity>> getAllProducts();
}
