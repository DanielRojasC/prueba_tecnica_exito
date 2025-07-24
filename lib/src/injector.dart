import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica_exito/src/core/network/dio_client.dart';
import 'package:prueba_tecnica_exito/src/core/router/router.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/datasources/categories/categores_datasource_impl.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/datasources/categories/categories_datasource.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/datasources/products/products_datasource.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/datasources/products/products_datasource_impl.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:prueba_tecnica_exito/src/features/categories/data/repositories/products_repository_impl.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/repositories/products_repository.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/usecases/get_all_products_usecase.dart';
import 'package:prueba_tecnica_exito/src/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:prueba_tecnica_exito/src/features/products/bloc/products_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await _registerCore();
  await _registerRoutes();
  await _registerDatasources();
  await _registerRepositories();
  await _registerUseCases();
  await _registerBlocs();
}

Future<void> _registerCore() async => sl.registerLazySingleton<DioClient>(
  () => DioClient(),
);

Future<void> _registerRoutes() async =>
    sl.registerLazySingleton<GoRouter>(() => router);

Future<void> _registerDatasources() async {
  sl.registerLazySingleton<ProductsDatasource>(
    () => ProductsDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<CategoriesDatasource>(
    () => CategoriesDatasourceImpl(dio: sl()),
  );
}

Future<void> _registerRepositories() async {
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(datasource: sl()),
  );
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(datasource: sl()),
  );
}

Future<void> _registerUseCases() async {
  sl.registerLazySingleton<GetAllProductsUsecase>(
    () => GetAllProductsUsecase(repository: sl()),
  );
  sl.registerLazySingleton<GetAllCategoriesUsecase>(
    () => GetAllCategoriesUsecase(repository: sl()),
  );
}

Future<void> _registerBlocs() async {
  sl.registerFactory<ProductsBloc>(
    () => ProductsBloc(getAllProductsUsecase: sl()),
  );
  sl.registerFactory<CategoriesBloc>(
    () => CategoriesBloc(getAllCategoriesUsecase: sl()),
  );
}
