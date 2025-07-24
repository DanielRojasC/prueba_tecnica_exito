import 'package:prueba_tecnica_exito/src/core/domain/usecases/usecase.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/product_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/repositories/products_repository.dart';

class GetAllProductsUsecase implements UseCase<List<ProductEntity>, void> {
  final ProductsRepository repository;

  GetAllProductsUsecase({required this.repository});
  @override
  Future<List<ProductEntity>> call({required void params}) async =>
      repository.getAllProducts();
}
