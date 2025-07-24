import 'dart:io';

import 'package:prueba_tecnica_exito/src/core/network/dio_client.dart';
import 'package:prueba_tecnica_exito/src/features/example/data/datasources/example_datasource.dart';
import 'package:prueba_tecnica_exito/src/features/example/data/models/example_model.dart';
import 'package:prueba_tecnica_exito/src/features/example/domain/usecases/params/example_params.dart';

class ExampleDataSourceImpl implements ExampleDataSource {
  final DioClient dio;
  ExampleDataSourceImpl({required this.dio});

  @override
  Future<ExampleModel> example(ExampleParams input) async {
    final response = await dio.instance.get("path");
    final responseCode = response.statusCode;

    if (responseCode == HttpStatus.ok) {
      final model = ExampleModel.fromJson(response.data);

      return model;
    }

    throw Exception("");
  }
}
