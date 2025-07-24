import 'package:flutter/widgets.dart';

class AppRoute {
  final String name;
  final String path;
  final String label;
  final Icon? icon;

  AppRoute({
    required this.name,
    required this.path,
    this.label = "",
    this.icon,
  });
}
