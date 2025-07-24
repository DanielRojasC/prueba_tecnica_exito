import 'package:prueba_tecnica_exito/src/features/example/domain/usecases/example_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleUseCase exampleUseCase;
  ExampleBloc({required this.exampleUseCase}) : super(ExampleInitialState()) {
    on<ExampleInitialEvent>(
      (_, emit) => emit(
        ExampleInitialState(),
      ),
    );
  }

  // TODO: Example public void for handle event in bloc
  void exampleVoid() {}
}
