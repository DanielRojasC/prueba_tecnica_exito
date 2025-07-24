import 'package:prueba_tecnica_exito/src/core/error/exception_entity.dart';

class BasicException implements Exception {
  final ExceptionEntity exception;

  BasicException({required this.exception});
}
