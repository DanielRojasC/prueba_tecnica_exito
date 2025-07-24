import 'dart:io';

import 'package:prueba_tecnica_exito/src/core/error/exception.dart';
import 'package:prueba_tecnica_exito/src/core/error/exception_entity.dart';
import 'package:prueba_tecnica_exito/src/core/network/dio_client.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/datasources/products/products_datasource.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/models/products_model.dart';

class ProductsDatasourceImpl implements ProductsDatasource {
  final DioClient dio;
  final _url = "/products";

  ProductsDatasourceImpl({required this.dio});

  @override
  Future<List<ProductsModel>> getAllProducts() async {
    final response = await dio.instance.get(_url);

    final responseCode = response.statusCode;

    if (responseCode == HttpStatus.ok) {
      final modelList = ProductsModel.fromJsonList(response.data);

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
