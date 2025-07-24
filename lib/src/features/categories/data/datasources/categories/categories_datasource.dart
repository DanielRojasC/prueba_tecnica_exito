import 'package:prueba_tecnica_exito/src/features/categories/data/models/categories_model.dart';

abstract class CategoriesDatasource {
  Future<List<CategoriesModel>> getAllCategories();
}
