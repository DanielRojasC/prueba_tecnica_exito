import 'package:prueba_tecnica_exito/src/core/domain/usecases/usecase.dart';
import 'package:prueba_tecnica_exito/src/features/example/domain/entities/example_entity.dart';
import 'package:prueba_tecnica_exito/src/features/example/domain/repositories/example_repository.dart';
import 'package:prueba_tecnica_exito/src/features/example/domain/usecases/params/example_params.dart';

class ExampleUseCase implements UseCase<ExampleEntity, ExampleParams> {
  final ExampleRepository exampleRepository;
  ExampleUseCase({required this.exampleRepository});
  @override
  Future<ExampleEntity> call({required ExampleParams params}) async =>
      exampleRepository.exampleRequest(params);
}
