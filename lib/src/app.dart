import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica_exito/src/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:prueba_tecnica_exito/src/features/products/bloc/products_bloc.dart';
import 'package:prueba_tecnica_exito/src/injector.dart';

class PruebaTecnicaExitoApp extends StatefulWidget {
  const PruebaTecnicaExitoApp({super.key});

  @override
  State<PruebaTecnicaExitoApp> createState() => _PruebaTecnicaExitoAppState();
}

class _PruebaTecnicaExitoAppState extends State<PruebaTecnicaExitoApp> {
  @override
  Widget build(BuildContext context) {
    final productsBloc = sl<ProductsBloc>();

    final categoriesBloc = sl<CategoriesBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => productsBloc..add(ProductsInitialEvent()),
        ),
        BlocProvider(
          create: (context) => categoriesBloc..add(CategoriesInitialEvent()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Roboto",
        ),

        routerConfig: sl<GoRouter>(),
      ),
    );
  }
}
