import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/product_entity.dart';

class ProductsModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  const ProductsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    id: json['id'],
    title: json['title'],
    price: (json['price'] as num).toDouble(),
    description: json['description'],
    category: json['category'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,
  };

  ProductEntity toEntity() => ProductEntity(
    idProduct: id,
    title: title,
    price: price,
    description: description,
    category: category,
    image: image,
  );

  static List<ProductsModel> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => ProductsModel.fromJson(json)).toList();

  static List<ProductEntity> toEntityList(List<ProductsModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
