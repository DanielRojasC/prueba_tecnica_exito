import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int idProduct;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  @override
  List<Object> get props => [
    idProduct,
    title,
    price,
    description,
    category,
    image,
  ];

  const ProductEntity({
    required this.idProduct,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });
}
