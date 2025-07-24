import 'dart:io';

import 'package:prueba_tecnica_exito/src/core/error/exception.dart';
import 'package:prueba_tecnica_exito/src/core/error/exception_entity.dart';
import 'package:prueba_tecnica_exito/src/core/network/dio_client.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/datasources/categories/categories_datasource.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/models/categories_model.dart';

class CategoriesDatasourceImpl implements CategoriesDatasource {
  final DioClient dio;
  final _url = "/products/categories";

  CategoriesDatasourceImpl({required this.dio});

  @override
  Future<List<CategoriesModel>> getAllCategories() async {
    final response = await dio.instance.get(_url);

    final responseCode = response.statusCode;

    if (responseCode == HttpStatus.ok) {
      final modelList = CategoriesModel.fromJsonList(response.data);

      return modelList;
    }

    throw BasicException(
      exception: ExceptionEntity(
        code: responseCode.toString(),
        message: response.data,
      ),
    );
  }
}
