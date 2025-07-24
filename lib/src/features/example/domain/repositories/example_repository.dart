import 'package:prueba_tecnica_exito/src/features/example/domain/entities/example_entity.dart';
import 'package:prueba_tecnica_exito/src/features/example/domain/usecases/params/example_params.dart';

abstract class ExampleRepository {
  Future<ExampleEntity> exampleRequest(ExampleParams params);
}
