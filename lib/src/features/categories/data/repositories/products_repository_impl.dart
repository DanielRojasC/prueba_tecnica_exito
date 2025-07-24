import 'package:prueba_tecnica_exito/src/features/categories/data/datasources/products/products_datasource.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/models/products_model.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/product_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDatasource datasource;

  ProductsRepositoryImpl({required this.datasource});
  @override
  Future<List<ProductEntity>> getAllProducts() async {
    final modelList = await datasource.getAllProducts();

    return ProductsModel.toEntityList(modelList);
  }
}
