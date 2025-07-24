import 'package:prueba_tecnica_exito/src/core/domain/usecases/usecase.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/category_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/repositories/categories_repository.dart';

class GetAllCategoriesUsecase implements UseCase<List<CategoryEntity>, void> {
  final CategoriesRepository repository;

  GetAllCategoriesUsecase({required this.repository});
  @override
  Future<List<CategoryEntity>> call({required void params}) async =>
      repository.getAllCategories();
}
