import 'package:dio/dio.dart';
import 'package:prueba_tecnica_exito/src/core/config/env_reader.dart';
import 'package:prueba_tecnica_exito/src/core/constants/network_constants.dart';

class DioClient {
  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EnvReader.baseUrl,
      connectTimeout: const Duration(
        seconds: NetworkConstants.connectTimeout,
      ),
      receiveTimeout: const Duration(
        seconds: NetworkConstants.receiveTimeout,
      ),
      sendTimeout: const Duration(
        seconds: NetworkConstants.sendTimeout,
      ),
      contentType: NetworkConstants.contentType,
      responseType: ResponseType.json,
    ),
  );

  Dio get instance => _dio;
}
