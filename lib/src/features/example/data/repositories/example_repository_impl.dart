import 'package:prueba_tecnica_exito/src/features/example/data/datasources/example_datasource.dart';
import 'package:prueba_tecnica_exito/src/features/example/domain/entities/example_entity.dart';
import 'package:prueba_tecnica_exito/src/features/example/domain/repositories/example_repository.dart';
import 'package:prueba_tecnica_exito/src/features/example/domain/usecases/params/example_params.dart';

class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleDataSource exampleDataSource;
  ExampleRepositoryImpl({required this.exampleDataSource});
  @override
  Future<ExampleEntity> exampleRequest(ExampleParams input) async {
    final userModel = await exampleDataSource.example(input);

    return userModel.toEntity(userModel);
  }
}
