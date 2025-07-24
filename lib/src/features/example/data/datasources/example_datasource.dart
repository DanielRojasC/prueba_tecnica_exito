import 'package:prueba_tecnica_exito/src/features/example/data/models/example_model.dart';
import 'package:prueba_tecnica_exito/src/features/example/domain/usecases/params/example_params.dart';

abstract class ExampleDataSource {
  Future<ExampleModel> example(ExampleParams input);
}
