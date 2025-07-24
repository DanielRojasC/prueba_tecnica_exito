import 'package:prueba_tecnica_exito/src/features/example/domain/entities/example_entity.dart';

class ExampleModel {
  final bool exampleModelAttribute;

  ExampleModel({required this.exampleModelAttribute});

  factory ExampleModel.fromJson(Map<String, dynamic> json) => ExampleModel(
    exampleModelAttribute: json['example_attribute'] as bool,
  );

  ExampleEntity toEntity(ExampleModel model) => ExampleEntity(
    exampleEntityAttribute: exampleModelAttribute,
  );
}
