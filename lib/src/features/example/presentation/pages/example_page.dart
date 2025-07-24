import 'package:prueba_tecnica_exito/src/features/example/presentation/widgets/example1_widget.dart';
import 'package:prueba_tecnica_exito/src/features/example/presentation/widgets/example2_widget.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) => const Scaffold(
      backgroundColor: Colors.blue,
    body: SafeArea(
      child: Column(
        children: [
          Example1Widget(),
          Example2Widget(),
        ],
      ),
    ),
  );
}
