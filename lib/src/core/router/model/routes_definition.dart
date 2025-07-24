import "package:prueba_tecnica_exito/src/core/router/model/app_route.dart";

abstract class RoutePaths {
  static final mainRoute = AppRoute(
    name: "main",
    path: "/main",
  );
  static final categoryRoute = AppRoute(
    name: "category",
    path: "/category",
  );
}
