import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica_exito/src/core/router/model/routes_definition.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/category_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/presentation/pages/categories_page.dart';
import 'package:prueba_tecnica_exito/src/features/products/presentation/pages/products_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePaths.mainRoute.path,
  routes: appRoutes,
);

List<RouteBase> get appRoutes => [
  GoRoute(
    name: RoutePaths.mainRoute.name,
    path: RoutePaths.mainRoute.path,
    builder: (context, state) => const CategoriesPage(),
  ),

  GoRoute(
    name: RoutePaths.categoryRoute.name,
    path: RoutePaths.categoryRoute.path,
    builder: (context, state) => ProductsPage(
      category: (state.extra! as Map<Object, Object>)["category"] as CategoryEntity,
      expressExperience:
          (state.extra! as Map<Object, Object>)["canEnableExpressExperience"] as bool,
    ),
  ),
];
