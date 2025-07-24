import 'package:flutter/material.dart';
import 'package:prueba_tecnica_exito/src/core/constants/styles.dart';

class SearchInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const SearchInputWidget({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) => Material(
    elevation: 10,
    borderRadius: const BorderRadius.all(Radius.circular(50)),

    child: TextField(
      controller: controller,
      decoration: SearchInputDecorator.build(hint: hint),
    ),
  );
}
