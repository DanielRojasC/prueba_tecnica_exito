import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<List<CategoryEntity>> getAllCategories();
}
