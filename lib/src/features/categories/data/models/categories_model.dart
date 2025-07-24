import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/category_entity.dart';

class CategoriesModel {
  final String name;
  final String image;

  const CategoriesModel({
    required this.name,
    required this.image,
  });

  factory CategoriesModel.fromJson(String name) => CategoriesModel(
    name: name,
    image:
        "https://i.pinimg.com/474x/21/7d/ed/217ded49695719b30f24687b491d17bb.jpg",
  );

  CategoryEntity toEntity(CategoriesModel model) => CategoryEntity(
    name: model.name,
    image: model.image,
  );

  static List<CategoriesModel> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => CategoriesModel.fromJson(json)).toList();

  static List<CategoryEntity> toEntityList(List<CategoriesModel> models) =>
      models.map((model) => model.toEntity(model)).toList();
}
