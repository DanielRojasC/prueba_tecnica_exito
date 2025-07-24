import 'package:prueba_tecnica_exito/src/features/categories/data/datasources/categories/categories_datasource.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/models/categories_model.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/category_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesDatasource datasource;

  CategoriesRepositoryImpl({required this.datasource});
  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    final modelList = await datasource.getAllCategories();

    return CategoriesModel.toEntityList(modelList);
  }
}
