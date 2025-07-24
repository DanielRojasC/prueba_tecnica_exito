import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prueba_tecnica_exito/src/app.dart';
import 'package:prueba_tecnica_exito/src/core/config/env_paths.dart';
import 'package:prueba_tecnica_exito/src/injector.dart';

void main() async {
  await dotenv.load(fileName: EnvPaths.dev);
  await initDependencies();

  runApp(const PruebaTecnicaExitoApp());
}
